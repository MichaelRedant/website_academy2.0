import fs from "node:fs";
import fsp from "node:fs/promises";
import path from "node:path";
import { chromium } from "playwright";

const BASE_URL = process.env.ACADEMY_BASE_URL || "http://127.0.0.1:8000";
const PATHS = ["/", "/cursussen", "/lessen", "/certificaat-verificatie"];

const THRESHOLDS = {
  fcpMs: 2000,
  lcpMs: 2500,
  cls: 0.1,
  ttfbMs: 800,
  domContentLoadedMs: 2500,
  loadMs: 5000,
};

function pickEdgePath() {
  const candidates = [
    "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
    "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
    "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
    "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
  ];

  return candidates.find((candidate) => fs.existsSync(candidate));
}

function round(value, digits = 2) {
  if (value == null || Number.isNaN(value)) {
    return null;
  }

  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

function isWithinThreshold(value, threshold) {
  if (value == null || Number.isNaN(value)) {
    return false;
  }

  return value <= threshold;
}

async function capturePath(page, pagePath) {
  await page.goto(pagePath, { waitUntil: "load", timeout: 120_000 });
  await page.waitForTimeout(2500);

  const metrics = await page.evaluate(() => {
    const nav = performance.getEntriesByType("navigation")[0];
    const vitals = window.__academyVitals || {};

    return {
      fcpMs: vitals.fcp || 0,
      lcpMs: vitals.lcp || 0,
      cls: vitals.cls || 0,
      ttfbMs: nav?.responseStart || 0,
      domContentLoadedMs: nav?.domContentLoadedEventEnd || 0,
      loadMs: nav?.loadEventEnd || 0,
    };
  });

  return {
    path: pagePath,
    fcpMs: round(metrics.fcpMs),
    lcpMs: round(metrics.lcpMs),
    cls: round(metrics.cls, 4),
    ttfbMs: round(metrics.ttfbMs),
    domContentLoadedMs: round(metrics.domContentLoadedMs),
    loadMs: round(metrics.loadMs),
  };
}

async function warmupPath(page, pagePath) {
  await page.goto(pagePath, { waitUntil: "domcontentloaded", timeout: 120_000 });
  await page.waitForTimeout(300);
}

function buildChecks(row) {
  return {
    fcpOk: isWithinThreshold(row.fcpMs, THRESHOLDS.fcpMs),
    lcpOk: isWithinThreshold(row.lcpMs, THRESHOLDS.lcpMs),
    clsOk: isWithinThreshold(row.cls, THRESHOLDS.cls),
    ttfbOk: isWithinThreshold(row.ttfbMs, THRESHOLDS.ttfbMs),
    domContentLoadedOk: isWithinThreshold(row.domContentLoadedMs, THRESHOLDS.domContentLoadedMs),
    loadOk: isWithinThreshold(row.loadMs, THRESHOLDS.loadMs),
  };
}

async function main() {
  const executablePath = pickEdgePath();
  const browser = await chromium.launch({
    headless: true,
    executablePath,
    args: ["--no-sandbox", "--disable-dev-shm-usage"],
  });

  const context = await browser.newContext({
    baseURL: BASE_URL,
  });
  const page = await context.newPage();

  await page.addInitScript(() => {
    window.__academyVitals = {
      fcp: 0,
      lcp: 0,
      cls: 0,
    };

    try {
      new PerformanceObserver((entryList) => {
        for (const entry of entryList.getEntries()) {
          if (entry.name === "first-contentful-paint") {
            window.__academyVitals.fcp = entry.startTime;
          }
        }
      }).observe({ type: "paint", buffered: true });
    } catch {
      // Ignore if unsupported.
    }

    try {
      new PerformanceObserver((entryList) => {
        const entries = entryList.getEntries();
        const latest = entries[entries.length - 1];
        if (latest) {
          window.__academyVitals.lcp = latest.startTime;
        }
      }).observe({ type: "largest-contentful-paint", buffered: true });
    } catch {
      // Ignore if unsupported.
    }

    try {
      new PerformanceObserver((entryList) => {
        for (const entry of entryList.getEntries()) {
          if (!entry.hadRecentInput) {
            window.__academyVitals.cls += entry.value;
          }
        }
      }).observe({ type: "layout-shift", buffered: true });
    } catch {
      // Ignore if unsupported.
    }
  });

  // Warm-up pass to avoid one-off bootstrap overhead on the first hit.
  for (const pagePath of PATHS) {
    await warmupPath(page, pagePath);
  }

  const rows = [];
  for (const pagePath of PATHS) {
    rows.push(await capturePath(page, pagePath));
  }

  await context.close();
  await browser.close();

  const withChecks = rows.map((row) => ({
    ...row,
    checks: buildChecks(row),
  }));

  const hasFailure = withChecks.some((row) => Object.values(row.checks).some((check) => !check));
  const generatedAt = new Date().toISOString();
  const outputDir = path.resolve("audit");
  await fsp.mkdir(outputDir, { recursive: true });

  await fsp.writeFile(
    path.join(outputDir, "qa_performance_smoke.json"),
    JSON.stringify(
      {
        generatedAt,
        baseUrl: BASE_URL,
        warmup: true,
        thresholds: THRESHOLDS,
        rows: withChecks,
      },
      null,
      2
    ),
    "utf8"
  );

  const lines = [
    "# QA Performance Smoke",
    "",
    `- Generated at: \`${generatedAt}\``,
    `- Base URL: \`${BASE_URL}\``,
    "- Warm-up pass: enabled (all paths loaded once before measured pass).",
    "",
    "## Thresholds",
    "",
    `- FCP <= ${THRESHOLDS.fcpMs}ms`,
    `- LCP <= ${THRESHOLDS.lcpMs}ms`,
    `- CLS <= ${THRESHOLDS.cls}`,
    `- TTFB <= ${THRESHOLDS.ttfbMs}ms`,
    `- DCL <= ${THRESHOLDS.domContentLoadedMs}ms`,
    `- Load <= ${THRESHOLDS.loadMs}ms`,
    "",
    "| Path | FCP | LCP | CLS | TTFB | DCL | Load | Status |",
    "| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |",
  ];

  for (const row of withChecks) {
    const status = Object.values(row.checks).every(Boolean) ? "PASS" : "FAIL";
    lines.push(
      `| \`${row.path}\` | ${row.fcpMs ?? "n/a"} | ${row.lcpMs ?? "n/a"} | ${row.cls ?? "n/a"} | ${row.ttfbMs ?? "n/a"} | ${row.domContentLoadedMs ?? "n/a"} | ${row.loadMs ?? "n/a"} | ${status} |`
    );
  }

  await fsp.writeFile(path.join(outputDir, "qa_performance_smoke.md"), `${lines.join("\n")}\n`, "utf8");

  if (hasFailure) {
    console.error("Performance smoke failed. See audit/qa_performance_smoke.md");
    process.exit(1);
  }

  console.log("Performance smoke passed.");
  console.log("- audit/qa_performance_smoke.json");
  console.log("- audit/qa_performance_smoke.md");
}

main().catch((error) => {
  console.error("Failed to run performance smoke.");
  console.error(error);
  process.exit(1);
});
