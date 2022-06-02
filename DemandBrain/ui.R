library(shiny)
library(forecast)

ui <- fluidPage(
  tabsetPanel(
    tabPanel("Forecast", fluid = TRUE,  
      titlePanel("The classic Box & Jenkins airline data: To predict the Airline tickets' sales from 1961 to 1970"),
        sidebarLayout(
           sidebarPanel(
              h4("Darwin Reynell Nava, Updated: June 1st 2022"),
              h4("Forecast"),
              h5("Time Series Prediction using the ARIMA Model"),
              sliderInput(inputId = "Years",
                     label = "select range of years",
                      min = 1961,
                      max = 1970,
                      value = 1),
              submitButton("Submit")
            ),
           # Main panel for displaying outputs ----
           mainPanel(
             tabsetPanel(type="tabs",
                         tabPanel("Forecast", br(), plotOutput(outputId = "Plot6")),
                         tabPanel("Summary", br(), verbatimTextOutput(outputId = "Print5"))
                         )
           )
         )
       )
    ), 
  tabsetPanel(  
      tabPanel("Validation", fluid = TRUE,  
               titlePanel("To Validate the ARIMA Model"),
                sidebarLayout(
                  sidebarPanel(
                     h4("Validation"),
                     h5("Time Series Prediction using the ARIMA Model"),
                     checkboxInput("ShowTest1","Show/Hide Ljung-Box Test, Lag=5", value = TRUE),
                     checkboxInput("ShowTest2","Show/Hide Ljung-Box Test, Lag=10", value = TRUE),
                     checkboxInput("ShowTest3","Show/Hide Ljung-Box Test, Lag=15", value = FALSE),
                     submitButton("Submit")
                  ),
                 # Main panel for displaying outputs ----
                  mainPanel(
                    tabsetPanel(type="tabs",
                                tabPanel("The AMIRA Model", br(), plotOutput(outputId = "Plot4"), verbatimTextOutput(outputId = "Print1")),
                                tabPanel("Residuals", br(), plotOutput(outputId = "Plot5")),
                                tabPanel("Ljung-Box Test", br(), verbatimTextOutput(outputId = "Print2"), verbatimTextOutput(outputId = "Print3"), verbatimTextOutput(outputId = "Print4"))
                    )
                  )
                )
      )
  ), 
  tabsetPanel(  
    tabPanel("Exploratory Analysis", fluid = TRUE,  
             titlePanel("Exploratory Analysis of the airline Industry from 1949 to 1960"),
              sidebarLayout(
                sidebarPanel(
                  h4("Exploratory Analysis"),
                  h5("Time Series Analysis"),
                  checkboxInput("ShowTrendline","Show/Hide Trend line", value = TRUE),
                  submitButton("Submit")
                 
                 ),
                # Main panel for displaying outputs ----
                 mainPanel(
                   tabsetPanel(type="tabs",
                               tabPanel("Dataset", br(), plotOutput(outputId = "Plot1"), verbatimTextOutput(outputId = "Plot11")),
                               tabPanel("Time Series Components", br(), plotOutput(outputId = "Plot2")),
                               tabPanel("The Cycle of Airline Tickets' Sales", br(), plotOutput(outputId = "Plot3"))
                   )
                 )
              )
    )
  )
)