library(tidyverse) #load the tidyverse

BOM_data <- read_csv("data/BOM_data.csv") # assign the BOM data to a variable
BOM_stations <- read_csv("data/BOM_stations.csv") # assign the stations data to a variable

# Challenge: For each station, how many days have a minimum temperature, a maximum temperature and a rainfall measurement recorded?
#first need to separate the data in Temp_min_max, which is separated by a forward slash, to Temp_min and Temp_max
#check what it looks like - this "worked" but returned heaps of errors?? 
#OK, so errors were because I opened the file and saved from Excel - that's bad (excel converted some data), so I replaced the file from the download and it worked (phew!)

BOM_data_Temps <- separate(BOM_data,Temp_min_max, into = c("Temp_min", "Temp_max"), sep = "/")

# next need to filter for rows that have data in Temp_min, Temp_max and Rainfall

BOM_data_Temps %>% # takes the new datafram
  filter(Temp_min > 0) %>% # filters for values in Temp_min
  filter(Temp_max > 0) %>% # filters for values in Temp_max
  filter(Rainfall > 0) %>% # filters for values in Rainfall (also note this could be done in a single step but split outfor ease of reading and logic)
  group_by(Station_number) %>%  # groups by station
  summarise(num_rows = n())
  

