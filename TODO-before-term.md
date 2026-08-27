# To do before Fall 2026 term starts

Running list of changes needed to move this site from the Winter 2026 copy to Fall 2026.

## Environment / packages

- [ ] Render `playground/package-check.qmd` **on the Maize RStudio server** after
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

- [ ] `course-syllabus.qmd` has `freeze: true` — the HTML and Typst/PDF syllabus will not rebuild on a normal `quarto render`. Force it: `quarto render course-syllabus.qmd`.
- [ ] "Spend a Token" Google Form in `course-links.qmd:12` (`https://forms.gle/aa59m9WVn7u2Bhwo8`) — confirm it's the Fall 2026 form, not last term's.
- [ ] Google Sheet IDs (left as-is for now, update when ready):
  - [ ] `index.qmd:17` — schedule sheet (currently the W26 sheet; homepage renders last term's schedule until swapped). Note `index.qmd` has `freeze: false`, so it re-reads on every render.
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

- [ ] `course-syllabus.qmd` — meeting times, room (CMC 306), office hours, office (CMC 223 / CMC 307) for Fall 2026.
- [ ] `_quarto.yml:27` — Moodle course id set to `50418`; confirm.
- [ ] Term schedule dates (breaks, no-class days, finals) — these live in the Google schedule sheet, not the repo.

---

## Done (Winter 2026 -> Fall 2026 migration, initial pass)

- Replaced `stat220-w26` -> `stat220-f26` across all source (domain, org/repo, org page) — 33 files.
- `_quarto.yml`: description `Winter 2026` -> `Fall 2026`; Moodle `id=48308` -> `id=50418`; footer `Material 2025` -> `Material 2026`.
- `slides/_metadata.yml`, `activities/_metadata.yml`: institute -> `Fall 2026`.
- `course-syllabus.qmd`: subtitle -> `Fall 2026`.
- `course-links.qmd`: stale org `stat220-s25` -> `stat220-f26`; stale Moodle `id=44937` -> `id=50418`.
- Renamed `stat220-w26.github.io.Rproj` -> `stat220-f26.github.io.Rproj`.
