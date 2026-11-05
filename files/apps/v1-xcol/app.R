# v1: a second input and a second output -----------------------------------

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
  filter(annual_salary < 500000)

ui <- fluidPage(
  titlePanel("Ask a Manager"),
  sliderInput("bins", label = "Number of bins", min = 5, max = 50, value = 20),
  selectInput("xcol", label = "Compare salaries by", choices = c("age", "education", "gender")),
  plotOutput("salary_hist"),
  plotOutput("salary_jitter")
)

server <- function(input, output, session) {
  output$salary_hist <- renderPlot({
    ggplot(manager_survey, aes(x = annual_salary)) +
      geom_histogram(bins = input$bins, color = "white") +
      scale_x_continuous(labels = scales::label_dollar())
  })

  output$salary_jitter <- renderPlot({
    ggplot(manager_survey, aes(x = .data[[input$xcol]], y = annual_salary)) +
      geom_jitter(alpha = 0.3, height = 0, width = 0.2) +
      scale_y_continuous(labels = scales::label_dollar())
  })
}

shinyApp(ui = ui, server = server)
