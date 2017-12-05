# Loading required libraries
library(ggplot2)
library(dplyr)
library(data.table)

# Reading relevant data
crime.data <- fread("crime_data.csv") %>%
              select(`Event Clearance Date`, Longitude, Latitude)
housing.data <- fread("data/kc_house_data.csv") %>% select(zipcode, lat, long)

# Plotting the graph
plot_crime <- function(input_housing_data, input_crime_data, input_zipcode) {
  # Filters the housing data so that we only need the required columns
  filtered_housing_data <- filter(input_housing_data, zipcode == input_zipcode)

  # Calculates a reference point according to the housing data. This reference point will be used to calculate crime.
  reference_point_lat <- mean(filtered_housing_data$lat)
  reference_point_long <- mean(filtered_housing_data$long)
  radius <- 0.08  # Radius of the circle around the reference point

  # Filters the crime data such that only the crimes around the reference point are considered
  filtered_crime_data <- filter(input_crime_data,
                                Latitude <= reference_point_lat + radius &&
                                Latitude >= reference_point_lat - radius &&
                                Longitude <= reference_point_long + radius &&
                                Longitude >= reference_point_long - radius)

  # Calculates the number of crimes in different years
  crime_in_2010 <- nrow(filtered_crime_data %>% filter(grepl("/2010", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2011 <- nrow(filtered_crime_data %>% filter(grepl("/2011", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2012 <- nrow(filtered_crime_data %>% filter(grepl("/2012", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2013 <- nrow(filtered_crime_data %>% filter(grepl("/2013", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2014 <- nrow(filtered_crime_data %>% filter(grepl("/2014", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2015 <- nrow(filtered_crime_data %>% filter(grepl("/2015", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2016 <- nrow(filtered_crime_data %>% filter(grepl("/2016", filtered_crime_data$`Event Clearance Date`)))
  crime_in_2017 <- nrow(filtered_crime_data %>% filter(grepl("/2017", filtered_crime_data$`Event Clearance Date`)))

  # Creates required dataframes for plotting
  Years <- c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017")
  Crime.frequency <- c(crime_in_2010, crime_in_2011, crime_in_2012, crime_in_2013,
                       crime_in_2014, crime_in_2015, crime_in_2016, crime_in_2017)
  print(Crime.frequency)
  plottable.data <- data.frame(Years, Crime.frequency)

  plot <- ggplot(plottable.data, aes(Years, Crime.frequency)) + geom_col()
  return(plot)
}
