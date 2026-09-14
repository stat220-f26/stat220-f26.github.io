library(tidyverse)
library(googlesheets4)
library(here)
survey <- read_sheet("https://docs.google.com/spreadsheets/d/1mdxzX_LC1OBN2JZr17G3sGVyRvPJZxef4eKf2wd_tg0/edit?usp=sharing")

survey <- survey |>
  select(class_year = `What is your class year?`,
         tabs = `How many browser tabs do you currently have open?`,
         northfield_food = `Where can you find the best food in Northfield?`, 
         googled = `What's the last thing you Googled?`)

write_csv(survey, here(here(), "data/class_survey_sm.csv"))
