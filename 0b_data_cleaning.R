library(tidyverse)
library(janitor)

data_2011 <- data_2011[, -ncol(data_2011)]

data_2012 <- data_2012[, -ncol(data_2012)]

data_2013 <- data_2013[, -ncol(data_2013)]

data_2014 <- data_2014[, -ncol(data_2014)]

data_2015 <- data_2015[, -ncol(data_2015)]

data_2016 <- data_2016[, -ncol(data_2016)]

data_2017 <- data_2017[, -ncol(data_2017)]

data_2018 <- data_2018[, -ncol(data_2018)]

data_2019 <- data_2019 |> 
  rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
         of.Gross.earned.abroad = X..of.Gross.earned.abroad)
data_2019 <- data_2019[, -c((ncol(data_2019) - 1):ncol(data_2019))]

data_2020 <- data_2020 |> 
  rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
         of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
data_2020 <- data_2020[, -c((ncol(data_2020) - 1):ncol(data_2020))]

data_2021 <- data_2021 |> 
  rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
         of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
data_2021 <- data_2021[, -c((ncol(data_2021) - 1):ncol(data_2021))]

data_2022 <- data_2022 |> 
  rename(Genre = Genres, Opening.Weekend = Opening.Weekend...., 
         of.Gross.earned.abroad = X..of.Gross.earned.abroad) 
data_2022 <- data_2022[, -c((ncol(data_2022) - 1):ncol(data_2022))]

movie_data <- rbind(data_2007, data_2008, data_2009, 
                    data_2010, data_2011, data_2012, 
                    data_2013, data_2014, data_2015, 
                    data_2016, data_2017, data_2018, 
                    data_2019, data_2020, data_2021, 
                    data_2022)

write.csv(movie_data, "movie_data.csv", row.names = FALSE)