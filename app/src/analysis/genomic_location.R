# Generate plots based on the genomic location of the genes, which might change
# the copy number and possibly expression values.
library(shiny)
source('src/data/db.R')

# Get a genetic profile dump ordered by genomic location (chromosome, start,
# end)
GetGenomicLocationOrderedGeneticProfile <- function() {
  data <- GetAll()

  # Replace X and Y chromosome entries with '23' so that conversion to numeric
  # places them at the end of the chromosome order
  data$chromosome[data$chromosome %in% c('X', 'Y')] <- '23'
  data$numeric.chromosome <- as.numeric(data$chromosome)

  ordered <- with(data, order(numeric.chromosome,
                              chromosomeLocationStart,
                              chromosomeLocationEnd))
  data[ordered, ]
}

# Plot both the Copy Number and the Gene Expression of the provided data ordered
# by genomic location.
GetGenomicLocationPlots <- function(data, title = NULL) {
  x <- 1:nrow(data)
  result <- list(
    list(
      graph.type = "plot",
      visualization = function() {
        y <- data$snpCopyNumber2Log2
        ylim <- c(min(y), max(y))

        plot(x = x, y = y,
             xlab = 'Genomic location', ylab = 'Gene Copy Number',
             main = 'Gene Copy Number by Genomic Location',
             type = 'p', ylim = ylim, pch = 20)
      }
    ),
    list(
      graph.type = "plot",
      visualization = function() {
        y <- data$quantileNormalizedRMAExpression
        ylim <- c(min(y), max(y))

        plot(x = x, y = y,
             xlab = 'Genomic location', ylab = 'Gene Expression',
             main = 'Gene Expression by Genomic Location',
             type = 'p', ylim = ylim, pch = 20)
      }
    )
  )

  if (!is.null(title)) {
    result <- append(result, list(list(
      graph.type = 'h3',
      visualization = function() {
        title
      })), 0)
  }
  result
}

# Plot all the data according to genomic location (this is a very messy
# visualization, but it may provide insight or really strange results)
GenomicLocations <- function() {
  data <- GetGenomicLocationOrderedGeneticProfile()
  GetGenomicLocationPlots(data)
}

# Plot the genomic location ordered data for selected cell lines.
GenomicLocationsForSelectedCellLines <- function() {
  lines <- c('AU565_BREAST', 'BT474_BREAST', 'BT483_BREAST')
  data <- GetGenomicLocationOrderedGeneticProfile()

  # Lapply returns a list of list items, each of which is a plot definition;
  # it needs to be unlisted one level so that it is list of plot definitions,
  # as is expected by calling functions.
  # This is due to GetGenomicLocationPlots, called in GenomicLocationsByCellLine,
  # returning a list of plot definitions.
  all.plots <- lapply(lines, function(line) {
    force(line)
    GenomicLocationsByCellLine(line, data)
  })
  unlist(all.plots, recursive = FALSE)
}

# Get the genomic location ordered data for a specific cell line.
GenomicLocationsByCellLine <- function(line, data) {
  line.data <- data[with(data, ccleName == line), ]
  GetGenomicLocationPlots(line.data, title = paste('Genomic location for', line))
}
