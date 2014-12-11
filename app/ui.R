# The main UI file.  This sets up the HTML structure where the content will be
# generated via the Shiny HTML-generating library.

library(shiny)
library(shinyRGL)
source('visualization_config.R')

# Generate a simple UI where there is a sidebar and a main content area.  The
# sidebar contains a select component that lets the user choose which
# visualization to display and a submission button to execute the selected
# choice. Note that select is dinamically populated with the result of calling
# `GetVisualizationFunctionChoices` in visualization_config.R
shinyUI(fluidPage(

  titlePanel("Cancer Visualization Prototype"),

  sidebarLayout(
    sidebarPanel(
      selectInput("visualization.select",
                  label = h3("Visualization"),
                  choices = GetVisualizationFunctionChoices(),
                  selected = 1),
      submitButton("Display")
    ),

    mainPanel(
      uiOutput('visualization.output')
    ),
    position = "right"
  )
))
