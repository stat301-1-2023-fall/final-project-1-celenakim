# Ratings: Rotten Tomatoes, Metacritic, and IMDb ratings, both critic and audience

## Exploration 1: What is the distribution of average critic ratings?
movie_data |> 
  ggplot(aes(x = average_critics)) +
  geom_histogram(binwidth = 4) +
  labs(x = "Average Rotten Tomatoes and Metacritic Critic Rating",
       y = "Count",
       title = "Distribution of Average Rotten Tomatoes and Metacritic Critic Rating")


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
  labs(x = "Year", 
       y = "Rotten Tomatoes Critic Ratings", 
       title = "Average Rotten Tomatoes Critic Ratings for Hollywood Movies from 2007-2022") 


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
  labs(x = "Year", 
       y = "Metacritic Critic Ratings", 
       title = "Average Metacritic Critic Ratings for Hollywood Movies from 2007-2022") 


### Exploration 5: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()
rt_rating_oscar

### Exploration 7: Which distributor has the highest IMDb rating?
imdb_rating_by_dist <- movie_data |> 
  group_by(distributor) |> 
  summarize(mean_distr_imdb = mean(im_db_rating, na.rm = TRUE)) |> 
  arrange(desc(mean_distr_imdb)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
imdb_rating_by_dist


### Exploration 9: What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")





