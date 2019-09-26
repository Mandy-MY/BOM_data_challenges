library(tidyverse) #load the tidyverse

BOM_data <- read_csv("data/BOM_data.csv") # assign the BOM data to a variable
BOM_stations <- read_csv("data/BOM_stations.csv") # assign the stations data to a variable

# Challenge: For each station, how many days have a minimum temperature, a maximum temperature and a rainfall measurement recorded?
#read the full script as it follows a thought process to get to the fial result
#first need to separate the data in Temp_min_max, which is separated by a forward slash, to Temp_min and Temp_max
#check what it looks like - this "worked" but returned heaps of errors?? 
#OK, so errors were because I opened the file and saved from Excel - that's bad (excel converted some data), so I replaced the file from the download and it worked (phew!)

BOM_data_Temps <- separate(BOM_data,Temp_min_max, into = c("Temp_min", "Temp_max"), sep = "/")

# next need to filter for rows that have data in Temp_min, Temp_max and Rainfall

BOM_data_Temps %>% # takes the new dataframe
  filter(Temp_min > 0) %>% # filters for values in Temp_min
  filter(Temp_max > 0) %>% # filters for values in Temp_max
  filter(Rainfall > 0) %>% # filters for values in Rainfall (also note this could be done in a single step but split outfor ease of reading and logic)
  group_by(Station_number) %>%  # groups by station
  summarise(num_rows = n())

#OK, so now going back from question 2 we now realise that the rows are charachters so greater than zero won't actually give you the right result, and you actually want zero values as that is a measurement
#let's try again

BOM_data_Temps %>% # takes the new dataframe
  filter(as.numeric(Temp_min) >= 0) %>% # filters for values in Temp_min as numeric
  filter(as.numeric(Temp_max) >= 0) %>% # filters for values in Temp_max as numeric
  filter(as.numeric(Rainfall) >= 0) %>% # filters for values in Rainfall as numeric (also note this could be done in a single step but split outfor ease of reading and logic)
  group_by(Station_number) %>%  # groups by station
  summarise(num_rows = n())

# this actually just gives you everything because the NAs are still counted! G'ah!!

# let's try going back a step, as I'm overthinking it

BOM_data_station_records <- BOM_data_Temps %>% # takes the dataframe and creates a new one with the filtered data (that can be used later)
  filter(Temp_min >= 0) %>% # filters for values in Temp_min, R assumes anything that looks like a number as a number even though the filed is character
  filter(Temp_max >= 0) %>% # filters for values in Temp_max
  filter(Rainfall >= 0) # filters for values in rainfall

#now group and summarise the new dataframe containg the records

BOM_data_station_records %>% 
  group_by(Station_number) %>%  # groups by station
  summarise(num_rows = n())
