# Compute mixed gaussian models for gene expression data.

library(mixtools)
source('src/data/db.R')

# Create a mixed gaussian model (i.e. find different gaussian distributions) for
# the gene expression profile of all genes.
ExpressionMixedGaussianModel <- function() {
  data <- GetAll()
  mix <- normalmixEM(data$quantileNormalizedRMAExpression)

  list(
    list(
      graph.type = 'plot',
      visualization = function() {
        plot(mix, density=TRUE, cex.axis=1.4, cex.lab=1.4, cex.main=1.8)
      }
    )
  )
}
