library(tidyverse)
library(knitr)

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