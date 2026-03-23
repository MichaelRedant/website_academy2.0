export function formatRoadmapProgress(done, total) {
  if (!Number.isFinite(done) || !Number.isFinite(total) || total <= 0) {
    return "Roadmapstatus niet beschikbaar.";
  }

  const ratio = Math.max(0, Math.min(1, done / total));
  const percent = Math.round(ratio * 100);
  return `Roadmap voortgang: ${done}/${total} (${percent}%).`;
}
