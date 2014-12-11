source('src/analysis/basic.R')
source('src/analysis/correlation.R')
source('src/analysis/genomic_location.R')
source('src/analysis/expression_mixed_modeling.R')

visualization.list <- list(
  '--' = '',
  'Correlation Histogram' = CorrelationHistogram,
  'Linear fits to correlation indexes' = CorrelationFits,
  'Copy Number and Gene Expression relationship' = SideBySideCNAndGE,
  'Genomic location analysis' = GenomicLocations,
  'Genomic location for some cell lines' = GenomicLocationsForSelectedCellLines,
  'Expression mixed modeling' = ExpressionMixedGaussianModel
)

GetVisualizationFunctionChoices <- function() {
  vis.names <- names(visualization.list)
  result <- list()
  for (i in 1:length(vis.names)) {
    name <- vis.names[[i]]
    result[[name]] <- i
  }
  result
}
