library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

movie_data <- read_csv("data/movie_data.csv")

# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim

# Gross: Domestic, foreign, and worldwide gross


## Exploration 1: How does the domestic gross change over the years from 2007-2022?
year_dom_gross <- movie_data |> 
  group_by(year) |> 
  summarize(mean_dom_gross = round(mean(domestic_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_dom_gross)) 

potential_outlier <- year_dom_gross |>
  filter(mean_dom_gross == 25 | mean_dom_gross == 62)

gross_dom_yearly <- ggplot(year_dom_gross, aes(x = year, y = mean_dom_gross)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outlier, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "2008 Great 
 Recession"),
             aes(x = 2007, 
                 y = 53.5, 
                 label = label),
             fill = "gray", 
             alpha = 0.2, 
             hjust = 0, 
             vjust = 0) +
  geom_label(data = data.frame(label = "COVID-19 
 Pandemic"),
             aes(x = 2019, 
                 y = 16.5, 
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
       y = "Mean Domestic Gross (in millions of $)", 
       title = "Average Domestic Gross for Hollywood Movies from 2007-2022",
       subtitle = "There are significant drops in the years 2008 and 2020.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 100) +
  scale_x_continuous(breaks = seq(min(year_dom_gross$year), max(year_dom_gross$year), by = 2))
gross_dom_yearly



## Exploration 2: What is the relationship between domestic vs. foreign gross?
gross_rel_plot <- movie_data |> 
  ggplot(aes(x = domestic_gross_million,
             y = foreign_gross_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Relationship Between a Hollywood Movie's Domestic and Foreign Gross",
       subtitle = "There is a strong positive correlation between the two variables.",
       x = "Domestic Gross (in millions of $)",
       y = "Foreign Gross (in millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") 



## Exploration 3: Genre-Specific Domestic and Foreign Gross Performance
gross_domestic_genre <- movie_data |> 
  filter(!is.na(domestic_gross_million) & 
           !is.na(primary_genre) & 
           primary_genre != "")  |> 
  ggplot(aes(x = fct_reorder(primary_genre, -domestic_gross_million), 
             y = domestic_gross_million, 
             fill = primary_genre)) +
  geom_boxplot() +
  labs(title = "Genre-specific Domestic Gross Performance",
       subtitle = "The sci-fi category has the best performance.",
       x = "Genre",
       y = "Domestic Gross (in millions of $)",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")

gross_foreign_genre <- movie_data |> 
  filter(!is.na(foreign_gross_million) & 
           !is.na(primary_genre) & 
           primary_genre != "")  |> 
  ggplot(aes(x = reorder(primary_genre, -foreign_gross_million), 
             y = foreign_gross_million, 
             fill = primary_genre)) +
  geom_boxplot() +
  labs(title = "Genre-specific Foreign Gross Performance",
       subtitle = "The action and adventure categories have the best performance.",
       x = "Genre",
       y = "Foreign Gross (in millions of $)",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none") +
  ylim(0, 800)

gross_domestic_genre + gross_foreign_genre



## Exploration 4: Script Type-Specific Domestic and Foreign Gross Performance
gross_domestic_script_type <- movie_data |> 
  filter(!is.na(domestic_gross_million) & 
           !is.na(script_type) & 
           script_type != "")  |> 
  ggplot(aes(x = fct_reorder(script_type, 
                             -domestic_gross_million), 
             y = domestic_gross_million, 
             fill = script_type)) +
  geom_boxplot() +
  labs(title = "Domestic Gross Performance by Script Type",
       subtitle = "The 'sequel, adaption' script type has the best performance.",
       x = "Script Type",
       y = "Domestic Gross (millions of $)",
       fill = "Script Type") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 11),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")

gross_foreign_script_type <- movie_data |> 
  filter(!is.na(foreign_gross_million) & 
           !is.na(script_type) & 
           script_type != "")  |> 
  ggplot(aes(x = reorder(script_type, 
                         -foreign_gross_million), 
             y = foreign_gross_million, 
             fill = script_type)) +
  geom_boxplot() +
  labs(title = "Foreign Gross Performance by Script Type",
       subtitle = "The 'sequel, adaptation' script type has the best performance.",
       x = "Script Type",
       y = "Foreign Gross (millions of $)",
       fill = "Script Type") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 11),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none") 

gross_domestic_script_type + gross_foreign_script_type



## Exploration 5: Analyze the worldwide performance of movies by different distributors.
dom_gross_distributor <- movie_data |> 
  filter(!is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(avg_dom_gross = mean(domestic_gross_million, 
                                 na.rm = TRUE)) |> 
  arrange(desc(avg_dom_gross)) |> 
  slice_head(n = 5) |> 
  ggplot(aes(x = reorder(distributor, 
                         -avg_dom_gross), 
             y = avg_dom_gross)) +
  geom_bar(stat = "identity", 
           fill = "skyblue") +
  labs(title = "Top 5 Movie Distributors with the Highest 
Domestic Gross",
subtitle = "Walt Disney Studios had the most successful domestic gross 
performance.",
x = "Distributor",
y = "Average Domestic Gross (in millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 12),
        plot.subtitle = element_text(size = 9),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        axis.title.y = element_text(size = 9)) +
  ylim(0, 800)

for_gross_distributor <- movie_data |> 
  filter(!is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(avg_for_gross = mean(foreign_gross_million, 
                                 na.rm = TRUE)) |> 
  arrange(desc(avg_for_gross)) |> 
  slice_head(n = 5) |> 
  ggplot(aes(x = reorder(distributor, 
                         -avg_for_gross), 
             y = avg_for_gross)) +
  geom_bar(stat = "identity", 
           fill = "lightgreen") +
  labs(title = "Top 5 Movie Distributors with the Highest 
Foreign Gross",
subtitle = "Walt Disney Studios had the most successful foreign gross 
performance.",
x = "Distributor",
y = "Average Foreign Gross (in millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 12),
        plot.subtitle = element_text(size = 9),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        axis.title.y = element_text(size = 9)) +
  ylim(0, 800)

dom_gross_distributor + for_gross_distributor



## Exploration 6: Analyze the relationship between worldwide gross and budget recovery
ww_gross_budget_rcvry <- movie_data |> 
  filter(budget_recovered < 10000) |> 
  ggplot(aes(x = worldwide_gross_million,
             y = budget_recovered)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Relationship Between a Hollywood Movie's Worldwide Gross and the Percent of its
Budget Recovered",
subtitle = "There is a positive association between the two variables.",
x = "Worldwide Gross (in millions of $)",
y = "Percent of Budget Recovered") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") 



## Exploration 7: Which genre has the highest foreign to domestic gross percentage
genre_prcnt_earned_abroad <- movie_data |> 
  filter(!is.na(primary_genre) & !is.na(of_gross_earned_abroad)) |> 
  group_by(primary_genre) |> 
  summarize(avg_pcnt_abroad = mean(of_gross_earned_abroad, na.rm = TRUE)) |> 
  arrange(desc(avg_pcnt_abroad)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(primary_genre,
                         -avg_pcnt_abroad),
             y = avg_pcnt_abroad,
             fill = primary_genre)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Genres with the Most Percentage of Gross Earned Abroad",
       subtitle = "The 'sci-fi' category earns the most of its gross from foreign audiences.",
       x = "Genre",
       y = "% of Gross Earned Abroad") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 12),
        plot.subtitle = element_text(size = 9),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")



## Exploration 8: Which genre has the highest foreign to domestic gross percentage
script_type_prcnt_earned_abroad <- movie_data |> 
  filter(!is.na(script_type) & !is.na(of_gross_earned_abroad)) |> 
  group_by(script_type) |> 
  summarize(avg_pcnt_abroad = mean(of_gross_earned_abroad, na.rm = TRUE)) |> 
  arrange(desc(avg_pcnt_abroad)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(script_type,
                         -avg_pcnt_abroad),
             y = avg_pcnt_abroad,
             fill = script_type)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Script Types with the Most Percentage of Gross Earned Abroad",
       subtitle = "The 'based on a true story, remake' & 'sequel, adaptation' script types both earn the highest proportion of their gross from foreign audiences.",
       x = "Script Type",
       y = "% of Gross Earned Abroad") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 12),
        plot.subtitle = element_text(size = 8.7),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1,
                                   size = 6.5),
        legend.position = "none")




# EXTRA EXPLORATIONS:

## How does the worldwide gross change over the years from 2007-2022?
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

# What is the correlation between `wordwide_gross` and `budget_recovered`?
movie_data |> 
  filter(budget_recovered < 30000) |> 
  ggplot(aes(x = worldwide_gross_million,
             y = budget_recovered)) +
  geom_point() +
  geom_smooth(method = "lm")


# Top 10 Movie Distributors Based on Worldwide Gross Performance
movie_data |> 
  filter(!is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(avg_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(avg_worldwide_gross)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(distributor, avg_worldwide_gross), y = avg_worldwide_gross)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Movie Distributors Based on Worldwide Gross Performance",
       subtitle = "Walt Disney Studios earned the highest average worldwide gross revenue.",
       x = "Distributor",
       y = "Average Worldwide Gross (in millions)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Revenue and Oscar Wins: Analyze the relationship between box office revenue and the number of Oscar wins.
movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = worldwide_gross_million, y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Box Office Revenue by Oscar Wins",
       subtitle = "Oscar winning movies have a higher average worldwide gross.",
       x = "Worldwide Gross (in millions)",
       y = "Oscar Winners") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")