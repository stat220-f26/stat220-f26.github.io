# v5: theme + a data/ folder, ready to deploy ---------------------------------
# Run data-prep.R first. Keep app.R, data/ and nothing else in this folder:
# the whole folder is what gets deployed.

library(shiny)
library(tidyverse)

manager_survey <- read_rds("data/manager-survey.rds")

industry_choices <- manager_survey |>
  distinct(industry) |>
  arrange(industry) |>
  pull(industry)

thematic::thematic_shiny()   # make the plots match the app theme

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "flatly"),
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
