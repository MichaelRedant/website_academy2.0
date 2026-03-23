import "./style.css";
import { formatRoadmapProgress } from "./roadmapProgress.js";

const app = document.querySelector("#app");
const today = new Date().toLocaleDateString("nl-BE", {
  year: "numeric",
  month: "long",
  day: "numeric",
});

const overview = {
  done: 2,
  total: 3,
};

if (app) {
  app.innerHTML = `
    <main class="page">
      <header class="hero">
        <p class="kicker">Academy 2.0</p>
        <h1>Lokale testomgeving staat klaar</h1>
        <p class="subtitle">
          Gebruik deze sandbox om veilig te testen terwijl we de migratie voorbereiden.
        </p>
      </header>

      <section class="card">
        <h2>Snelle status</h2>
        <p>${formatRoadmapProgress(overview.done, overview.total)}</p>
        <p class="muted">Laatste update: ${today}</p>
      </section>

      <section class="card">
        <h2>Beschikbare commando's</h2>
        <ul>
          <li><code>npm run dev</code> start de lokale server.</li>
          <li><code>npm run test</code> draait unit tests.</li>
          <li><code>npm run build</code> maakt productiebuild.</li>
          <li><code>npm run preview</code> previewt productiebuild lokaal.</li>
          <li><code>npm run audit:refresh</code> ververst sitemap-audit.</li>
        </ul>
      </section>
    </main>
  `;
}
