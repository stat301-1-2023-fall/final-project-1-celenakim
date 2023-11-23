library(tidyverse)
library(janitor)


## Deleting last column from 2011-2018 data frames
years_one <- 2011:2018
for (year in years_one) {
  current_data <- get(paste0("data_", year))
  
  current_data <- current_data[, -ncol(current_data)]
  
  assign(paste0("data_", year), current_data)
}

## Renaming variables and deleting last two columns from 2019-2022 data frames
years_two <- 2019:2022
for (year in years_two) {
  current_data <- get(paste0("data_", year))
  
  current_data <- current_data |> 
    rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
           of.Gross.earned.abroad = X..of.Gross.earned.abroad)
  
  current_data <- current_data[, -c((ncol(current_data) - 1):ncol(current_data))]
  
  assign(paste0("data_", year), current_data)
}



movie_data <- rbind(data_2007, data_2008, data_2009,
                    data_2010, data_2011, data_2012,
                    data_2013, data_2014, data_2015,
                    data_2016, data_2017, data_2018,
                    data_2019, data_2020, data_2021,
                    data_2022)

write.csv(movie_data, "movie_data.csv", row.names = FALSE)



## Initial ode without for loops
# data_2011 <- data_2011[, -ncol(data_2011)]
# 
# data_2012 <- data_2012[, -ncol(data_2012)]
# 
# data_2013 <- data_2013[, -ncol(data_2013)]
# 
# data_2014 <- data_2014[, -ncol(data_2014)]
# 
# data_2015 <- data_2015[, -ncol(data_2015)]
# 
# data_2016 <- data_2016[, -ncol(data_2016)]
# 
# data_2017 <- data_2017[, -ncol(data_2017)]
# 
# data_2018 <- data_2018[, -ncol(data_2018)]

# data_2019 <- data_2019 |> 
#   rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
#          of.Gross.earned.abroad = X..of.Gross.earned.abroad)
# data_2019 <- data_2019[, -c((ncol(data_2019) - 1):ncol(data_2019))]
# 
# data_2020 <- data_2020 |> 
#   rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
#          of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
# data_2020 <- data_2020[, -c((ncol(data_2020) - 1):ncol(data_2020))]
# 
# data_2021 <- data_2021 |> 
#   rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
#          of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
# data_2021 <- data_2021[, -c((ncol(data_2021) - 1):ncol(data_2021))]
# 
# data_2022 <- data_2022 |> 
#   rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
#          of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
# data_2022 <- data_2022[, -c((ncol(data_2022) - 1):ncol(data_2022))]
# movie_data <- rbind(data_2007, data_2008, data_2009, 
#                     data_2010, data_2011, data_2012, 
#                     data_2013, data_2014, data_2015, 
#                     data_2016, data_2017, data_2018, 
#                     data_2019, data_2020, data_2021, 
#                     data_2022)
