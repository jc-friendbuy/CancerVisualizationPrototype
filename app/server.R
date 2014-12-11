# Main server script.  This script starts the shiny web server, configures the
# visualization options so that the appropriate rendering functions can be
# selected for each visualization and waits for user input.

library(shiny)
library(shinyRGL)
source('visualization_config.R')

# Start the main Web server loop, and render the UI components where the
# visualizations will be rendered.
shinyServer(function(input, output) {

  output$visualization.output <- renderUI({

    computed.visualizations <- ExecuteVisualization(
      input$visualization.select
    )

    lapply(computed.visualizations, function(visualization) {
      render.function <- SelectRenderingFunction(visualization$graph.type)
      render.function(visualization$visualization())
    })
  })
})

# Return a rendering function for each of the visualization functions, in order
# to render the correct content depending on the required visualization.
SelectRenderingFunction <- function(visualization.function) {
  switch(visualization.function,
    plot = renderPlot,
    hist = renderPlot,
    plot3d = renderWebGL,
    h3 = h3
  )
}

# Run the selected visualization function and return its results, so they can
# be rendered.
ExecuteVisualization <- function(visualization) {
  visualization.index <- as.integer(visualization)
  if (visualization.index > 1) {
    visualization.to.execute <- visualization.list[[visualization.index]]
    visualization.to.execute()
  }
}
