library(tidyverse)
library(knitr)


# UNIVARIATE
## Exploration 1: How does the overall average opening weekend earning change over the years from 2007-2022?
year_opening_success |> 
  DT::datatable()
# ![](figures/avg_opening_wknd_earnings_yearly_table.png)
ggplot(year_opening_success, aes(x = year, y = mean_opening_success)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Mean Opening Weekend Earnings (in millions)", title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022") +
  ylim(0, 28)
# ![](figures/avg_opening_wknd_earnings_yearly.png)
# These visualizations represent the change in the mean opening weekend earnings (in millions) for Hollywood movies from 2007-2008. As can be seen by the graph, the years with the most successful opening weekends in terms of mean earnings are the years 2012 and 2014, closely tied with an average earning of 27 million dollars. The lowest point on the graph corresponds to 2020, with that year earning the least during opening weekend: 8 million dollars. This data definitely reflects the times/economy of the country during this year, as 2020 was the year that America was under quarantine and movie theaters were shut down.

## Exploration 2: How do the overall average rotten tomato critic ratings change over the years from 2007-2022?
ggplot(yearly_rt_critic_rating, aes(x = year, y = mean_rt_rating)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Rotten Tomatoes Critic Ratings", title = "Average Rotten Tomatoes Critic Ratings for Hollywood Movies from 2007-2022") 
# ![](figures/yearly_rt_critic_rating_plot.png)
# This graph represents the change in the average Rotten Tomatoes critic ratings for Hollywood movies for each year from 2007-2022. Overall, it seems that the average critic ratings have increased significantly over the years, with about a 30% increase in ratings from 2007 to 2022.


# BIVARIATE
### Exploration 1: Which genre has the highest mean opening weekend earning? 
genre_opening_success
# ![](figures/genre_opening_success_mean.png)
# As shown in the table, the "sci-fi & fantasy" genre combination had the most success in terms of highest opening weekend earnings, with about 248 million dollars in earnings.

### Exploration 2: Which genre has the highest Oscar wins?
genre_oscar_counts
# ![](figures/genre_oscar_counts_table.png)
In terms of Oscar win success, the "biography & history" genre was the most successful as this genre combination earned the most amount of Oscars.

### Exploration 3: Which script type has the highest mean opening weekend earning? 


### Exploration 4: Which script type has the highest Oscar wins?




genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_oscar_counts