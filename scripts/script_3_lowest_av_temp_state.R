library(tidyverse) #load the tidyverse

#replicate the solutions from scrpit 1 if running this script only

BOM_data <- read_csv("data/BOM_data.csv") # assign the BOM data to a variable

BOM_data_Temps <- separate(BOM_data,Temp_min_max, into = c("Temp_min", "Temp_max"), sep = "/")# create the separated temperature columns in a new variable BOM_data_Temps

BOM_data_station_records <- BOM_data_Temps %>% # takes the previous dataframe and creates a new one with the filtered data (that can be used later)
  filter(Temp_min >= 0) %>% # filters for values in Temp_min, R assumes anything that looks like a number as a number even though the field is character
  filter(Temp_max >= 0) %>% # filters for values in Temp_max
  filter(Rainfall >= 0) # filters for values in rainfall

#Question: Which State saw the lowest average daily temperature difference?

#we don't have State informtation in the BOM_data_station_records so we need to get this from the BOM_stations.csv using gather

BOM_stations <- read_csv("data/BOM_stations.csv")# create the stations variable

#data effectively needs to be transposed, so we can gather then spread
#gather(dataset, where_to_store_column_names, where_to_store_values, what_to_gather) (edited) 
#spread(dataset, which_column_to_create_new_column_names, which_column_to_get_the_values) (edited)

BOM_stations_tidy <- BOM_stations %>% #create a tidy dataframe
  gather(station_number,stations_details,-info) %>% # gather the data into two new columns excluding the info (this will bring the data against the info column into rows)
  spread(info,stations_details) %>%  # spread the data back out but now it will display the stations_number against the other variables
  mutate(station_number = as.numeric(station_number)) # gets over the issue that it created the column as chr, because it needs to be dbl to join in teh next step

#now we have tidy data we need to assign this tidy data to the BOM_data_station_records by Joining it

BOM_stations_all <- full_join(BOM_data_station_records,BOM_stations_tidy, by = c("Station_number" = "station_number")) #but the station number in the two data files is different (chr vs dbl)

#now we have joined data we need to group by state and calcualte the mean difference

BOM_stations_all %>% 
  group_by(state) %>% 
  summarise(Mean_State_Temp_diff = mean(Temp_diff))
