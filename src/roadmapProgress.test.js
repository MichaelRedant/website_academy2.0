import { describe, expect, it } from "vitest";
import { formatRoadmapProgress } from "./roadmapProgress.js";

describe("formatRoadmapProgress", () => {
  it("formats valid progress", () => {
    expect(formatRoadmapProgress(2, 5)).toBe("Roadmap voortgang: 2/5 (40%).");
  });

  it("handles invalid values", () => {
    expect(formatRoadmapProgress(1, 0)).toBe("Roadmapstatus niet beschikbaar.");
    expect(formatRoadmapProgress(Number.NaN, 4)).toBe("Roadmapstatus niet beschikbaar.");
  });
});
