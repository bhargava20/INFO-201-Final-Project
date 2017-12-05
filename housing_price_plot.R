# Loading required libraries
library(ggplot2)
library(dplyr)

# Reading the data 
kc_house_data <- read.csv("data/kc_house_data.csv",header = T)

# Subsetting date coloumn to get into required format
kc_house_data$date <- substring(kc_house_data$date,0,8)
date <- kc_house_data$date
year <- substring(date,0,4)
month <- substring(date,5,6)
day <- substring(date,7,8)
kc_house_data$date <- paste(year,"-",month,"-",day)
kc_house_data$date <- as.Date(kc_house_data$date, format = "%Y - %m - %d")

# Generating trend of housing prices over time based on zipcode entered by user
plot_prices <- function(housing_data,input_zipcode){
  filtered_data <- housing_data %>%
    filter(zipcode == input_zipcode) %>%
    select(date,price,zipcode)
  x <- list(title = "date")
  y <- list(title = "price")
  plot <- plot_ly(filtered_data,x=filtered_data$date,y=filtered_data$price,type = "scatter",color = "red") %>% 
    layout(xaxis = x, yaxis = y,margin = list(b = 160))
  
   return(plot)
}

