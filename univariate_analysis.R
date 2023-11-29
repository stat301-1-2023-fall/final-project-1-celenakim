library(tidyverse)
library(readr)
movie_data <- read_csv("data/movie_data.csv")
View(movie_data)


## Exploration 1: What is the distribution of script type?
script_type_dist <- movie_data |> 
  group_by(script_type) |> 
  filter(!is.na(script_type))

ggplot(script_type_dist, aes(x = script_type)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Script Type",
       y = "Count",
       title = "Distribution of Movie Script Type")

## Exploration 2: What is the distribution of average critic ratings?
movie_data |> 
ggplot(aes(x = average_critics)) +
  geom_histogram(binwidth = 4) +
  labs(x = "Average Rotten Tomatoes and Metacritic Critic Rating",
       y = "Count",
       title = "Distribution of Average Rotten Tomatoes and Metacritic Critic Rating")




