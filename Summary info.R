library("dplyr")
library("lubridate")

# setwd("~/../Desktop/INFO 201/Final/INFO-201-Final-Project")

# Reading the csv files
file <- read.csv("data/kc_house_data.csv.bz2", stringsAsFactors = FALSE)
file2 <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv.bz2", stringsAsFactors = FALSE)

# Smaller crimedata csv file
file2 <- file2%>%select(Event.Clearance.Date,Hundred.Block.Location)

#preparation for the following variables
file <- arrange(file, -yr_built)
arr_file <- file%>%group_by(yr_built)%>%summarise(count=n())%>% arrange(-count)

# Top 3 years with the highest constructions
year_built1 <- arr_file[1,]
year_built2 <- arr_file[2,]
year_built3 <- arr_file[3,]

# The prefrence of number of bedrooms during the a specific construction years.
bed <- function(yr){
  bed.yr <- file%>%filter(yr == yr_built)%>%group_by(bedrooms)%>%summarise(count = n())%>%filter(count == max(count)) %>% select(bedrooms)

  return(bed.yr)
}

# The prefrence of number of bathrooms during a specific construction years.
bath <- function(yr){
  bath.yr <- file%>%filter(yr == yr_built)%>%group_by(bathrooms)%>%summarise(count = n())%>%filter(count == max(count)) %>% select(bathrooms)

  return(bath.yr)
}

# The prefrence for number of floors during a specific year construction years.
floor <- function(yr){
  floor.yr <- file%>%filter(yr == yr_built)%>%group_by(floors)%>%summarise(count = n())%>%filter(count == max(count)) %>% select(floors)

  return(floor.yr)
}

# Relation between Zipcodes and the Average Grade given to the buildings in that specific zipcode
high_zip <- function(zipcode){
  get_avg_grade <- file %>% filter(zipcode == zipcode) %>% summarize(avg = round(mean(grade), digits = 1)) %>% select(avg)

  return(get_avg_grade)
}


# crime location highest
loc_high <- file2%>%group_by(Hundred.Block.Location) %>% summarize(count = n()) %>% filter(count == max(count))


# Crime in each month across the months
cri_month <- file2$Event.Clearance.Date
get_month <- month(as.POSIXlt(cri_month, format = "%m/%d/%Y %I:%M:%S %p"))

file2 <- file2%>%mutate(month = get_month)
get_cri <- file2%>%group_by(month)%>%summarise(count = n())%>%filter(month != "NA")

# Month with the highest crime
get_max_cri <- get_cri%>%filter(count == max(count))
