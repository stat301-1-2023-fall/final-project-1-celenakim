library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Oscars: Oscar wins

# Which genre has the highest Oscar wins? Which script type has the highest Oscar wins?
# relationship between worldwide gross and the number of Oscar wins.
# relationship between critic ratings and the number of Oscar wins.
# relationship between opening weekend rev and the number of Oscar wins.
# relationship between budget and the number of Oscar wins.
# Oscar detail analysis– which oscar award category has the highest budget? Highest worldwide gross? Highest opening weekend rev? Highest ratings?
  



### Exploration 1: Which genre has the highest Oscar wins?
### Exploration 2: Which script type has the highest Oscar wins?
genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 5)|> 
  DT::datatable()


scripttype_oscar_counts <- movie_data |> 
  filter(script_type != "") |> 
  group_by(script_type) |> 
  summarize(st_oscar_count = sum(oscar_winners, na.rm = TRUE)) |> 
  arrange(desc(st_oscar_count)) |> 
  slice_head(n = 4)|> 
  DT::datatable()



genre_oscar_counts <- movie_data |> 
  filter(genre != "Action, Adventure, Mystery, Thriller, Fantasy, Comedy, Romance, Animation, Family, Musical") |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 5)

genre_oscar_wins <- genre_oscar_counts |> 
  ggplot(aes(x = fct_reorder(genre, -oscar_count), 
             y = oscar_count, 
             fill = genre)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 5 Movies with the Most Oscar Wins by Genre",
       subtitle = "The 'biography & history' genre combination has the most Oscars.",
       x = "Genre",
       y = "Number of Oscar Wins") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")


script_type_oscar_counts <- movie_data |> 
  filter(script_type != "") |> 
  group_by(script_type) |> 
  summarize(st_oscar_count = sum(oscar_winners, 
                                 na.rm = TRUE)) |> 
  arrange(desc(st_oscar_count)) |> 
  slice_head(n = 5)

script_type_oscar_wins <- script_type_oscar_counts |> 
  ggplot(aes(x = fct_reorder(script_type, -st_oscar_count), 
             y = st_oscar_count, 
             fill = script_type)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 5 Movies with the Most Oscar Wins by Script Type",
       subtitle = "The 'original screenplay' script type has the most Oscars.",
       x = "Script Type",
       y = "Number of Oscar Wins") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none") +
  scale_y_continuous(breaks = seq(0, 
                                  max(script_type_oscar_counts$st_oscar_count), 
                                  by = 5)) +
  scale_fill_viridis_d() 

genre_oscar_wins + script_type_oscar_wins


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



## worldwide gross and oscar wins
oscar_win_ww_gross <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = worldwide_gross_million, 
             y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Worldwide Gross by Oscar Wins",
       subtitle = "Oscar winning movies have a higher average worldwide gross.",
       x = "Worldwide Gross (millions of $)",
       y = "Oscar Winner") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")


movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = domestic_gross_million, y = oscar_winners)) +
  geom_boxplot() 

movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = foreign_gross_million, y = oscar_winners)) +
  geom_boxplot() 



### Exploration 3: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()
rt_rating_oscar




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

