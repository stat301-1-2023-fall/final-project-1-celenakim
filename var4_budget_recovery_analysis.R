# Budget recovery: Budget recovered, and during opening weekend alone
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic

## Exploration 1: How do the overall movie budgets change over the years from 2007-2022?
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


### Exploration 2: What is the correlation between a movie's budget and opening weekend success?
movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions)",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings by Movie Budget (millions)",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")

