#Loads necessary libraries
library(shiny)
library(ggplot2)
source("housing_price_plot.R")

#Processes data in such a way to enable visualization in ui.R
shinyServer(function(input, output){
  kc_house_data <- read.csv("data/kc_house_data.csv",header = T)
  

 
  #Generates a plot
  output$plot <- renderPlot({
    p <- plot_prices(kc_house_data, input$zip_code)
    
    print(p)
 })
  
  output$plot_error_msg <- renderText({
    zips <- kc_house_data %>% select(zipcode) %>% unique()
    zips <- zips$zipcode
    if(input$zip_code %in% zips){
      ""
    } else {
      paste0("Sorry, we have no data on ", input$zip_code)
    }
    
  })  
    
   #render the summary stats
  output$years <- renderText({ 
    paste0("Most of the houses sold were constructed in ", year_built1$yr_built, ", with ", year_built1$count, " houses sold. ", 
          "The next most popular year was ", year_built2$yr_built, ", with ", year_built2$count, " houses sold.", 
          "The third most popular year was ", year_built3$yr_built, ", with ", year_built3$count, " houses sold.")

  })
  
  
  output$qual<- renderText({
    paste0("The average building quality in zip code ", input$zip_code_qual, "is ", high_zip(input$zip_code_qual))
  })
  
  output$qual_error_msg <- renderText({
    zips <- kc_house_data %>% select(zipcode) %>% unique()
    zips <- zips$zipcode
    if(input$zip_code_qual %in% zips){
      ""
    } else {
      paste0("Sorry, we have no data on ", input$zip_code)
    }
    
  })
  
  output$highest_crime_spot <- renderText({
    paste0("The one block in seattle with the highest incidence of crime is the" , loc_high$Hundred.Block.Location, ", with ", loc_high$count, " incidents in the database")
  })
  
  output$monthly_crime <- renderTable({
    get_cri$month <- month.name
    monthly_crime <- t(get_cri)
    monthly_crime
  }, include.rownames = FALSE, include.colnames = FALSE)
  
  output$max_crime_month <- renderText({
    month <- month.name[get_max_cri$month]
    paste0("The month with the highest crime was ", month, ", with a total of ", get_max_cri$count, " crimes across the years.")
    
  
  })
  
  output$bbf_out <- renderText({
    beds <- bed(input$bbf_year)$bedrooms
    baths <- bath(input$bbf_year)$bathrooms
    floors <- floor(input$bbf_year)$floors
    
    if(length(beds) != 0){
    paste0("Houses built in the year ", input$bbf_year, " tended to contain ", floors, " floors, ", beds, " bedrooms, and ", baths, " bathrooms.")
    } else {
      paste0("Sorry, data is not available for houses constructed in the year ", input$bbf_year, " and sold from May 2014 to May 2015 in King County")
    }
  })
  
})