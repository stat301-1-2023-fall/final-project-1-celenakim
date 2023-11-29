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
