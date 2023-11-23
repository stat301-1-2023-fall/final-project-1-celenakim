library(tidyverse)
library(janitor)


## JOINING DATA SETS
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

## CLEANING DATA
# Changing variable names to snake case
movie_data <- clean_names(movie_data)

# Deleting unnecessary variables
drop = c("link", "none")
movie_data = movie_data[,!(names(movie_data) %in% drop)]

# Changing character variables to integers when needed
char_vector <- c("rotten_tomatoes_critics", "metacritic_critics", 
                 "average_critics", "metacritic_audience",
                 "rotten_tomatoes_vs_metacritic_deviance", 
                 "average_audience", "audience_vs_critics_deviance", 
                 "opening_weekend", "opening_weekend_million", 
                 "domestic_gross", "domestic_gross_million", 
                 "foreign_gross_million", "foreign_gross", 
                 "worldwide_gross", "worldwide_gross_million", 
                 "budget_million")

# Convert the character vector to integer
movie_data <- movie_data %>%
  mutate_at(char_vector, ~as.integer(.))

# Replace NA values in 'genre' with values from 'primary_genre'
movie_data <- movie_data %>%
  mutate(genre = ifelse(is.na(genre) | 
                          genre == "-",
                        primary_genre, 
                        genre))

# Changing "oscar_winners" variable to boolean
movie_data <- movie_data %>%
  mutate(oscar_winners = ifelse(oscar_winners == "", 
                                FALSE, 
                                TRUE))

write.csv(movie_data, "data/movie_data.csv", row.names = FALSE)






## Initial code without for loops
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

