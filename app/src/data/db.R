# This is the main database connection file, which allows for data.frame access
# to the cancer cell line data.
library(RMySQL)

# Return a database connection with the default parameters.
GetConnection <- function() {
  dbConnect(MySQL(), user="jc", password="280487",
                  dbname="ccle", host="localhost")
}

# Close the provided connection.
CloseConnection <- function(connection) {
  dbDisconnect(connection)
}

# Return all the data in the Genetic Profile materialized view.
GetAll <- function() {
  conn <- GetConnection()
  result <- dbGetQuery(conn, "select * from GeneticProfileMatView;")
  CloseConnection(conn)
  result
}

# Select data for a specific gene symbol.  This is probably not needed as
# ApplyByGene allows for cursor iteration with a callback, and that's usually
# what is needed.
GetDataByGeneSymbol <- function(symbol) {
  conn <- GetConnection()
  statement <- paste0("select * from GeneticProfileMatView where symbol = '", symbol, "';")
  result <- dbGetQuery(conn, statement)
  CloseConnection(conn)
  result
}

# Iterate, cursor-like, through the data by Gene symbol.  The function parameter
# must be of the signature (data.frame, group.label)
ApplyByGene <- function(fun) {
  # fun: function(data.frame, group.label, ...)
  conn <- GetConnection()
  result <- dbSendQuery(conn,
                        "select * from GeneticProfileMatView order by symbol;")
  output <- dbApply(result, INDEX = 'symbol', fun)
  CloseConnection(conn)
  output
}

# Similarly to the function above, execute function for a gene.  However, this
# only executes the function on data with the matching gene symbol, instead of
# iterating through the data set.
ApplyForGene <- function(symbol, fun) {
  # fun: function(data.frame, group.label, ...)
  conn <- GetConnection()
  statement <- paste0(
    "select * from GeneticProfileMatView where symbol = '",
    symbol,
    "' order by symbol;"
    )
  result <- dbSendQuery(conn, statement)
  output <- dbApply(result, INDEX = 'symbol', fun)
  CloseConnection(conn)
  output
}
