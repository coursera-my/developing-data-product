library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {
   
  output$table <- renderDataTable({
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    wt_seq <- seq(from = input$wt[1], to = input$wt[2], by =0.001)
    data <- transmute(mtcars, Car = rownames(mtcars), MPG = mpg, Cylinders = cyl, 
                      HP = hp, Transmission = am, Weight = wt,
                      GassConsumption = input$dis/mpg, GassCost = (input$dis/mpg)*2.55)
    data <- filter(data, Cylinders %in% input$cyl, HP %in% hp_seq, Transmission %in% input$am,
                   Weight %in% wt_seq)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, GassCost)
    #data <- filter(mtcars,cyl %in% input$cyl, am %in% input$am, hp %in% hp_seq, wt %in% wt_seq)
    data
    
  },
  options = list(lengthMenu = c(5, 10, 15), pageLength = 5)
  )
  
  output$disphp <- renderPlot({
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    wt_seq <- seq(from = input$wt[1], to = input$wt[2], by =0.001)
    data1 <- transmute(mtcars, MPG = mpg, Cylinders = cyl, 
                      HP = hp, Transmission = am, Weight = wt,
                      GassConsumption = input$dis/mpg, GassCost = (input$dis/mpg)*2.55)
    data1 <- filter(data1, Cylinders %in% input$cyl, HP %in% hp_seq, Transmission %in% input$am,
                   Weight %in% wt_seq)
    data1 <- mutate(data1, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    plot(HP ~ GassCost, data1, col=Cylinders, lwd=5)
  })
  
  output$dispwt <- renderPlot({
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    wt_seq <- seq(from = input$wt[1], to = input$wt[2], by =0.001)
    data1 <- transmute(mtcars, MPG = mpg, Cylinders = cyl, 
                       HP = hp, Transmission = am, Weight = wt,
                       GassConsumption = input$dis/mpg, GassCost = (input$dis/mpg)*2.55)
    data1 <- filter(data1, Cylinders %in% input$cyl, HP %in% hp_seq, Transmission %in% input$am,
                    Weight %in% wt_seq)
    data1 <- mutate(data1, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    plot(Weight ~ GassCost, data1, col=Cylinders, lwd=5)
  })
  
})
