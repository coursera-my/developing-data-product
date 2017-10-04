library(shiny)

shinyUI(navbarPage("The Best Car for Your Needs",
  tabPanel("Data",
                    
  sidebarLayout(
    sidebarPanel(
      helpText("Hello, you can input these fields below to have a car model comparison with a Gass cost calculation for a distance as in input field."),
      helpText("And you can see 2 plots to compare a variation value of Horsepower and Weight to Gass Cost for spesific distance that inputted."),
      helpText("Please input the car specification that you need below:"), 
      checkboxGroupInput('cyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
      checkboxGroupInput('am','Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1)),
      numericInput('dis', 'Daily distance (in miles):', 50, min = 1, max = 1000),
      sliderInput('hp', 'Gross horsepower:', min=min(mtcars$hp), max=max(mtcars$hp), value=c(min(mtcars$hp),max(mtcars$hp)), step=10),
      sliderInput('wt', 'Weight (1000 lbs):', min=min(mtcars$wt), max=max(mtcars$wt), value=c(min(mtcars$wt),max(mtcars$wt)), step=0.5)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data",
                 dataTableOutput('table')
                 ),
        tabPanel("Plot",h3("Cost vs Horsepower"),
                 plotOutput("disphp"),
                 h3("Cost vs Weight"),
                 plotOutput("dispwt")
                 )
      )
    )
  )
  
  ),
  
  tabPanel("About",
           mainPanel(
             h3("Developing Data Product Course Project"),
             h4("Motor Trend Car Road Data"),
             h5("The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."),
             h5("This dataset is available in original R instalation."),
             h5("The Source code is available in Github: https://github.com/coursera-my/developing-data-product"),
             h4("The Application:"),
             h5("In this application, you can input the car specification data, which are: Number of Cylinder, transmission type,
                daily distance to travel, gross horsepower and car weight, to get the list of car that include on your specification. 
                This application also shows the calculation about how much the gass consumption and cost for the distance you travel in,
                with assumption Gas price per gallon is US$2.55."),
             h5("Also we have 2 plots that show relationship between Gass Cost and Horsepower & Weight. ")
           )
  )
  
)
)