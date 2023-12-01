library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Oscars: Oscar wins

### Exploration 1: Which genre has the highest Oscar wins?
genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_oscar_counts

### Exploration 2: Which script type has the highest Oscar wins?
scripttype_oscar_counts <- movie_data |> 
  group_by(script_type) |> 
  summarize(st_oscar_count = sum(oscar_winners, na.rm = TRUE)) |> 
  arrange(desc(st_oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
scripttype_oscar_counts

# makes sense, based on script type trends over years
movie_data |> 
  filter(!is.na(script_type)) |> 
  group_by(year, script_type) |> 
  summarize(num_movies = n()) |> 
  ggplot(aes(x = year, y = num_movies, fill = script_type)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Script Type Trends Over Years",
       x = "Year",
       y = "Number of Movies",
       fill = "Script Type") +
  theme_minimal()



### Exploration 3: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()
rt_rating_oscar

# Exploration 5: Revenue and Oscar Wins: Analyze the relationship between box office revenue and the number of Oscar wins.
movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = worldwide_gross_million, y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Box Office Revenue by Oscar Wins",
       subtitle = "Oscar winning movies have a higher average worldwide gross.",
       x = "Worldwide Gross (in millions)",
       y = "Oscar Winners") +
  theme_minimal()


#Analyze the relationship between critic ratings and the number of Oscar wins.
movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = average_audience, y = oscar_winners)) +
  geom_boxplot() 

movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = average_critics, y = oscar_winners)) +
  geom_boxplot() 

#Analyze the relationship between budget and the number of Oscar wins.
movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = budget_million, y = oscar_winners)) +
  geom_boxplot() 

#Analyze the relationship between opening weekend and the number of Oscar wins.
movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = opening_weekend_million, y = oscar_winners)) +
  geom_boxplot() 

## interesting similar results, because we know that opening weekend rev and budget are highly correlated with one another



script type, won oscars
distributor, won oscras

movie_data |> 
  group_by(script_type) |> 
  ggplot(aes(x = season, 
             y = avg_budgets, 
             fill = oscar)) +
  geom_bar(stat = "identity")

movie_data |> 
  filter(!is.na(oscar_detail) & oscar_detail != "") |> 
  ggplot(aes(x = oscar_detail)) +
  geom_bar()

#oscar detail
movie_data |> 
  filter(!is.na(oscar_detail) & oscar_detail != "") |>
  group_by(oscar_detail) |> 
  summarize(count = n()) |> 
  arrange(desc(count)) |> 
  slice_head(n = 5)

library(dplyr)
library(ggplot2)

# Assuming "movie_data" is your data frame
movie_data %>%
  filter(!is.na(distributor) & !is.na(oscar_detail)) |> 
  ggplot(aes(x = distributor, fill = oscar_detail)) +
  geom_bar(position = "stack", color = "white") +
  labs(title = "Oscar Wins by Distributor and Category",
       x = "Distributor",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  +
  theme(legend.position = "none")

movie_data |> 
  group_by(oscar_detail) |> 
  summarize(mean_opening_wknd_rev = mean(opening_weekend_million)) |> 
  arrange(desc(mean_opening_wknd_rev)) |> 
  slice_head(n = 1)

movie_data |> 
  filter(!is.na(opening_weekend_million) & !is.na(oscar_detail)) |> 
  group_by(oscar_detail) |> 
  summarize(mean_opening_wknd_rev = mean(opening_weekend_million),
            mean_budget = mean(budget_million)) |> 
  arrange(desc(mean_opening_wknd_rev))
  
movie_data |> 
  group_by(oscar_detail) |> 
  summarize(mean_budget = mean(budget_million)) |> 
  arrange(desc(mean_budget)) |> 
  slice_head(n = 1)

