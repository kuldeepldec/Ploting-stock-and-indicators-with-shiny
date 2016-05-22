library(shiny)

shinyUI(fluidPage(
  # title of the output
  titlePanel("Stock and Indicators Plot"),
  
  sidebarLayout(
   # text input for the symbol to plot chart 
    sidebarPanel(
      textInput("symb", "Symbol Name", "SPY"), 
   # input for type of the chart    
      selectInput(inputId = "chart_type",
                  label = "Chart type",
                  choices = c("Candlestick" = "candlesticks",
                              "Matchstick" = "matchsticks",
                              "Bar" = "bars",
                              "Line" = "line")
                  
      ),
        
      helpText("Select Indicators"),
      
  # input for indicators we have selected four inputs 
      selectInput(inputId="var", 
                  label = "Choose an indicator to display",
                  choices = c("ADX"="addADX()", "Bband"="addBBands()",
                              "CCI"="addCCI()","RSI"="addRSI()")
                  ),
  # date range for the ploting the chart    
      dateRangeInput(inputId = "daterange", label = "Date range",
                     start = Sys.Date() - 365, end = Sys.Date()),
  # ploting log value of the chart    
      checkboxInput(inputId = "log_y", label = "log y axis", value = FALSE)
      
      
      ),
  # main panel for ploting the chart  
    mainPanel(
      
      conditionalPanel(condition = "input.symb",
      br(),
      div(plotOutput(outputId = "plot_symb")))
    )
  )
))