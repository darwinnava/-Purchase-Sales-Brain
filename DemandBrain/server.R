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
    mymodel = auto.arima(AirPassengers)
    plot(mymodel)
    
  })  
  
  output$Print1 <- renderPrint({
    #summary of my ARIMA model
    summary(mymodel)
    
  }) 

  output$Plot5 <- renderPlot({
    #plot the residuals
    plot.ts(mymodel$residuals)
    
  }) 
  
  output$Plot6 <- renderPlot({
    #plot forecast for the nest N years
    n <- input$Years - 1960
    myforecast1 <- forecast(mymodel, level = c(95), h=n*12)
    plot(myforecast1)
  }) 

  output$Print5 <- renderPrint({
    # Table summary of my forecasting
    n <- input$Years - 1960
    myforecast1 <- forecast(mymodel, level = c(95), h=n*12)
    summary(myforecast1)
  }) 
  
  output$Print2 <- renderPrint({
    # Validate the model by selecting lag values
   ifelse(input$ShowTest1, Box.test(mymodel$residuals, lag = 5, type = "Ljung-Box"),"")
  }) 

  output$Print3 <- renderPrint({
    # Validate the model by selecting lag values
    ifelse(input$ShowTest2, Box.test(mymodel$residuals, lag = 10, type = "Ljung-Box"),"")
    }) 
  output$Print4 <- renderPrint({
    # Validate the model by selecting lag values
    ifelse(input$ShowTest3, Box.test(mymodel$residuals, lag = 15, type = "Ljung-Box"),"")
  }) 
  

  
}) 
