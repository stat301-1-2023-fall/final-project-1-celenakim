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
  summarize(st_oscar_count = sum(oscar_winners, na.rm = TRUE)) |> 
  arrange(desc(st_oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
scripttype_oscar_counts


## What variables affect a movie's opening weekend earnings or Oscar win count?
### Exploration 5: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()
rt_rating_oscar

## Exploration 6: How do the different critic ratings correlate with opening weekend success?

rt_critic_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Critics Rating",
       x = "Rotten Tomatoes Critics Rating",
       y = "Opening Weekend Earnings (millions)")

rt_audience_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Audience Rating",
       x = "Rotten Tomatoes Audience Rating",
       y = "Opening Weekend Earnings (millions)")

mc_critic_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Critics Rating",
       x = "Metacritic Critics Rating",
       y = "Opening Weekend Earnings (millions)")

mc_audience_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Audience Rating",
       x = "Metacritic Audience Rating",
       y = "Opening Weekend Earnings (millions)")


### Exploration 7: Which distributor has the highest IMDb rating?
imdb_rating_by_dist <- movie_data |> 
  group_by(distributor) |> 
  summarize(mean_distr_imdb = mean(im_db_rating, na.rm = TRUE)) |> 
  arrange(desc(mean_distr_imdb)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
imdb_rating_by_dist

### Exploration 8: What is the correlation between a movie's budget and opening weekend success?
movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions)",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings by Movie Budget (millions)",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")
  
### Exploration 9: What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")


  
  





