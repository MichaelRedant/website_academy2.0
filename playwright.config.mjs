import { defineConfig, devices } from "playwright/test";

const baseURL = process.env.ACADEMY_BASE_URL || "http://127.0.0.1:8000";

export default defineConfig({
  testDir: "./tests/e2e",
  timeout: 45_000,
  expect: {
    timeout: 10_000,
  },
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 1 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ["list"],
    ["html", { outputFolder: "audit/playwright-report", open: "never" }],
  ],
  use: {
    baseURL,
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
    video: "retain-on-failure",
  },
  webServer: {
    command: "npm run monolith:serve",
    url: baseURL,
    reuseExistingServer: true,
    timeout: 120_000,
  },
  projects: [
    {
      name: "desktop-chromium",
      use: {
        ...devices["Desktop Chrome"],
      },
    },
    {
      name: "desktop-firefox",
      use: {
        ...devices["Desktop Firefox"],
      },
    },
    {
      name: "desktop-webkit",
      use: {
        ...devices["Desktop Safari"],
      },
    },
    {
      name: "mobile-chromium",
      use: {
        ...devices["Pixel 7"],
      },
    },
    {
      name: "mobile-safari",
      use: {
        ...devices["iPhone 13"],
      },
    },
  ],
});
