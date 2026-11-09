# Run this once. It writes the cleaned data that app.R reads.

library(tidyverse)

manager_survey <- read_rds("https://github.com/stat220-f26/stat220-f26.github.io/raw/refs/heads/main/slides/23/manager-survey-app/manager-survey-processed.rds") |>
  select(
    age = how_old_are_you,
    industry = industry_other,
    education = highest_level_of_education_completed,
    gender,
    annual_salary
  ) |>
  filter(annual_salary < 500000)

dir.create("data", showWarnings = FALSE)
write_rds(manager_survey, "data/manager-survey.rds")
