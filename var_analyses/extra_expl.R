library(tidyverse)
library(knitr)

## ADDITIONAL EXPLORATIONS

# Distribution of Primary Genre for Each Script Type
primary_genre_script_type_plot <- movie_data |> 
  filter(!is.na(primary_genre) & !is.na(script_type)) |> 
  ggplot(aes(x = script_type, fill = primary_genre)) +
  geom_bar(position = "fill") +
  labs(title = "Distribution of Primary Genre for Each Script Type",
       subtitle = "Remakes are solely made up of Western movies",
       x = "Script Type",
       y = "Proportion",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")

# Number of movies released in each season, seasonal_movie_count_table.png
movie_data_with_season |> 
  group_by(season) |> 
  summarize(count = n()) |> 
  arrange(desc(count)) |> 
  DT::datatable()




