# To do before Fall 2026 term starts

Running list of changes needed to move this site from the Winter 2026 copy to Fall 2026.

## Environment / packages

- [x] Render `playground/package-check.qmd` **on the Maize RStudio server** after
  the update and review the availability table + functional checks. Also render it
  to PDF (`quarto render playground/package-check.qmd --to pdf`) to confirm the
  LaTeX toolchain.
- [ ] Known to watch: `gghighlight` breaks with newer `ggplot2` (fails on my
  laptop's ggplot2). Confirm the server's `ggplot2` / `gghighlight` combination
  works, since it's used in the plotting slides.

## Deployment / repo

- [ ] Move repo from `aluby/stat220-f26.github.io` to a `stat220-f26` GitHub org, served at `stat220-f26.github.io`. Until then, absolute links to `https://stat220-f26.github.io/...` (data reads, activity/file links) and `https://github.com/stat220-f26/...` will not resolve.
- [ ] Update git remote after the move.

## Content that still points at old terms

- [x] `course-syllabus.qmd` has `freeze: true` — the HTML and Typst/PDF syllabus will not rebuild on a normal `quarto render`. Force it: `quarto render course-syllabus.qmd`.
- [x] "Spend a Token" Google Form in `course-links.qmd:12` (`https://forms.gle/aa59m9WVn7u2Bhwo8`) — confirm it's the Fall 2026 form, not last term's.
- [ ] Google Sheet IDs (left as-is for now, update when ready):
  - [x] `index.qmd:17` — schedule sheet (currently the W26 sheet; homepage renders last term's schedule until swapped). Note `index.qmd` has `freeze: false`, so it re-reads on every render.
  - [ ] `portfolio/final.qmd:65` — final project ideas/schedule sheet.
  - [ ] `portfolio/final.qmd:215` — group assignment spreadsheet.

## Older-term leftovers (pre-W26 copies)

- [ ] `slides/02/slides02.qmd:169` — `stat220-s25.github.io`
- [ ] `slides/04/slides04.qmd:107` — `stat220-w25.github.io`
- [ ] `slides/slides-cheat-sheet.qmd:152` — `github.com/stat220-w25`
- [ ] `activities/10-combining.qmd:10` — `github.com/stat220-w25/activities`
- [ ] `activities/25-shiny-design.qmd:97` — `sta199-f25.github.io` image
- [ ] `files/23-app1-starter.R:12` — `stat220-s25.github.io/data/manager-survey.csv`
- [ ] `lab-quiz/lab-quiz-02.qmd:212` — `stat220-s25.github.io/data/lq2_plot_data.csv`

## `w26`-named files (rename + refresh content)

- [ ] `slides/img/w26-schedule.png` and duplicate `img/w26-schedule.png` — last term's schedule screenshot; used by `slides/01/slides01.qmd:309` (`../img/w26-schedule.png`). Rename to `f26-schedule.png`, replace the image, update the reference.
- [ ] `files/app-w26-sol.R`
- [ ] `slides/23/manager-survey-app/app-w26.R`
- [ ] `slides/23/manager-survey-app/app-w26-sol.R`
  - Referenced from `activities/23-shiny1.qmd`, `activities/24-shiny2.qmd`, `slides/23/slides23.qmd`. Renaming is optional (they work as-is); internal URLs were already repointed to `stat220-f26`.
- [ ] `slides/01/slides01.qmd` — bare `stat220-f26.github.io` / `github.com/stat220-f26` text at lines ~240-241, 284, 293, 433 (already updated by the term rename; sanity-check they read correctly).

## Teaching-example dates / years (no render impact — update only if desired)

- [ ] `activities/21-scraping.qmd`, `slides/20/slides20.qmd`, `slides/21/slides21.qmd` — Carleton catalog term codes (`25WI`, `26SP`) and box-office `year/2026` examples.
- [ ] Date-parsing examples using `"2025-01-29"` etc. in `slides/11`, `slides/13`, `slides/22`.
- [ ] `activities/10-combining.qmd` — dataset described as "Fall 2024 and Winter 2025 terms".

## Syllabus / logistics to review

- [x] `course-syllabus.qmd` — meeting times, room (CMC 306), office hours, office (CMC 223 / CMC 307) for Fall 2026.
- [x] `_quarto.yml:27` — Moodle course id set to `50418`; confirm.
- [x] Term schedule dates (breaks, no-class days, finals) — these live in the Google schedule sheet, not the repo.


### Portfolio projects: 4 → 3 (grading load)

New lineup: **P1 (rewritten) → P3 (unchanged) → P4 (unchanged)**. **Cut P2**
("Wrangling weather forecasts"). P3 covers functions/iteration, P4 covers
interactivity — both kept as-is.

- [ ] **P1 rewrite — "Real or fake?"** Draft is in
  `_playground/portfolio-1-draft.qmd` (data-forensics argument about a Kaggle
  dataset; replaces the old "pose two research questions" P1). Review, then move
  to `portfolio/portfolio-1.qmd`.
- [ ] **Decide numbering.** Either renumber P3→P2 and P4→P3, or keep the labels
  1 / 3 / 4. Renumbering touches `portfolio/portfolio-*.qmd` filenames + titles,
  the sidebar in `_quarto.yml` (portfolio section isn't currently listed there —
  check), the schedule sheet, and any cross-references in slides/activities.
- [ ] **Delete `portfolio/portfolio-2.qmd`** and its data (`data/weather_forecasts.csv`,
  `forecast_cities.csv`, `outlook_meanings.csv`) once the cut is final. Check the
  schedule sheet and slides for links to it.
- [x] **"2 of 4 must be excellent for an A" → "2 of 3."** Appears in the
  `portfolio-2.qmd` callout (being deleted) and the new P1 draft; check
  `course-syllabus.qmd` and the schedule sheet too. Confirm 3 projects still
  leaves enough revision / token slack.
- [ ] **Joins lose portfolio-level assessment** with P2 gone. Add "combines data
  from more than one table or source" as an explicit *wrangle* criterion on
  `portfolio/final.qmd`'s rubric. (HW4–5 already cover joins heavily.)
- [x] **Due date:** move P1 a little later than the old P1 — aim week ~3–4 — so
  students have basic `dplyr` for summaries and cross-tabs. Keep ≥2 weeks between
  P1 and P3 so you're not grading two portfolios back-to-back.
- [ ] **Pairs?** Old P1 was individual (good early diagnostic + low stakes).
  Allowing pairs on the new P1 would further cut submissions — decide.
- [ ] **Class scaffolding needed.** The new P1 assumes a "tells" toolkit that
  isn't currently a lecture: distribution smell tests, impossible/contradictory
  records, duplicates, round-number clustering, decimal precision, correlation
  structure, categorical balance, temporal regularity, Benford (optional),
  external benchmarks. Add an EDA / data-quality session near the ggplot weeks.
- [ ] **Vet the Kaggle shortlist** before publishing (see below) — confirm the
  slugs still resolve, the synthetic ones aren't self-labeled "synthetic" on the
  data card, and the real ones still carry the messiness that makes them
  arguable. Rebalance the mix if needed.
- [ ] **Pre-existing P1 bug:** the current `portfolio/portfolio-1.qmd` Submission
  section says "two visualizations (replication and improvement)" — leftover from
  another project, contradicts the rest of P1. Gone in the rewrite; just noting
  it's a known issue.
- [ ] **P4 revisit menu** shrinks to P1(new) / P3. An interactive
  "data-forensics explorer" over the P1 dataset is a fine P4 base — no change
  needed, worth mentioning in P4.



### Remove / compress homework

- [ ] **HW7 P4 + P5** — same "lm coefficients per season" problem done as a
  `for` loop *and* as `map`. Keep one (buys back room on the 9-pt assignment).
- [ ] **HW6 P2–P4** — three MAC-address string problems on one contrived example.
  Collapse to one or two; `separate_wider_regex()` now does most of it in one call.
- [ ] **HW8 P2 + P3 + P4** (currently the S25 version) — pulls the same ACS data
  via `tidycensus`, then again via raw `httr2`, then wraps the raw version in a
  function. Cut to `tidycensus` once + one raw-API problem on a *different*
  endpoint.
- [ ] **HW5 P10** — trim regex gauntlet from 7 parts to ~5. Drop "3+ vowels in a
  row" and "same first/last letter" (backreference) — puzzle, not practice.
- [ ] **HW9 P7** (WAI / `RMariaDB` to `scidb.smith.edu`) — replace with a
  DuckDB-backed problem (see Upweight). Depends on Smith keeping a MariaDB server
  reachable from Carleton; it will fail some semester.

### Downweight

- [ ] **For-loops + manual preallocation (Slides 17)** — R4DS 2nd ed (2023)
  de-emphasizes this; iteration is now `across()` → `map()` → "read many files."
  Keep one for-loop for the mental model, shift weight to `map`/`across`. (Keep
  more only if Python-loop transfer is an explicit goal.)
- [ ] **Lexicon sentiment analysis (Slides 15)** — only deck with zero homework,
  and AFINN/bing/nrc is a ~2014 treatment. Either leave it light/class-only, or
  repoint Slides 14/15 toward TF-IDF (`tidytext::bind_tf_idf`) + a short "how
  modern NLP differs" coda.
- [ ] **`ggmap` basemaps (Slides 05)** — `get_stadiamap()` now needs a registered
  Stadia API key (same friction that killed Stamen). HW3 map problems already use
  `map_data()` + choropleths, which is fine. Drop the tile-basemap slide or
  switch to `maptiles` (no key for OSM/CARTO).

### Upweight / add

- [ ] **DuckDB for the databases unit** — swap `mdsr::dbConnect_scidb()` for
  `dbConnect(duckdb::duckdb())` over local CSV/Parquet. Same `dbplyr` translation,
  zero infrastructure, no dependency on someone else's server. `duckdb` is already
  a course dependency. Affects Slides 25–26, Activity 26, HW9 P6–P7. (SQL Murder
  Mystery is fine as-is.)
- [ ] **Finish the Quarto-dashboard migration** — Slides 22 still
  `library(flexdashboard)`s but also shows `format: dashboard`. `flexdashboard`
  is effectively superseded; standardize on native `format: dashboard`. Also
  Activity 22 and HW9 P2.
- [ ] **AI-assisted coding as a skill, not just a policy** — one focused
  treatment near the functions/debugging weeks: verifying LLM-generated R,
  spotting confident-but-wrong output, attribution.
- [ ] **`gt` tables** — currently only in the portfolio. Worth one HW problem
  (pairs with the wrangling or text weeks).
- [ ] **Parquet / `arrow`** — ~20 min on "bigger than memory" alongside DuckDB.

### Same topic, dated function (low effort)

- [ ] **`separate()` → `separate_wider_delim()` / `_position()` / `_regex()`** —
  superseded in tidyr 1.3.0 (Jan 2023). Slides 04 and heavily in Slides 08.
- [ ] **Joins: `by = "id"` → `join_by(id)`** — dplyr 1.1.0 (Jan 2023). Also show
  the new multiple-match / unmatched warnings (students hit them anyway). Slides 10.
- [ ] **`group_by()` → `.by =`** for one-off grouped summaries — dplyr 1.1.0.
  Optional, but it's what current tidyverse code looks like.

---

## Done (Winter 2026 -> Fall 2026 migration, initial pass)

- Replaced `stat220-w26` -> `stat220-f26` across all source (domain, org/repo, org page) — 33 files.
- `_quarto.yml`: description `Winter 2026` -> `Fall 2026`; Moodle `id=48308` -> `id=50418`; footer `Material 2025` -> `Material 2026`.
- `slides/_metadata.yml`, `activities/_metadata.yml`: institute -> `Fall 2026`.
- `course-syllabus.qmd`: subtitle -> `Fall 2026`.
- `course-links.qmd`: stale org `stat220-s25` -> `stat220-f26`; stale Moodle `id=44937` -> `id=50418`.
- Renamed `stat220-w26.github.io.Rproj` -> `stat220-f26.github.io.Rproj`.
