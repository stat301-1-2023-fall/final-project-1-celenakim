library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

## Investigating how seasons interact with each variable

# By var1: ratings
# Which season has the highest average critic and audience ratings

seasonal_critics_table <- movie_data |> 
  group_by(season) |> 
  summarise(avg_critic_rating = round(mean(average_critics, na.rm = TRUE))) |> 
  arrange(desc(avg_critic_rating)) |> 
  DT::datatable()

seasonal_critics_plot <- movie_data |> 
  group_by(season)  |> 
  summarise(avg_critic_rating = round(mean(average_critics, na.rm = TRUE)))  |> 
  arrange(desc(avg_critic_rating))  |> 
  ggplot(aes(x = season, y = avg_critic_rating, fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Critic Ratings by Season",
       x = "Season",
       y = "Average Critic Rating",
       fill = "Season") +
  theme_minimal() +
  ylim(0, 70)

seasonal_audience_table <-  movie_data |>  
  group_by(season) |> 
  summarise(avg_audience_rating = mean(average_audience, na.rm = TRUE)) |> 
  arrange(desc(avg_audience_rating))

seasonal_audience_plot <-  movie_data |>  
  group_by(season) |> 
  summarise(avg_audience_rating = mean(average_audience, na.rm = TRUE)) |> 
  arrange(desc(avg_audience_rating)) |> 
  ggplot(aes(x = season, y = avg_audience_rating, fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Audience Ratings by Season",
       x = "Season",
       y = "Average Audience Rating",
       fill = "Season") +
  theme_minimal() +
  ylim(0, 70)

seasonal_critics_plot + seasonal_audience_plot




# By var2: opening weekend revenue
# Which season has the highest mean opening weekend revenue
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_opening_rev = mean(opening_weekend_million, na.rm = TRUE)) |> 
  arrange(desc(avg_opening_rev))
  # Highest mean opening weekend revenue for movies released in the Spring

# By var3: gross
# Which season has the highest domestic gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_dom_gross = mean(domestic_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_dom_gross))
  # Highest domestic gross for movies released in the Summer

# Which season has the highest foreign gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_foreign_gross = mean(foreign_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_foreign_gross))
  # Highest foreign gross for movies released in the Summer

# Which season has the highest worldwide gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_worldwide_gross))
  # Highest worldwide gross for movies released in the Summer

# By var4: budget recovery
# Which season has movies with the highest budgets
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_budgets = mean(budget_million, na.rm = TRUE)) |> 
  arrange(desc(avg_budgets))
  # Highest budgets for movies released in the Spring

# Which season has the highest budget recovery percentage
movie_data_with_season |> 
  group_by(season) |> 
  summarise(avg_budget_recovery = mean(budget_recovered, na.rm = TRUE)) |> 
  arrange(desc(avg_budget_recovery))
  # Highest budget recovery for movies released in the fall

# By var5: oscar wins
# Which season has the movies with the most Oscar wins
movie_data_with_season |> 
  group_by(season) |> 
  filter(!is.na(oscar_winners)) |> 
  summarise(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count))
  # Movies released in the fall


# Season with the most overall success: fall







