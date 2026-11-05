# v0: one input, one output ------------------------------------------------

library(shiny)
library(tidyverse)

manager_survey <- read_rds("https://github.com/stat220-f26/stat220-f26.github.io/raw/refs/heads/main/slides/23/manager-survey-app/manager-survey-processed.rds") |>
  select(
    age = how_old_are_you,
    industry = industry_other,
    education = highest_level_of_education_completed,
    gender,
    annual_salary
  ) |>
  filter(annual_salary < 500000)   # drop a few extreme outliers (43 of 21,665 rows)

ui <- fluidPage(
  titlePanel("Ask a Manager"),
  sliderInput("bins", label = "Number of bins", min = 5, max = 50, value = 20),
  plotOutput("salary_hist")
)

server <- function(input, output, session) {
  output$salary_hist <- renderPlot({
    ggplot(manager_survey, aes(x = annual_salary)) +
      geom_histogram(bins = input$bins, color = "white") +
      scale_x_continuous(labels = scales::label_dollar())
  })
}

shinyApp(ui = ui, server = server)
