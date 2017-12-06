#loads necessary libraries
library(shiny)
library(dplyr)
library(plotly)



#Generates an interactive User Interface with input panels
shinyUI(fluidPage(
  titlePanel("Housing in Seattle"), 
  br(),
  p("Living in Seattle, we often hear about how high housing prices are. But how high are they really?"),
  p("We can use the following tools to find out, as well as to see other interesting information."),
  br(), 
  
  h3("Prices"),
  p("Let's begin with housing prices. Enter a zipcode below to see a scatterplot of prices, sorted by the month in which they were sold."),
  p("This dataset contains houses sold in King County from May 2014 to May 2015"),
  br(),

  mainPanel(
    plotlyOutput('plot'), 
    textInput("zip_code", "Zip Code:", value = 98105, placeholder = "ex. 98105"),
    textOutput('plot_error_msg')
  ),
    
      
  mainPanel(
    br(), 
    
    p("Interesting, right? Did you see any noteworthy patterns?"),
    
    br(), 
    
    h3("Next, let's look at some summary information on all the houses sold."),
    
    br(), 
    textOutput('years'), 
    
    br(),
    
    p("What were the construction preferences like, by year?"),
    p("Enter a year below to find out"),
    textInput("bbf_year", "Year",value = 2000, placeholder = "ex. 2000"), #bbf stands for bed, bath, floor
    textOutput("bbf_out"), 
    
    br(), 
    p("What about building quality? Enter a zip code to see average building quality on a scale from 1 to 10"),
    textInput("zip_code_qual", "Zip Code:", value = 98105, placeholder = "ex. 98105"),
    textOutput('qual'),
    textOutput('qual_error_msg'),
    
    br(), 
    h3("Criminal Connections? Perhaps"),
    p("Are the prices related to crime at all? Use the following tools to search for a correlation."),
    p("Is your zip code a safe place to live?"),
    p("Here's a graph of crime incidences over several years."),
    
    br(),
    plotOutput('crime_plot'),
    textInput("zip_code_crime", "Zip Code:", value = 98105, placeholder = "ex. 98105"),
    textOutput('crime_plot_error_msg'),
    
    br(),
    h3("Crime Statistics"),
    p("Now, let's see some summary information on crime."),
    
    br(), 
    p("Here's a breakdown of total crimes in King County over the years, across every month"),
    
    tableOutput('monthly_crime'),
    
    p("Strange, right? It looks like some months are more predisposed to crime than others."), 
    p("Can you think of any potential reasons for this?"),
    
    br(),
    textOutput("max_crime_month"),
    
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br()
    
  )  
  
  
  
))
