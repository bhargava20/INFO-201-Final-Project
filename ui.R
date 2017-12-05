#loads necessary libraries
library(shiny)
library(dplyr)

# source("Summary info.R")
# source("housing_price_plot.R")

#Generates an interactive User Interface with input panels
shinyUI(fluidPage(
  titlePanel("Housing in Seattle"), 
  br(),
  p("Housing prices in Seattle have always been high, or have they? They're certainly worse than they used to be, right?"),
  br(), 
  p("Maybe, maybe not. Let's examine housing prices over time. Enter any King County zipcode, and see the results"),
  p("This dataset contains houses sold in King County from May 2014 to May 2015"),

  mainPanel(
    plotOutput('plot'), 
    textInput("zip_code", "Zip Code:", value = 98178, placeholder = "ex. 98178"),
    textOutput('plot_error_msg')
  ),
    
      
  mainPanel(
    br(), 
    
    p("What do you think about the data? Surprised? Shocked? Confused?"),
    
    p("Let's look at some summary information on all the houses sold."), 
    
    textOutput('years'), 
    
    br(),
    
    p("What were the construction preferences like, by year?"),
    p("Enter a year below to find out"),
    textInput("bbf_year", "Year",value = 2000, placeholder = "ex. 2000"), #bbf stands for bed, bath, floor
    textOutput("bbf_out"), 
    
    br(), 
    p("What about building quality? Enter a zip code to see average building quality on a scale from 1 to 10"),
    textInput("zip_code_qual", "Zip Code:", value = 98178, placeholder = "ex. 98178"),
    textOutput('qual'),
    textOutput('qual_error_msg'),
    
    br(), 
    
    p("Now, let's examine the summary information on crime."),
    br(), 
    p("Here's a breakdown of total crimes across every month"),
    
    tableOutput('monthly_crime'),
    
    textOutput("max_crime_month")
    
  )  
  
  
  
))