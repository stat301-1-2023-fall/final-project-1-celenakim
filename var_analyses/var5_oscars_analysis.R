library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim

# Oscars: Oscar wins

# Which genre has the highest Oscar wins? Which script type has the highest Oscar wins?
# relationship between worldwide gross and the number of Oscar wins.
# relationship between critic ratings and the number of Oscar wins.
# relationship between opening weekend rev and the number of Oscar wins.
# relationship between budget and the number of Oscar wins.
# Oscar detail analysis– which oscar award category has the highest budget? Highest worldwide gross? Highest opening weekend rev? Highest ratings?
  

## Exploration 1: Movie with the most Oscar wins?
oscar_movie_titles <- movie_data |> 
  select(film, oscar_count, oscar_detail) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 10) |> 
  DT::datatable()

### Exploration 2: Which genre has the highest Oscar wins? Which script type has the highest Oscar wins?
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


## Exploration 3: worldwide gross and oscar wins
oscar_win_ww_gross <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = worldwide_gross_million, 
             y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Distribution of Worldwide Gross for Oscar-winning Movies and Movies with 
0 Oscar Wins",
       subtitle = "Oscar-winning movies have a higher average worldwide gross.",
       x = "Worldwide Gross (millions of $)",
       y = "Oscar Winner") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")

oscar_win_dom_gross <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = domestic_gross_million, y = oscar_winners)) +
  geom_boxplot() 

oscar_win_for_gross <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = foreign_gross_million, y = oscar_winners)) +
  geom_boxplot() 



## Exploration 4: Which Oscar award has the highest critic ratings? Audience ratings?
oscar_avg_critic_aud <- movie_data |> 
  filter(!is.na(oscar_detail)) |> 
  group_by(oscar_detail) |> 
  summarize(mean_critic_rating = mean(average_critics, na.rm = TRUE),
            mean_aud_rating = mean(average_audience, na.rm = TRUE)) |> 
  arrange(desc(mean_critic_rating)) |> 
  slice_head(n = 10) |> 
  DT::datatable()


## Exploration 5: Opening weekend revenue and number of Oscar wins
oscar_count_opening_wknd <- movie_data |> 
  filter(!is.na(oscar_count)) |> 
  group_by(oscar_count) |> 
  summarize(avg_opening_wknd = mean(opening_weekend_million, 
                                    na.rm = TRUE)) |> 
  ggplot(aes(x = factor(oscar_count),
             y = avg_opening_wknd,
             fill = oscar_count)) +
  geom_bar(stat = "identity") +
  labs(x = "Number of Oscar Awards",
       y = "Average Opening Weekend Revenue (millions of $)",
       title = "Distribution of Average Opening Weekend Earnings by Oscar Award Count",
       subtitle = "Movies with 6 Oscars have the highest average opening weekend revenue.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")



## Exploration 6: Gross and number of Oscar wins
oscar_count_dom_gross <- movie_data |> 
  filter(!is.na(oscar_count)) |> 
  group_by(oscar_count) |> 
  summarize(avg_dom_gross = mean(domestic_gross_million, 
                                    na.rm = TRUE)) |> 
  ggplot(aes(x = factor(oscar_count),
             y = avg_dom_gross,
             fill = oscar_count)) +
  geom_bar(stat = "identity") +
  labs(x = "Number of Oscar Awards",
       y = "Average Domestic Gross Revenue (millions of $)",
       title = "Distribution of Average Domestic Gross Earnings 
by Oscar Award Count",
       subtitle = "Movies with 1 Oscar have the highest average domestic gross revenue.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.position = "none") +
  ylim(0, 250)


oscar_count_for_gross <- movie_data |> 
  filter(!is.na(oscar_count)) |> 
  group_by(oscar_count) |> 
  summarize(avg_for_gross = mean(foreign_gross_million, 
                                 na.rm = TRUE)) |> 
  ggplot(aes(x = factor(oscar_count),
             y = avg_for_gross,
             fill = oscar_count)) +
  geom_bar(stat = "identity") +
  labs(x = "Number of Oscar Awards",
       y = "Average Foreign Gross Revenue (millions of $)",
       title = "Distribution of Average Foreign Gross Earnings 
by Oscar Award Count",
       subtitle = "Movies with 1 Oscar have the highest average foreign gross revenue.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.position = "none") +
  ylim (0, 250)

oscar_count_dom_gross + oscar_count_for_gross




## EXTRA EXPLORATIONS:

# which distributor has the highest oscar wins
movie_data |> 
  filter(!is.na(oscar_winners) & !is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(oscar_count = sum(oscar_winners, na.rm = TRUE)) |> 
  arrange(desc(oscar_count))

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
  arrange(desc(count))

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
  

# yearly oscars
movie_data |> 
  group_by(year) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  ggplot(aes(x = year, y = oscar_count)) +
  geom_line() +
  geom_point() +
  ylim(0, 8) +
  scale_x_continuous(breaks = seq(min(movie_data$year), max(movie_data$year), by = 2))

