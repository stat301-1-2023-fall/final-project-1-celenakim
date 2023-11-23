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



## Exploration 1: What is the most popular/successful genre?
genre_opening_success <- movie_data |> 
  group_by(genre) |> 
  summarize(mean_opening_success = mean(opening_weekend)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
genre_opening_success
# ![]("figures"/"genre_opening_success_mean.png")





genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_oscar_counts