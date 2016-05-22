library(quantmod)
# The app is about plotting a stock chart, 4 indicators and in different format like line candlestick
# Download data for a stock if needed, and return the data
require_symbol <- function(symbol, envir = parent.frame()) {
  if (is.null(envir[[symbol]])) {
    envir[[symbol]] <- getSymbols(symbol, auto.assign = FALSE)
  }
  
  envir[[symbol]]
}


shinyServer(function(input, output) {
  
  # Create an environment for storing data
  symbol_env <- new.env()
  
  # Make a chart for a symbol, with the settings from the inputs
  make_chart <- function(symbol) {
    symbol_data <- require_symbol(symbol, symbol_env)
    
  # chartseries have input symbol,type of bar, indicator value, time range and logarithmic plot  
    chartSeries(symbol_data,
                name      = symbol,
                type      = input$chart_type,
                TA        =input$var,
                subset    = paste(input$daterange, collapse = "::"),
                log.scale = input$log_y,
                theme     = "white")
  }
  
  #ploting the chartseries by calling function make_chart
  output$plot_symb <- renderPlot({make_chart(input$symb) })
  
})