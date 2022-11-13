#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)

gapminder <- read_csv("gapminder_clean.csv")
cols <- gapminder %>%
  select_if(is.numeric) %>%
  colnames()
years <- gapminder %>%
  select(Year) %>%
  unique()

cols <- cols[c(3:16, 18)]

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),

  # Application title
  titlePanel("Gapminder Exploratory Data Analysis"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      uiOutput("choose_x_axis"),
      uiOutput("choose_y_axis"),
      radioButtons("x_scale", "scale X", c("Linear" = "lin", "Log" = "log")),
      radioButtons("y_scale", "scale Y", c("Linear" = "lin", "Log" = "log")),
      sliderInput("year_range",
        label = "Select Year",
        min = min(years), max = max(years),
        step = 5,
        value = 2002,
        sep = ""
      )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      textOutput("graph_desc"),
      plotlyOutput("gg_plot")
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Drop-down selection box generated from Gapminder dataset
  output$choose_x_axis <- renderUI({
    selectInput("x_axis", "X axis", as.list(cols))
  })
  output$choose_y_axis <- renderUI({
    selectInput("y_axis", "Y axis", as.list(cols), selected = cols[sample(1:10, 1, T)])
  })
  scale_x <- reactive({
    if (input$x_scale == "log") {
      return(TRUE)
    } else {
      return(FALSE)
    }
  })
  scale_y <- reactive({
    if (input$y_scale == "log") {
      return(TRUE)
    } else {
      return(FALSE)
    }
  })
  data <- reactive({
    year <- input$year_range
    data <- gapminder %>%
      filter(Year == year) %>%
      drop_na(continent)
    return(data)
  })
  output$graph_desc <- renderText({
    paste0("The Relationship between ", input$x_axis, " and ", input$y_axis, " in the year ", input$year_range)
  })
  output$gg_plot <- renderPlotly({
    req(input$x_axis, input$y_axis)
    x_variable <- input$x_axis
    y_variable <- input$y_axis
    p <- ggplot(data(), aes_string(x = as.name(x_variable), y = as.name(y_variable), color = as.name("continent"), size = as.name("pop"))) +
      geom_point() +
      theme_classic()
    if (scale_x() & scale_y()) {
      p <- p + scale_x_log10() + scale_y_log10()
      ggplotly(p)
    } else if (scale_x()) {
      p <- p + scale_x_log10()
      ggplotly(p)
    } else if (scale_y()) {
      p <- p + scale_x_log10()
      ggplotly(p)
    } else {
      ggplotly(p)
    }
    
  })
}

# Run the application
shinyApp(ui = ui, server = server)
