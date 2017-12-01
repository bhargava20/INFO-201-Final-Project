library("dplyr")
library("lubridate")

# setwd("~/../Desktop/INFO 201/Final/INFO-201-Final-Project")

# Reading the csv files
file <- read.csv("data/kc_house_data.csv.bz2", stringsAsFactors = FALSE)
file2 <- read.csv("data/Seattle_Police_Department_911_Incident_Response.csv.bz2", stringsAsFactors = FALSE)

#preparation for the following variables
file <- arrange(file, -yr_built)
arr_file <- file%>%group_by(yr_built)%>%summarise(count=n())%>% arrange(-count)

# Top 3 years with the highest constructions
year_built1 <- arr_file[1,]
year_built2 <- arr_file[2,]
year_built3 <- arr_file[3,]

# The prefrence of number of bedrooms during the highest construction years.
bed_high1 <- file%>%filter(year_built1$yr_built==yr_built)%>%group_by(bedrooms)%>%summarise(count=n())%>%filter(count == max(count))
bed_high2 <- file%>%filter(year_built2$yr_built==yr_built)%>%group_by(bedrooms)%>%summarise(count=n())%>%filter(count == max(count))
bed_high3 <- file%>%filter(year_built3$yr_built==yr_built)%>%group_by(bedrooms)%>%summarise(count=n())%>%filter(count == max(count))

# The prefrence of number of bathrooms during the highest construction years.
bath_high1 <- file%>%filter(year_built1$yr_built==yr_built)%>%group_by(bathrooms)%>%summarise(count=n())%>%filter(count == max(count))
bath_high2 <- file%>%filter(year_built2$yr_built==yr_built)%>%group_by(bathrooms)%>%summarise(count=n())%>%filter(count == max(count))
bath_high3 <- file%>%filter(year_built3$yr_built==yr_built)%>%group_by(bathrooms)%>%summarise(count=n())%>%filter(count == max(count))

# The prefrence for number of floors during the highest construction years.
floor_high1 <- file%>%filter(year_built1$yr_built==yr_built)%>%group_by(floors)%>%summarise(count=n())%>%filter(count == max(count))
floor_high2 <- file%>%filter(year_built2$yr_built==yr_built)%>%group_by(floors)%>%summarise(count=n())%>%filter(count == max(count))
floor_high3 <- file%>%filter(year_built3$yr_built==yr_built)%>%group_by(floors)%>%summarise(count=n())%>%filter(count == max(count))

# Relation between Zipcodes and the Average Grade given to the buildings in that specific zipcode

con_zip <- file%>%group_by(zipcode)%>%summarise(avg=round(mean(grade),digits=2))%>%filter(avg==max(avg))

# crime location highest

loc_high <- file2%>%group_by(Hundred.Block.Location) %>% summarize(count = n()) %>% filter(count == max(count))

# Crime in each month across the months

cri_month <- file2$Event.Clearance.Date
get_month <- month(as.POSIXlt(cri_month, format = "%m/%d/%Y %I:%M:%S %p"))

file2 <- file2%>%mutate(month = get_month)
get_cri <- file2%>%group_by(month)%>%summarise(count = n())

# Month with the highest crime
get_max_cri <- get_cri%>%filter(count == max(count))