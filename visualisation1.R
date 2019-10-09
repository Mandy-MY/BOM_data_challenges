#run script 3 to get the tidy, joined BOM data

# Challenge For the Perth station (ID 9225), produce three scatter plots showing the relationship between the maximum temperature and each other measurement recorded (minimum temperature, rainfall and solar exposure).

Perth_data <- BOM_stations_all %>% #create a dataframe for perth data
  filter(Station_number == 9225)

Perth_data_dbl <- mutate(Perth_data, 
         Temp_min = as.numeric(Temp_min),
         Temp_max = as.numeric(Temp_max),
         Rainfall= as.numeric(Rainfall),
         Solar_exposure = as.numeric(Solar_exposure)) # and correct columns so they are numeric (note NA error message)

#plot the data

ggplot(data = Perth_data_dbl, aes(
  x = Temp_max, 
  y = Temp_min,
  colour = Year)) +
  geom_point(alpha = 0.5)

ggplot(data = Perth_data_dbl, aes(x = Temp_max, y = Rainfall)) +
  geom_point(alpha = 0.5)

ggplot(data = Perth_data_dbl, aes(x = Temp_max, y = Solar_exposure)) +
  geom_point(alpha = 0.5)

# Challenge; Display these four measurements for the Perth station in a single scatter plot by using additional aesthetic mappings.

ggplot(data = Perth_data_dbl,
       aes(x = Temp_max,
           y = Temp_min,
           colour = Rainfall,
           size = Solar_exposure)) +
  geom_point() #option 1 (not so good, but kept here for display purposes)

ggplot(data = Perth_data_dbl,
       aes(x = Temp_max,
           y = Temp_min,
           colour = Solar_exposure,
           size = Rainfall)) +
  geom_point() # option 2 a better aesthetic, we'll use this


#Challenge: Take the four plots you have produced in Q1 and Q2 and save them as a multi-panel figure.

# Install the 'cowplot' pakage to enable combining them into one use example code plot_grid(plot1, plot2, plot3, plot4),
install.packages("cowplot")
# Install the library from cowplot
library(cowplot)

# take the code above and create plots

Temp_Max_Min <- ggplot(data = Perth_data_dbl, aes(
  x = Temp_max, 
  y = Temp_min,
  colour = Year)) +
  geom_point(alpha = 0.5)

Temp_max_Rainfall <- ggplot(data = Perth_data_dbl, aes(x = Temp_max, y = Rainfall)) +
  geom_point(alpha = 0.5)

Temp_Max_Solar <- ggplot(data = Perth_data_dbl, aes(x = Temp_max, y = Solar_exposure)) +
  geom_point(alpha = 0.5)

Perth_measures <- ggplot(data = Perth_data_dbl,
       aes(x = Temp_max,
           y = Temp_min,
           colour = Solar_exposure,
           size = Rainfall)) +
  geom_point()

plot_grid(Temp_Max_Min, Temp_max_Rainfall, Temp_Max_Solar, Perth_measures)

