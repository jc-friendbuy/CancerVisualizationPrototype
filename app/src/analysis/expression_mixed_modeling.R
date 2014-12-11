library(mixtools)
source('src/data/db.R')

ExpressionMixedGaussianModel <- function() {
  data <- GetAll()
  mix <- normalmixEM(data$quantileNormalizedRMAExpression)

  list(
    list(
      graph.type = 'plot',
      visualization = function() {
        # This might not work as it creates several plots
        plot(mix, density=TRUE, cex.axis=1.4, cex.lab=1.4, cex.main=1.8)
      }
    )
  )
}
