import { expect, test } from "playwright/test";

const ACCESSIBILITY_PATHS = ["/", "/cursussen", "/lessen"];

for (const path of ACCESSIBILITY_PATHS) {
  test(`a11y smoke op ${path}: skip-link, main en h1`, async ({ page }) => {
    await page.goto(path, { waitUntil: "domcontentloaded" });

    const skipLink = page.getByRole("link", { name: /naar hoofdinhoud/i });
    await expect(skipLink).toHaveCount(1);

    await page.keyboard.press("Tab");
    await expect(skipLink).toBeFocused();

    await skipLink.press("Enter");
    await expect(page.locator("#main-content")).toBeVisible();

    const h1Count = await page.locator("h1").count();
    expect(h1Count).toBeGreaterThan(0);

    const imagesWithoutAlt = await page.locator("img:not([alt])").count();
    expect(imagesWithoutAlt).toBe(0);
  });
}
