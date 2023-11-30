library(tidyverse)
library(knitr)

## ADDITIONAL EXPLORATIONS

# Distribution of Primary Genre for Each Script Type
movie_data |> 
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
