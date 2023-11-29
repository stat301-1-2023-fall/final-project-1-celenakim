# Gross: Domestic, foreign, and worldwide gross


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

