library(tidyverse)
library(janitor)
library(readr)

# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim

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

# Changing character variables to integers when needed, changing date variable to date type
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
movie_data <- movie_data |> 
  mutate_at(char_vector, ~as.integer(.)) 

# Convert the 'release_date_us' variable to date type
movie_data$release_date_us <- as.Date(strptime(movie_data$release_date_us, "%B %d, %Y"))

# Drop % and convert 'budget_recovered' variables to numeric
movie_data$budget_recovered <- as.numeric(sub("%", "", movie_data$budget_recovered))
movie_data$budget_recovered_opening_weekend <- as.numeric(sub("%", "", movie_data$budget_recovered_opening_weekend))

# Drop % and convert 'of_gross_earned_abroad' variable to numeric
movie_data$of_gross_earned_abroad <- as.numeric(sub("%", "", movie_data$of_gross_earned_abroad))

# Replace NA values in 'genre' with values from 'primary_genre'
movie_data <- movie_data |> 
  mutate(genre = ifelse(is.na(genre) | 
                          genre == "-",
                        primary_genre, 
                        genre))

# Changing "oscar_winners" variable to boolean
movie_data <- movie_data |> 
  mutate(oscar_winners = ifelse(oscar_winners == "", 
                                FALSE, 
                                TRUE))

# Fixing missing values for worldwide gross columns
movie_data <- movie_data |> 
  mutate(worldwide_gross = domestic_gross + foreign_gross)

# Fixing incorrectly "millions" conversions
movie_data$opening_weekend_million <- round(movie_data$opening_weekend / 1000000)
movie_data$domestic_gross_million <- round(movie_data$domestic_gross / 1000000)
movie_data$foreign_gross_million <- round(movie_data$foreign_gross / 1000000)
movie_data$worldwide_gross_million <- round(movie_data$worldwide_gross / 1000000)

# Adding the "season" variable
movie_data <- movie_data |> 
  mutate(season = case_when(
    month(release_date_us) %in% c(3, 4, 5) ~ "Spring",
    month(release_date_us) %in% c(6, 7, 8) ~ "Summer",
    month(release_date_us) %in% c(9, 10, 11) ~ "Fall",
    TRUE ~ "Winter"
  ))

# Adding the "oscar_count" variable
movie_data <- movie_data |> 
  mutate(oscar_count = ifelse(oscar_winners == TRUE,
                              str_count(oscar_detail, ",") + 1, 
                              0),
         .after = oscar_winners)

write_csv(movie_data, "data/movie_data.csv")