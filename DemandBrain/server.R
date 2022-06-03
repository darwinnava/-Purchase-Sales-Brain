library(shiny)
library(forecast)
library(datasets)
library(colorspace)
library(fracdiff)
library(ggplot2)
library(graphics)
library(lmtest)
library(magrittr)
library(nnet)
library(parallel)
library(Rcpp)
library(stats)
library(timeDate)
library(tseries)
library(urca)
library(zoo)
data("AirPassengers", package = "datasets")

shinyServer(function(input, output) {

  ablinez <- reactive({
    # Display the dataset
    a <- input$ShowTrendline
    if(a){abline(reg = lm(AirPassengers ~ time(AirPassengers)))
    }
  })
  
  output$Plot1 <- renderPlot({
    # Display the dataset
    plot(AirPassengers)
    ablinez()
    
  })
  output$Plot11 <- renderPrint({
    # Display the dataset
    AirPassengers
  })  
  output$Plot2 <- renderPlot({
    #decompose the data into four components
    tsdata <- ts(AirPassengers, frequency = 12)
    ddata <- decompose(tsdata, "multiplicative")
    plot(ddata)

  })
  output$Plot3 <- renderPlot({
    #Create a boc plot by cycle
    boxplot(AirPassengers ~ cycle(AirPassengers), xlab="Month", ylab = "Sold Ticket Number", main="The Cycle of Airlines Tickets' Sales")

  })  

  output$Plot4 <- renderPlot({
    #Build the ARIMA model
    me <- auto.arima(AirPassengers)
    plot(me)
  })  
  
  output$Print1 <- renderPrint({
    #summary of my ARIMA model
    me <- auto.arima(AirPassengers)
    summary(me)
    
  }) 

  output$Plot5 <- renderPlot({
    #plot the residuals
    me <- auto.arima(AirPassengers)
    plot.ts(me$residuals)
    
  }) 
  
  output$Plot6 <- renderPlot({
    #plot forecast for the nest N years
    ma <- auto.arima(AirPassengers)
    n <- input$Years - 1960
    myforecast1 <- forecast(ma, level = c(95), h=n*12)
    plot(myforecast1)
  }) 

  output$Print5 <- renderPrint({
    # Table summary of my forecasting
    me <- auto.arima(AirPassengers)
    n <- input$Years - 1960
    myforecast1 <- forecast(me, level = c(95), h=n*12)
    summary(myforecast1)
  }) 
  
  output$Print2 <- renderPrint({
    me <- auto.arima(AirPassengers)
    # Validate the model by selecting lag values
   ifelse(input$ShowTest1, Box.test(me$residuals, lag = 5, type = "Ljung-Box"),"")
  }) 

  output$Print3 <- renderPrint({
    me <- auto.arima(AirPassengers)
        # Validate the model by selecting lag values
    ifelse(input$ShowTest2, Box.test(me$residuals, lag = 10, type = "Ljung-Box"),"")
    }) 
  output$Print4 <- renderPrint({
    me <- auto.arima(AirPassengers)
    # Validate the model by selecting lag values
    ifelse(input$ShowTest3, Box.test(me$residuals, lag = 15, type = "Ljung-Box"),"")
  }) 
  

  
}) 
