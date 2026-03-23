import fs from "node:fs/promises";
import fsSync from "node:fs";
import path from "node:path";
import { chromium } from "playwright";

const URLS = [
  "https://academy.octopus.be/nl/",
  "https://academy.octopus.be/nl/cursussen/",
  "https://academy.octopus.be/nl/how-tos/",
  "https://academy.octopus.be/nl/my-account/",
];

function pickEdgePath() {
  const candidates = [
    "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe",
    "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
    "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
    "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
  ];
  return candidates.find((candidate) => fsSync.existsSync(candidate));
}

function round(value, digits = 2) {
  if (value == null || Number.isNaN(value)) return null;
  const factor = 10 ** digits;
  return Math.round(value * factor) / factor;
}

async function captureUrl(page, url) {
  await page.goto(url, { waitUntil: "load", timeout: 120000 });
  await page.waitForTimeout(6000);

  return page.evaluate(() => {
    const metrics = window.__academyVitals || {
      lcp: 0,
      cls: 0,
      fcp: 0,
      navigationTtfb: 0,
      navigationDomContentLoaded: 0,
      navigationLoad: 0,
    };

    const nav = performance.getEntriesByType("navigation")[0];
    if (nav) {
      metrics.navigationTtfb = nav.responseStart || metrics.navigationTtfb || 0;
      metrics.navigationDomContentLoaded = nav.domContentLoadedEventEnd || metrics.navigationDomContentLoaded || 0;
      metrics.navigationLoad = nav.loadEventEnd || metrics.navigationLoad || 0;
    }

    return metrics;
  });
}

async function main() {
  const executablePath = pickEdgePath();

  const browser = await chromium.launch({
    headless: true,
    executablePath,
    args: ["--no-sandbox", "--disable-dev-shm-usage"],
  });

  const context = await browser.newContext();
  const page = await context.newPage();
  await page.addInitScript(() => {
    window.__academyVitals = {
      lcp: 0,
      cls: 0,
      fcp: 0,
      navigationTtfb: 0,
      navigationDomContentLoaded: 0,
      navigationLoad: 0,
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
      // Ignore.
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
      // Ignore.
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
      // Ignore.
    }
  });
  const rows = [];

  for (const url of URLS) {
    const vitals = await captureUrl(page, url);
    rows.push({
      url,
      lcp_ms: round(vitals.lcp),
      cls: round(vitals.cls, 4),
      fcp_ms: round(vitals.fcp),
      ttfb_ms: round(vitals.navigationTtfb),
      dom_content_loaded_ms: round(vitals.navigationDomContentLoaded),
      load_ms: round(vitals.navigationLoad),
      inp_ms: null,
      notes: "INP not measured in this automated non-interactive run.",
    });
  }

  await context.close();
  await browser.close();

  const outDir = path.resolve("audit");
  await fs.mkdir(outDir, { recursive: true });

  const generatedAt = new Date().toISOString();
  const jsonPath = path.join(outDir, "cwv_lab.json");
  await fs.writeFile(jsonPath, JSON.stringify({ generatedAt, rows }, null, 2), "utf8");

  const mdLines = [
    "# Core Web Vitals Lab Baseline",
    "",
    `- Generated at: \`${generatedAt}\``,
    "- Method: Playwright (headless browser, lab run).",
    "- Note: INP is not reliable in non-interactive scripted runs and is marked as `n/a`.",
    "",
    "| URL | FCP (ms) | LCP (ms) | CLS | TTFB (ms) | DCL (ms) | Load (ms) | INP |",
    "| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |",
  ];

  for (const row of rows) {
    mdLines.push(
      `| \`${row.url}\` | ${row.fcp_ms ?? "n/a"} | ${row.lcp_ms ?? "n/a"} | ${row.cls ?? "n/a"} | ${row.ttfb_ms ?? "n/a"} | ${row.dom_content_loaded_ms ?? "n/a"} | ${row.load_ms ?? "n/a"} | n/a |`
    );
  }

  await fs.writeFile(path.join(outDir, "cwv_baseline.md"), `${mdLines.join("\n")}\n`, "utf8");

  console.log("CWV lab baseline generated:");
  console.log("- audit/cwv_lab.json");
  console.log("- audit/cwv_baseline.md");
}

main().catch((error) => {
  console.error("Failed to generate CWV baseline.");
  console.error(error);
  process.exit(1);
});
