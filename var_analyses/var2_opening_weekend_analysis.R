# Opening weekend revenue: Opening weekend revenue
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic

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
  labs(x = "Year", 
       y = "Mean Opening Weekend Earnings (in millions)", 
       title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022") +
  ylim(0, 28)

### Exploration 2: Which genre has the highest mean opening weekend earning? 
genre_opening_success <- movie_data |> 
  group_by(genre) |> 
  summarize(mean_opening_success = mean(opening_weekend)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_opening_success

### Exploration 3: Which script type has the highest mean opening weekend earning? 
scripttype_opening_success <- movie_data |> 
  group_by(script_type) |> 
  summarize(mean_opening_success = round(mean(opening_weekend))) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
scripttype_opening_success 



## Exploration 4: How do the different critic ratings correlate with opening weekend success?
rt_critic_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Critics Rating",
       x = "Rotten Tomatoes Critics Rating",
       y = "Opening Weekend Earnings (millions)")
rt_critic_success_cor

rt_audience_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Rotten Tomatoes Audience Rating",
       x = "Rotten Tomatoes Audience Rating",
       y = "Opening Weekend Earnings (millions)")
rt_audience_success_cor

mc_critic_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Critics Rating",
       x = "Metacritic Critics Rating",
       y = "Opening Weekend Earnings (millions)")
mc_critic_success_cor

mc_audience_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Audience Rating",
       x = "Metacritic Audience Rating",
       y = "Opening Weekend Earnings (millions)")
mc_audience_success_cor




### Exploration 5: What is the correlation between a movie's budget and opening weekend success?
movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions of $)",
       y = "Opening Weekend Earnings (millions of $)",
       title = "Opening Weekend Earnings by Movie Budget",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")


### Exploration 6: What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")

