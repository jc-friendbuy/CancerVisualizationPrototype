# This simple script will install the packages required to run the project.

package.list <- c(
  'reshape2',
  'rgl',
  'RMySQL',
  'shiny',
  'shinyRGL'
  )
install.packages(package.list)

print('Make sure the working directory points to the `app` directory (for instance: setwd("~/Projects/panther/app/")')
print('Then, run `source("server.R")` followed by `shiny::runApp()`')
