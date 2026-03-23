import { expect, test } from "playwright/test";

const PUBLIC_PATHS = ["/", "/cursussen", "/lessen", "/faq", "/contact"];

for (const path of PUBLIC_PATHS) {
  test(`publieke pagina ${path} laadt zonder fout`, async ({ page }) => {
    const response = await page.goto(path, { waitUntil: "domcontentloaded" });

    expect(response).not.toBeNull();
    expect(response?.status()).toBeGreaterThanOrEqual(200);
    expect(response?.status()).toBeLessThan(400);

    await expect(page.locator("#main-content")).toBeVisible();

    const h1Count = await page.locator("h1").count();
    expect(h1Count).toBeGreaterThan(0);
  });
}

test("cataloguslinks verwijzen intern en niet naar legacy academy domein", async ({ page }) => {
  await page.goto("/cursussen", { waitUntil: "networkidle" });

  const links = page.locator("a[href]");
  const count = await links.count();
  const legacyDomain = "academy.octopus.be";
  const legacyLinks = [];

  for (let index = 0; index < count; index++) {
    const href = await links.nth(index).getAttribute("href");
    if (href && href.includes(legacyDomain)) {
      legacyLinks.push(href);
    }
  }

  expect(legacyLinks).toEqual([]);
});
