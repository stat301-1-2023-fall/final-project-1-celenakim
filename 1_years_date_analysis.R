# How do variables change over the years? 

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


## Exploration 5: How do the overall movie budgets change over the years from 2007-2022?
yearly_movie_budget <- movie_data |> 
  group_by(year) |> 
  summarize(mean_movie_budget = round(mean(budget_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_movie_budget)) 

yearly_movie_budget |> 
  DT::datatable()

ggplot(yearly_movie_budget, aes(x = year, y = mean_movie_budget)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Moviet Budget (millions)", 
       title = "Average Budgets in Millions for Hollywood Movies from 2007-2022") 


## Exploration 6: What is the most prevalent genre for each year?



## Exploration 7: How does the foreign gross change over the years from 2007-2022?
yearly_foreign_gross <- movie_data |> 
  group_by(year) |> 
  summarize(mean_foreign_gross = round(mean(foreign_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_foreign_gross)) 
yearly_foreign_gross

ggplot(yearly_foreign_gross, aes(x = year, y = mean_foreign_gross)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Foreign Gross (millions)", 
       title = "Average Foreign Gross in Millions for Hollywood Movies from 2007-2022",
       subtitle = "There is no foreign gross data available for the year 2021.")

# there are no values of foreign gross for the year 2021. 
# least foreign gross in 2020, the year of COVID when movie theaters were shut down. 
# greatest foreign gross 

## Exploration 8: How does the domestic gross change over the years from 2007-2022?
yearly_domestic_gross <- movie_data |> 
  group_by(year) |> 
  summarize(mean_domestic_gross = round(mean(domestic_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_domestic_gross)) 
yearly_domestic_gross

ggplot(yearly_domestic_gross, aes(x = year, y = mean_domestic_gross)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Domestic Gross (millions)", 
       title = "Average Domestic Gross in Millions for Hollywood Movies from 2007-2022")


## Exploration 9: How does the worldwide gross change over the years from 2007-2022?
yearly_worldwide_gross <- movie_data |> 
  group_by(year) |> 
  summarize(mean_worldwide_gross = round(mean(worldwide_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_worldwide_gross)) 
yearly_worldwide_gross

ggplot(yearly_worldwide_gross, aes(x = year, y = mean_worldwide_gross)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Worldwide Gross (millions)", 
       title = "Average Worldwide Gross in Millions for Hollywood Movies from 2007-2022", 
       subtitle = "There is no worldwide gross data available for the year 2021.")

