library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

movie_data <- read_csv("data/movie_data.csv")

# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim


## ADDITIONAL EXPLORATIONS

# Exploration 1: Distribution of Primary Genre for Each Script Type
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

# Exploration 2: Genre popularity of movies over the years
genre_trends <- movie_data |> 
  group_by(year, primary_genre) |> 
  filter(!is.na(primary_genre) & primary_genre != "") |> 
  summarize(count = n()) |> 
  ggplot(aes(x = year, y = count, color = primary_genre)) +
  geom_line() +
  labs(title = "Genre Trends Over Years",
       subtitle = "The 'action' genre has become the most prevalent.",
       x = "Year",
       y = "Number of Movies",
       color = "Primary Genre") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 30)


# Exploration 3: Movie with highest:
# a. average critic rating 
highest_critic_rating <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre, 
         average_critics) |> 
  arrange(desc(average_critics)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# b. average audience rting
highest_audience_rating <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre, 
         average_audience) |> 
  arrange(desc(average_audience)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# c. opening weekend 
highest_opening_wknd <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre, 
         opening_weekend_million) |> 
  arrange(desc(opening_weekend_million)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# d. domestic gross 
highest_dom_gross <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         domestic_gross_million) |> 
  arrange(desc(domestic_gross_million)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# e. foreign gross 
highest_for_gross <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         foreign_gross_million) |> 
  arrange(desc(foreign_gross_million)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# f. ww gross 
highest_ww_gross <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         worldwide_gross_million) |> 
  arrange(desc(worldwide_gross_million)) |> 
  slice_head(n = 3) |> 
  DT::datatable()


# g. % of gross earned abroad
highest_earned_abroad <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         of_gross_earned_abroad) |> 
  arrange(desc(of_gross_earned_abroad)) |> 
  slice_head(n = 3) |> 
  DT::datatable()


# h. budget 
highest_budget <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         budget_million) |> 
  arrange(desc(budget_million)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# i. budget recovered 
highest_budget_recovered <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         budget_recovered) |> 
  arrange(desc(budget_recovered)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# j. oscar wins 
highest_oscar_wins <- movie_data |> 
  select(film, 
         year, 
         script_type, 
         genre,
         oscar_count) |> 
  arrange(desc(oscar_count)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

# Exploration 4: number of films released in each year
yearly_film_count <- movie_data |> 
  group_by(year) |> 
  summarize(film_count = n())  |> 
  arrange(desc(film_count)) 

potential_outlier <- yearly_film_count |>
  filter(film_count == 66)

films_yearly <- ggplot(yearly_film_count, 
                              aes(x = year, 
                                  y = film_count)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outlier, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "COVID-19 
 Pandemic"),
 aes(x = 2018.7, 
     y = 50.9, 
     label = label),
 fill = "gray", 
 alpha = 0.2, 
 hjust = 0, 
 vjust = 0) +
  geom_point(data = potential_outlier, 
             color = "red") +
  geom_point(
    data = potential_outlier,
    color = "red", 
    size = 3, 
    shape = "circle open") +
  labs(x = "Year", 
       y = "Number of Films Released", 
       title = "Number of Hollywood Movies Released in Each Year from 2007-2022",
       subtitle = "There was a dramtic drop in film release in 2020.") +
  theme_minimal() +
  ylim(0, 160) +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  scale_x_continuous(breaks = seq(min(yearly_film_count$year), 
                                  max(yearly_film_count$year), 
                                  by = 2))