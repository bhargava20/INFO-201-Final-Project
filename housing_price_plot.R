library(ggplot2)
library(dplyr)

kc_house_data <- read.csv("data/kc_house_data.csv",header = T)
kc_house_data$date <- substring(kc_house_data$date,0,8)
date <- kc_house_data$date
year <- substring(date,0,4)
month <- substring(date,5,6)
day <- substring(date,7,8)
kc_house_data$date <- paste(year,"-",month,"-",day)
kc_house_data$date <- as.Date(kc_house_data$date, format = "%Y - %m - %d")

plot_prices <- function(housing_data,input_zipcode){
  filtered_data <- housing_data %>%
    filter(zipcode == input_zipcode) %>%
    select(date,price,zipcode)
    plot <- ggplot(filtered_data,aes(x=filtered_data$date,y=filtered_data$price))+geom_line()+
      ggtitle("Housing prices based on zipcode")+xlab("date")+ylab("price")
    return(plot)
}

