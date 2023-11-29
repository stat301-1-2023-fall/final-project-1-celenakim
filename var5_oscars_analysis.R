# Oscars: Oscar wins

### Exploration 1: Which genre has the highest Oscar wins?
genre_oscar_counts <- movie_data |> 
  group_by(genre) |> 
  summarize(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
genre_oscar_counts

### Exploration 4: Which script type has the highest Oscar wins?
scripttype_oscar_counts <- movie_data |> 
  group_by(script_type) |> 
  summarize(st_oscar_count = sum(oscar_winners, na.rm = TRUE)) |> 
  arrange(desc(st_oscar_count)) |> 
  slice_head(n = 3)|> 
  DT::datatable()
scripttype_oscar_counts


### Exploration 5: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
rt_rating_oscar <- movie_data |> 
  group_by(oscar_winners) |> 
  summarize(mean_rt_critic_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE))) |> 
  DT::datatable()
rt_rating_oscar