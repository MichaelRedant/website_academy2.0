import { expect, test } from "playwright/test";

const MOBILE_CORE_PATHS = ["/", "/cursussen", "/lessen"];

for (const path of MOBILE_CORE_PATHS) {
  test(`mobile ${path} heeft geen horizontale overflow`, async ({ page }) => {
    await page.goto(path, { waitUntil: "networkidle" });

    const hasOverflow = await page.evaluate(() => {
      return document.documentElement.scrollWidth > window.innerWidth + 1;
    });

    expect(hasOverflow).toBeFalsy();
  });
}

test("mobile navigatie blijft klikbaar over kernroutes", async ({ page }) => {
  await page.goto("/", { waitUntil: "domcontentloaded" });

  await page.locator('a[href$="/cursussen"]:visible').first().click();
  await expect(page).toHaveURL(/\/cursussen$/);
  await expect(page.locator("#main-content")).toBeVisible();

  await page.locator('a[href$="/lessen"]:visible').first().click();
  await expect(page).toHaveURL(/\/lessen$/);
  await expect(page.locator("#main-content")).toBeVisible();
});

for (const path of ["/cursussen", "/lessen"]) {
  test(`mobile filters op ${path} blijven bruikbaar`, async ({ page }) => {
    await page.goto(path, { waitUntil: "networkidle" });

    const filterForm = page.locator("form[data-live-filter-form]").first();
    await expect(filterForm).toBeVisible();

    await expect(filterForm.locator('input[name="q"]')).toBeVisible();
    await expect(filterForm.locator('select[name="tag"]')).toBeVisible();
    await expect(filterForm.locator('select[name="niveau"]')).toBeVisible();
  });
}
