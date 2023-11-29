# Budget recovery: Budget recovered, and during opening weekend alone

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
