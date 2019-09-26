library(tidyverse) #load the tidyverse

#replicate the solutions from scrpit 1 if running this script only

BOM_data <- read_csv("data/BOM_data.csv") # assign the BOM data to a variable

BOM_data_Temps <- separate(BOM_data,Temp_min_max, into = c("Temp_min", "Temp_max"), sep = "/")# create the separated temperature columns in a new variable BOM_data_Temps

BOM_data_station_records <- BOM_data_Temps %>% # takes the previous dataframe and creates a new one with the filtered data (that can be used later)
  filter(Temp_min >= 0) %>% # filters for values in Temp_min, R assumes anything that looks like a number as a number even though the field is character
  filter(Temp_max >= 0) %>% # filters for values in Temp_max
  filter(Rainfall >= 0) # filters for values in rainfall

#Question: Which month saw the lowest average daily temperature difference?

#first need to use the BOM_data_station_records data frame and create a column for the temperature difference between max and min temps

BOM_data_Temps_all <- BOM_data_station_records %>% 
  mutate(Temp_diff = (as.numeric(Temp_max) - as.numeric(Temp_min)))# creates a new calculated column taking the character values and treating them as numeric values

# now need to calculate the average temperature difference by month (and year?)

Temp_by_month <- BOM_data_Temps_all %>% # creates a variable from the dataframe with the new column for temperature difference
  group_by(Month) %>% # groups the data by month (month only for this example)
  summarise(
    Mean_Temp_diff = mean(Temp_diff), #summarises the grouped data by month in a new column to display the mean of the Temp_diff
    Median_Temp_diff = median(Temp_diff), # and just for fun and practice, summarises the grouped data by month in a new column to display the median of the Temp_diff
    Min_Temp_diff = min(Temp_diff), # and just for fun and practice, summarises the grouped data by month in a new column to display the min of the Temp_diff
    Max_Temp_diff = max(Temp_diff)) # and just for fun and practice, summarises the grouped data by month in a new column to display the max of the Temp_diff

#write the result to a file in the results folder

write_csv(Temp_by_month, path = "results/Temps_by_month.csv")
