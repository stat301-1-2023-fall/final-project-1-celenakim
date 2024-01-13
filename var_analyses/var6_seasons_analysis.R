library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

movie_data <- read_csv("data/movie_data.csv")

# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim

## Investigating how seasons interact with each variable

## Exploration 1: By var1: ratings
# Which season has the highest average critic and audience ratings
seasonal_critics_table <- movie_data |> 
  group_by(season) |> 
  summarise(avg_critic_rating = round(mean(average_critics, 
                                           na.rm = TRUE))) |> 
  arrange(desc(avg_critic_rating)) |> 
  DT::datatable()

seasonal_critics_plot <- movie_data |> 
  group_by(season)  |> 
  summarise(avg_critic_rating = round(mean(average_critics, 
                                           na.rm = TRUE)))  |> 
  arrange(desc(avg_critic_rating))  |> 
  ggplot(aes(x = season, 
             y = avg_critic_rating, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Critic Ratings by Season Movie 
was Released In",
       subtitle = "Movies released in the Fall have the greatest 
average audience rating.",
       x = "Season",
       y = "Average Critic Rating",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")
  ylim(0, 70) 

seasonal_audience_table <-  movie_data |>  
  group_by(season) |> 
  summarise(avg_audience_rating = mean(average_audience, 
                                       na.rm = TRUE)) |> 
  arrange(desc(avg_audience_rating))

seasonal_audience_plot <-  movie_data |>  
  group_by(season) |> 
  summarise(avg_audience_rating = mean(average_audience, 
                                       na.rm = TRUE)) |> 
  arrange(desc(avg_audience_rating)) |> 
  ggplot(aes(x = season, 
             y = avg_audience_rating, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Audience Ratings by Season Movie 
was Released In",
subtitle = "Movies released in the Fall have the greatest 
average audience rating.",
       x = "Season",
       y = "Average Audience Rating",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")
  ylim(0, 70) 
  
seasonal_critics_plot + seasonal_audience_plot



## Exploration 2: By var2: opening weekend revenue
# Which season has the highest mean opening weekend revenue
seasonal_opening_wknd_plot <- movie_data |> 
  group_by(season) |> 
  summarise(avg_opening_rev = mean(opening_weekend_million, 
                                   na.rm = TRUE)) |> 
  arrange(desc(avg_opening_rev)) |> 
  ggplot(aes(x = season, 
             y = avg_opening_rev, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Opening Weekend Revenue by Season Movie was Released In",
       subtitle = "Movies released in the Spring have the greatest average opening weekend revenue.",
       x = "Season",
       y = "Average Opening Weekend Revenue (millions of $)",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")
  # Highest mean opening weekend revenue for movies released in the Spring



# Exploration 3: By var3: gross
# Which season has the highest domestic gross
movie_data |> 
  group_by(season) |> 
  summarise(avg_dom_gross = mean(domestic_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_dom_gross))
  # Highest domestic gross for movies released in the Summer

# Which season has the highest foreign gross
movie_data |> 
  group_by(season) |> 
  summarise(avg_foreign_gross = mean(foreign_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_foreign_gross))
  # Highest foreign gross for movies released in the Summer

# Which season has the highest worldwide gross
seasonal_gross_plot <- movie_data |> 
  group_by(season) |> 
  summarise(avg_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_worldwide_gross)) |> 
  ggplot(aes(x = season, 
             y = avg_worldwide_gross, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Worldwide Gross Earnings by Season Movie was Released In",
       subtitle = "Movies released in the summer have the greatest average worldwide gross.",
       x = "Season",
       y = "Worldwide Gross (millions of $)",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")
  # Highest worldwide gross for movies released in the Summer

seasonal_gross_plot <- movie_data |> 
  ggplot(aes(x = season, 
             y = worldwide_gross_million, 
             fill = season)) +
  geom_boxplot() +
  labs(title = "Distribution of Worldwide Gross Earnings by Season Movie was Released In",
       subtitle = "Movies released in the summer have the greatest average worldwide gross.",
       x = "Season",
       y = "Worldwide Gross (millions of $)",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")



# Exploration 4: By var4: budget recovery
# Which season has movies with the highest budgets
seasonal_budget_plot <- movie_data |> 
  group_by(season) |> 
  summarise(avg_budgets = mean(budget_million, na.rm = TRUE)) |> 
  arrange(desc(avg_budgets)) |> 
  ggplot(aes(x = season, 
             y = avg_budgets, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Movie Budgets by Season Movie was Released In",
       subtitle = "Movies released in the Spring have the highest average movie budgets.",
       x = "Season",
       y = "Average Movie Budget (millions of $)",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")
  
  # Highest budgets for movies released in the Spring


# Which release season has the highest budget recovery percentage
seasonal_budget_rcvry_table <- movie_data |> 
  group_by(season) |> 
  summarise(avg_budget_recovery = round(mean(budget_recovered, na.rm = TRUE))) |> 
  arrange(desc(avg_budget_recovery)) |> 
  DT::datatable()
  # Highest budget recovery for movies released in the fall

fall_budget_rcvry <- movie_data |> 
  filter(season == "Fall") |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram() +
  scale_x_continuous(labels = scales::number_format(scale = 1)) +
  labs(title = "Distribution of Budget Recovery for Movies Released in the Fall",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")

movie_data |> 
  filter(season == "Fall" & budget_recovered < 1289066.67) |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram() +
  scale_x_continuous(labels = scales::number_format(scale = 1)) +
  labs(title = "Distribution of Budget Recovery for Movies Released in the Fall",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")

movie_data |> 
  filter(season == "Spring") |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram()  +
  labs(title = "Distribution of Budget Recovery for Movies Released in the Spring",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")

movie_data |> 
  filter(season == "Summer") |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram()  +
  labs(title = "Distribution of Budget Recovery for Movies Released in the Summer",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")

movie_data |> 
  filter(season == "Winter") |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram()  +
  labs(title = "Distribution of Budget Recovery for Movies Released in the Winter",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")


seaonsal_budget_rcvry_no_outliers <- movie_data |> 
  filter(budget_recovered < 1289066.67) |> 
  ggplot(aes(x = budget_recovered)) +
  geom_histogram() +
  facet_wrap(~ season) +
  scale_x_continuous(labels = scales::number_format(scale = 1)) +
  xlim(0, 7500) +
  labs(title = "Distribution of the Percent of Movies' Budget Recovery by Each Season",
       x = "Percent of Budget Recovery (%)",
       y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")

seasonal_budget_rcvry_table_no_outliers <- movie_data |> 
  filter(budget_recovered < 1289066.67) |> 
  group_by(season) |> 
  summarise(avg_budget_recovery = round(mean(budget_recovered, na.rm = TRUE))) |> 
  arrange(desc(avg_budget_recovery)) |> 
  DT::datatable()

movie_data %>%
  group_by(season) %>%
  summarise(avg_budget_recovery = mean(budget_recovered, na.rm = TRUE)) %>%
  ggplot(aes(x = season, y = avg_budget_recovery, fill = season)) +
  geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 1.5) +
  labs(title = "Average Budget Recovery by Season",
       x = "Season",
       y = "Average Budget Recovery") +
  theme_minimal()



# Exploration 5: 
season_opening_wknd_by_budget <- movie_data |> 
  ggplot(aes(x = budget_million,
             y = opening_weekend_million,
             color = season)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(title = "Relationship Between Movie Budget and Opening Weekend 
Revenue, by Season",
       subtitle = "Movies released in the Spring have the greatest correlation between the two variables.",
       x = "Budget (millions of $)",
       y = "Opening Weekend Revenue (millions of $)",
       color = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")
  



# Exploration 6: By var5: oscar wins
# Which season has the movies with the most Oscar wins
seasonal_oscar_plot <- movie_data |> 
  group_by(season) |> 
  filter(!is.na(oscar_winners)) |> 
  summarise(oscar_count = sum(oscar_winners)) |> 
  arrange(desc(oscar_count)) |> 
  ggplot(aes(x = season, 
             y = oscar_count, 
             fill = season)) +
  geom_bar(stat = "identity") +
  labs(title = "Number of Oscar Wins by Season Movie was Released In",
       subtitle = "Movies released in the Fall have the highest number of Oscar wins.",
       x = "Season",
       y = "Number of Oscar wins",
       fill = "Season") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none")
  
  # Movies released in the fall



# Exploration 7: The genre make up of each season 
seasonal_genre_plot <- movie_data |> 
  filter(!is.na(primary_genre) & primary_genre != "") |> 
  ggplot(aes(x = season,
             fill = primary_genre)) +
  geom_bar(position = "dodge") +
  labs(x = "Season",
       y = "Proportion",
       fill = "Genre",
       title = "Genre Makeup of Each Movie Release Season",
       subtitle = "The 'action' genre is the most prevalent among all seasons except Fall.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "right")



# Exploration 8: The script type make up of each season
seasonal_script_type_plot <- movie_data |> 
  filter(!is.na(script_type)) |> 
  ggplot(aes(x = season,
             fill = script_type)) +
  geom_bar(position = "dodge") +
  labs(x = "Season",
       y = "Proportion",
       fill = "Script Type",
       title = "Script Type Makeup of Movie Release Season",
       subtitle = "The 'original screenplay' script type is the most prevalent across all seasons.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "right")



# Season with the most overall success: fall