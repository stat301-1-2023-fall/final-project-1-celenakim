library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Gross: Domestic, foreign, and worldwide gross
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic

## Exploration 1: How does the foreign gross change over the years from 2007-2022?
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
       subtitle = "There is no foreign gross data available for the year 2021.") +
  ylim(0, 140)
# there are no values of foreign gross for the year 2021. 
# least foreign gross in 2020, the year of COVID when movie theaters were shut down. 
# greatest foreign gross 

## Exploration 2: How does the domestic gross change over the years from 2007-2022?
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


## Exploration 3: How does the worldwide gross change over the years from 2007-2022?
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




## Exploration 4: is there a relationship between domestic vs. foreign





## Exploration 6: Genre-Specific Domestic and Foreign Gross Performance
movie_data |> 
  filter(!is.na(foreign_gross_million) & !is.na(primary_genre) & primary_genre != "")  |> 
  ggplot(aes(x = primary_genre, y = foreign_gross_million, fill = primary_genre)) +
  geom_boxplot() +
  labs(title = "Genre-specific Foreign Gross Performance",
       subtitle = "The action and adventure categories have the best performance.",
       x = "Primary Genre",
       y = "Foreign Gross (in millions)",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


movie_data |> 
  filter(!is.na(domestic_gross_million) & !is.na(primary_genre) & primary_genre != "")  |> 
  ggplot(aes(x = primary_genre, y = domestic_gross_million, fill = primary_genre)) +
  geom_boxplot() +
  labs(title = "Genre-specific Domestic Gross Performance",
       subtitle = "The sci-fi category has the best performance.",
       x = "Primary Genre",
       y = "Domestic Gross (in millions)",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



# Exploration 7: Budget and Revenue Composition by Genre
# Analyze the composition of budget and revenue components (domestic, foreign, worldwide) by genre.
movie_data |> 
  gather(key = "component", value = "revenue", domestic_gross_million, foreign_gross_million, worldwide_gross_million) |> 
  filter(!is.na(primary_genre) & primary_genre != "") |> 
  ggplot(aes(x = primary_genre, y = revenue, fill = component)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Budget and Revenue Composition by Genre",
       x = "Primary Genre",
       y = "Revenue (in millions)",
       fill = "Component") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# makes sense, genre trends
movie_data |> 
  group_by(year, primary_genre) |> 
  filter(!is.na(primary_genre)) |> 
  summarize(count = n()) |> 
  ggplot(aes(x = year, y = count, color = primary_genre)) +
  geom_line() +
  labs(title = "Genre Trends Over Years",
       x = "Year",
       y = "Number of Movies",
       color = "Primary Genre") +
  theme_minimal() +
  ylim(0, 30)


### Exploration 8: Analyze the worldwide performance of movies by different distributors.
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





