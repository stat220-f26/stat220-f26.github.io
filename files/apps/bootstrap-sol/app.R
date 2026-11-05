# Solution to the Day 24 warm-up: one reactive expression shared by both outputs

# Load the necessary packages

library(shiny)
library(tidyverse)
library(palmerpenguins)
library(ggdist)

# One-sample bootstrap resampler helper function
resample <- function(obs_sample, B) {
  stats <- numeric(B)
  for(i in 1:B) {
    x <- sample(obs_sample, replace = TRUE)
    stats[i] <- mean(x, na.rm = TRUE)
  }
  
  stats
}

#
obs_data <- penguins %>%
  dplyr::filter(species == "Adelie") %>%
  pull(flipper_length_mm) %>%
  na.omit()

# Define UI for application that conducts a bootstrap
ui <- fluidPage(
  
  h1("One-sample bootstrap"),
  inputPanel(
    sliderInput("n_boot", 
                label = "Number of bootstrap resamples", 
                value = 1000, 
                min = 100, 
                max = 15000, 
                step = 100),
    sliderInput("nbins", 
                label = "Number of histogram bins", 
                value = 15,
                min = 3, 
                max = 60),
    numericInput("conf_level", 
                 label = "Confidence level", 
                 value = 0.89, 
                 min = 0.5, 
                 max = 0.99, 
                 step = 0.01)
  ),
  
  mainPanel(
    h3("Bootstrap distribution"),
    plotOutput("histogram"),
    h3("Bootstrap percentile interval"),
    tableOutput("ci")
  )
)


# Define server logic ---------------------------------------------------------
server <- function(input, output, session) {

  # The expensive step happens ONCE per change to n_boot.
  # Changing the number of bins or the confidence level does not resample.
  boot <- reactive({
    resample(obs_data, B = input$n_boot)
  })

  output$histogram <- renderPlot({
    data.frame(means = boot()) %>%
      ggplot(aes(x = means)) +
      ggdist::stat_histinterval(breaks = input$nbins, .width = input$conf_level, size = 20) +
      theme_minimal() +
      labs(x = paste("Mean of flipper length")) +
      xlim(187.5, 192.5)
  })

  output$ci <- renderTable({
    alpha <- 1 - input$conf_level
    quantiles <- quantile(boot(), probs = c(alpha/2, 1 - alpha/2))

    data.frame(
      mean = mean(boot()),
      lower = quantiles[1],
      upper = quantiles[2]
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
