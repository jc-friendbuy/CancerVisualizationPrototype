# This file allows for configuring visualizations, basically matching names to
# functions which can display graphs on the front end.

source('src/analysis/correlation.R')
source('src/analysis/genomic_location.R')
source('src/analysis/expression_mixed_modeling.R')

# This list / hash table maps names to visualization functions and allows one of
# the visualizations to be selected via an index.
visualization.list <- list(
  '--' = '',
  'Correlation Histogram' = CorrelationHistogram,
  'Linear fits to correlation indexes' = CorrelationFits,
  'Copy Number and Gene Expression relationship' = SideBySideCNAndGE,
  'Genomic location analysis' = GenomicLocations,
  'Genomic location for some cell lines' = GenomicLocationsForSelectedCellLines,
  'Expression mixed modeling' = ExpressionMixedGaussianModel
)

# Return a list of items contained in the visualization list above (note R
# lists work like hash tables, so it is basically an index for which
# visualization function to run based on a selection).
GetVisualizationFunctionChoices <- function() {
  vis.names <- names(visualization.list)
  result <- list()
  for (i in 1:length(vis.names)) {
    name <- vis.names[[i]]
    result[[name]] <- i
  }
  result
}
