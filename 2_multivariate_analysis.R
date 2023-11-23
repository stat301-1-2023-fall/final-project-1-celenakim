library(tidyverse)

# BIVARIATE: 

## What variables affect a movie's opening weekend earnings or Oscar win count?
### Exploration 1: Which genre has the highest mean opening weekend earning? 
genre_opening_success <- movie_data |> 
  group_by(genre) |> 
  summarize(mean_opening_success = mean(opening_weekend)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_opening_success

### Exploration 2: Which genre has the highest Oscar wins?
genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_oscar_counts

### Exploration 3: Which script type has the highest mean opening weekend earning? 
scripttype_opening_success <- movie_data |> 
  group_by(script_type) |> 
  summarize(mean_opening_success = round(mean(opening_weekend))) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
scripttype_opening_success

### Exploration 4: Which script type has the highest Oscar wins?
scripttype_oscar_counts <- movie_data |> 
  group_by(script_type) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
scripttype_oscar_counts


## What variables affect a movie's opening weekend earnings or Oscar win count?
### Exploration 4: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()

rt_rating_oscar

The table shows that movies that have won an Oscar have a much higher average Rotten Tomatoes critic rating than those who have not won an Oscar (89 vs. 54).

## Exploration 5: How do the different critic ratings correlate with opening weekend success?

movie_data |> 
  ggplot(aes(x = rotten_tomatoes_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Critics Rating",
       x = "Rotten Tomatoes Critics Rating",
       y = "Opening Weekend Earnings (millions)")

movie_data |> 
  ggplot(aes(x = rotten_tomatoes_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Audience Rating",
       x = "Rotten Tomatoes Audience Rating",
       y = "Opening Weekend Earnings (millions)")

movie_data |> 
  ggplot(aes(x = metacritic_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Critics Rating",
       x = "Metacritic Critics Rating",
       y = "Opening Weekend Earnings (millions)")

movie_data |> 
  ggplot(aes(x = metacritic_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Audience Rating",
       x = "Metacritic Audience Rating",
       y = "Opening Weekend Earnings (millions)")

Comparing the line of best fits between the four graphs, the "Rotten Tomatoes Audience Rating" has the highest positive correlation with "Opening Weekened Earnings (millions)"; the relationship is strongest between these two variables.













The script type combination that is the most successful during opening weekend is "sequel & adaptation". The script type that earned the most Oscars is "original screenplay".
