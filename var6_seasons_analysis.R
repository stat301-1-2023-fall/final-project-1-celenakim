library(tidyverse)
library(knitr)

## Investigating how seasons interact with each variable
movie_data_with_season <- movie_data |> 
  mutate(season = case_when(
    month(release_date_us) %in% c(3, 4, 5) ~ "Spring",
    month(release_date_us) %in% c(6, 7, 8) ~ "Summer",
    month(release_date_us) %in% c(9, 10, 11) ~ "Fall",
    TRUE ~ "Winter"
  ))

movie_data_with_season |> 
  group_by(season) |> 
  summarize(count = n()) |> 
  arrange(desc(count))


# By var1: ratings
# Which season has the highest average critic and audience ratings
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_critic_rating = mean(average_critics, na.rm = TRUE)) |> 
  arrange(desc(seasonal_critic_rating))

movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_audience_rating = mean(average_audience, na.rm = TRUE)) |> 
  arrange(desc(seasonal_audience_rating))
  # Same pattern for both rating groups: highest ratings for movies released in the Fall


# By var2: opening weekend revenue
# Which season has the highest mean opening weekend revenue
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_opening_rev = mean(opening_weekend_million, na.rm = TRUE)) |> 
  arrange(desc(seasonal_opening_rev))
  # Highest mean opening weekend revenue for movies released in the Spring

# By var3: gross
# Which season has the highest domestic gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_dom_gross = mean(domestic_gross_million, na.rm = TRUE)) |> 
  arrange(desc(seasonal_dom_gross))
  # Highest domestic gross for movies released in the Summer

# Which season has the highest foreign gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_foreign_gross = mean(foreign_gross_million, na.rm = TRUE)) |> 
  arrange(desc(seasonal_foreign_gross))
  # Highest foreign gross for movies released in the Summer

# Which season has the highest worldwide gross
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(seasonal_worldwide_gross))
  # Highest worldwide gross for movies released in the Summer

# By var4: budget recovery
# Which season has movies with the highest budgets
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_budgets = mean(budget_million, na.rm = TRUE)) |> 
  arrange(desc(seasonal_budgets))
  # Highest budgets for movies released in the Spring

# Which season has the highest budget recovery percentage
movie_data_with_season |> 
  group_by(season) |> 
  summarise(seasonal_budget_recovery = mean(budget_recovered, na.rm = TRUE)) |> 
  arrange(desc(seasonal_budget_recovery))
  # Highest budget recovery for movies released in the fall

# By var5: oscar wins
# Which season has the movies with the most Oscar wins
movie_data_with_season |> 
  group_by(season) |> 
  filter(!is.na(oscar_winners)) |> 
  summarise(seasonal_oscar_count = sum(oscar_winners)) |> 
  arrange(desc(seasonal_oscar_count))
  # Movies released in the fall


# Season with the most overall success: fall







