# v4: layout (sidebar + tabs) ---------------------------------------------------

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

industry_choices <- manager_survey |>
  distinct(industry) |>
  arrange(industry) |>
  pull(industry)

ui <- fluidPage(
  titlePanel("Ask a Manager"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "industry",
        label = "Industries",
        choices = industry_choices,
        selected = c("Computing or Tech", "Nonprofits", "Health care")
      ),
      selectInput("xcol", label = "Compare salaries by", choices = c("age", "education", "gender")),
      sliderInput("bins", label = "Number of histogram bins", min = 5, max = 50, value = 20)
    ),
    mainPanel(
      textOutput("n_respondents"),
      tabsetPanel(
        tabPanel("Distribution", plotOutput("salary_hist")),
        tabPanel("Individual salaries", plotOutput("salary_jitter")),
        tabPanel("Average by education", plotOutput("avg_salary")),
        tabPanel("Data", DT::dataTableOutput("data"))
      )
    )
  )
)

server <- function(input, output, session) {
  filtered <- reactive({
    req(input$industry)
    manager_survey |>
      filter(industry %in% input$industry)
  })

  output$n_respondents <- renderText({
    paste("Showing", scales::comma(nrow(filtered())), "respondents")
  })

  output$salary_hist <- renderPlot({
    ggplot(filtered(), aes(x = annual_salary)) +
      geom_histogram(bins = input$bins, color = "white") +
      scale_x_continuous(labels = scales::label_dollar()) +
      labs(x = "Annual salary", y = "Number of respondents")
  })

  output$salary_jitter <- renderPlot({
    ggplot(filtered(), aes(x = .data[[input$xcol]], y = annual_salary, color = industry)) +
      geom_jitter(alpha = 0.4, height = 0, width = 0.2) +
      scale_y_continuous(labels = scales::label_dollar()) +
      labs(x = input$xcol, y = "Annual salary", color = "Industry")
  })

  output$avg_salary <- renderPlot({
    filtered() |>
      group_by(industry, education) |>
      summarize(mean_salary = mean(annual_salary), .groups = "drop") |>
      ggplot(aes(x = education, y = mean_salary, group = industry, color = industry)) +
      geom_line(linewidth = 1) +
      scale_x_discrete(labels = scales::label_wrap(10)) +
      scale_y_continuous(labels = scales::label_dollar()) +
      labs(x = "Highest level of education", y = "Mean annual salary", color = "Industry")
  })

  output$data <- DT::renderDataTable({
    filtered()
  })
}

shinyApp(ui = ui, server = server)
