library(tidyverse)

# UNIVARIATE: What variables change over the years? 

## Exploration 1: How do the overall average opening weekend earnings change over the years from 2007-2022?
year_opening_success <- movie_data |> 
  group_by(year) |> 
  summarize(mean_opening_success = round(mean(opening_weekend_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_opening_success)) 

year_opening_success |> 
  DT::datatable()

ggplot(year_opening_success, aes(x = year, y = mean_opening_success)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Mean Opening Weekend Earnings (in millions)", title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022") +
  ylim(0, 28)


## Exploration 2: How do the overall average rotten tomato critic ratings change over the years from 2007-2022?
yearly_rt_critic_rating <- movie_data |> 
  group_by(year) |> 
  summarize(mean_rt_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE)))  |> 
  arrange(desc(mean_rt_rating)) 

yearly_rt_critic_rating |> 
  DT::datatable()

ggplot(yearly_rt_critic_rating, aes(x = year, y = mean_rt_rating)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Rotten Tomatoes Critic Ratings", title = "Average Rotten Tomatoes Critic Ratings for Hollywood Movies from 2007-2022") 


## Exploration 3: How do the overall average metacritic critic ratings change over the years from 2007-2022?
yearly_mc_critic_rating <- movie_data |> 
  group_by(year) |> 
  summarize(mean_mc_rating = round(mean(metacritic_critics, na.rm = TRUE)))  |> 
  arrange(desc(mean_mc_rating)) 

yearly_mc_critic_rating |> 
  DT::datatable()

ggplot(yearly_mc_critic_rating, aes(x = year, y = mean_mc_rating)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Metacritic Critic Ratings", title = "Average Metacritic Critic Ratings for Hollywood Movies from 2007-2022") 


## Exploration 4: How do 





