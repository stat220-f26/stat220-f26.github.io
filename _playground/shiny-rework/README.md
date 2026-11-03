# Shiny days (23-25) rework: drafts

One app, built up over three days, using the Ask-a-Manager data.

| Day | Slides / activity | App versions | New in this version |
|:----|:------------------|:-------------|:--------------------|
| 23 (Fri, 60 min) | `slides23-draft.qmd`, `23-shiny1-draft.qmd` | `apps/v0-hist` -> `v1-xcol` -> `v2-filter` | start with a 25-line app; input -> output rule; `.data[[input$x]]` (replaces `aes_string`); filter is written twice (the puzzle for Monday) |
| 24 (Mon, 70 min) | `slides24-draft.qmd`, `24-shiny2-draft.qmd` | `apps/bootstrap-sol` (solution to `files/24-reactivity.R`), `v3-reactive` | the bootstrap warm-up is kept (its plot and table use *different* resamples, which makes the problem visible); the manager app is then refactored in class (it was a one-line afterthought); `req()`; **deploy to shinyapps.io** moved here from "if time" on Day 25 |
| 25 (Wed, 70 min) | `slides25-draft.qmd`, `25-shiny-design-draft.qmd` | `apps/v4-polish` (with `data-prep.R`) | merge-conflict activity **removed** (it is already Day 17); sidebar + tabs only (multirow/navlist/navbar become one slide); bslib + thematic; data folder with a relative path; re-deploy; rest of class is work time (sketch due, Portfolio 3 due Friday) |

## To use these

1. Move `apps/` to `files/shiny-apps/` (the slides and activities link to `https://stat220-f26.github.io/files/shiny-apps/<version>/app.R`).
2. The apps read `slides/23/manager-survey-app/manager-survey-processed.rds` from GitHub `main` (it is already in the repo); `v4-polish` reads `data/manager-survey.rds`, made by `data-prep.R`.
3. Replace `slides/23`, `slides/24`, `slides/25` and the three activities, and update the Day 23-25 rows of the schedule sheet (prepare column: Day 23 = Mastering Shiny Ch 1-2 or basics playlist; Day 24 = reactivity playlist or Ch 3, **plus create a shinyapps.io account**).
4. Clean up `slides/25/`: `slides25-home.qmd` and `slides25-work.qmd` are stale copies of the SQL deck (also in `slides/26`).

## Checked

- Every app's server logic runs headlessly (`shiny::testServer`), including every output in `v3` and `v4`.
- `v4-polish` run for real in the browser pane: sidebar, all four tabs, and the thematic-styled plots work (with `{thematic}` 0.1.8).
- `bootstrap-sol`: changing the bins or confidence level does not trigger a new resample; changing `n_boot` does.

## Open items

- **`{thematic}` < 0.1.8 breaks with ggplot2 4.0** (`object 'ggplot_build.ggplot' not found` as soon as `thematic_shiny()` runs). This laptop has 0.1.6 / ggplot2 4.0.2. Check the Maize server's versions (`package-check.qmd`) and update thematic if needed. The old Day 25 slides and `slides/25/theming-app.R` have the same problem.
- Class is on the clock: Day 23 is 60 minutes, so tasks 12-13 of the activity are the challenge.
- `v4-polish`: 25 industry checkboxes make a long sidebar. Fine for teaching; a `selectInput(multiple = TRUE)` would be more compact.
- The Portfolio 3 page is titled "Portfolio Project 4".
- The old `asluby.shinyapps.io/GSS_classification` warm-up app is gone (404); I dropped it from the Day 25 list.
- `files/23-app1-starter.R` and `files/app-w26-sol.R` are no longer needed by these drafts.
