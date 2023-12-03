library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Gross: Domestic, foreign, and worldwide gross
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic






## Exploration 1: How does the domestic gross change over the years from 2007-2022?
potential_outlier <- movie_data |>
  filter(domestic_gross_million < 50)

gross_dom_yearly <- movie_data |> 
  group_by(year) |> 
  summarize(mean_dom_gross = round(mean(domestic_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_dom_gross)) |> 
  ggplot(aes(x = year, 
             y = mean_dom_gross)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outlier, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "COVID-19 Pandemic"),
             aes(x = 2018.5, 
                 y = 7.8, 
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
       y = "Domestic Gross (millions of $)", 
       title = "Average Domestic Gross for Hollywood Movies from 2007-2022",
       subtitle = "There is no foreign gross data available for the year 2021.") +
  ylim(0, 100)
# there are no values of foreign gross for the year 2021. 
# least foreign gross in 2020, the year of COVID when movie theaters were shut down. 
# greatest foreign gross 

potential_outliers <- movie_data |>
  filter(domestic_gross_million < 50)

year_dom_gross <- movie_data |> 
  group_by(year) |> 
  summarize(mean_dom_gross = round(mean(domestic_gross_million, na.rm = TRUE)))  |> 
  ggplot(aes(x = year,
             y = mean_dom_gross)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outliers, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "COVID-19 Pandemic"),
             aes(x = 2018.5, 
                 y = 7.8, 
                 label = label),
             fill = "gray", 
             alpha = 0.2, 
             hjust = 0, 
             vjust = 0) +
  geom_point(data = potential_outliers, 
             color = "red") +
  geom_point(
    data = potential_outliers,
    color = "red", 
    size = 3, 
    shape = "circle open") +
  labs(x = "Year", 
       y = "Mean Domestic Gross (millions of $)", 
       title = "Average Domestic Gross for Hollywood Movies from 2007-2022",
       subtitle = "The average domestic gross revenue for 2020 is heavily impacted by the COVID-19 pandemic.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 100)
gross_dom_yearly



# Filter potential outliers
potential_outlier <- movie_data %>%
  filter(domestic_gross_million < 50)

# Create a data frame for the label in geom_label
label_data <- data.frame(label = "COVID-19 Pandemic", x = 2018.5, y = 7.8)

# Plotting
ggplot(data = year_dom_gross, aes(x = year, y = mean_dom_gross)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outlier, aes(label = "Outlier")) +
  geom_label(data = label_data,
             aes(x = x, y = y, label = label),
             fill = "gray", alpha = 0.2, hjust = 0, vjust = 0) +
  geom_point(data = potential_outlier, color = "red") +
  geom_point(data = potential_outlier, color = "red", size = 3, shape = "circle open") +
  labs(x = "Year",
       y = "Mean Domestic Gross (millions of $)",
       title = "Average Domestic Gross for Hollywood Movies from 2007-2022",
       subtitle = "The average domestic gross revenue for 2020 is heavily impacted by the COVID-19 pandemic.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 100)




year_avg_dom_gross <- movie_data |> 
  filter(!is.na(domestic_gross_million)) |> 
  group_by(year) |> 
  summarize(mean_avg_gross = round(mean(domestic_gross_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_avg_gross))

potential_outlier <- year_avg_dom_gross |>
  filter(mean_avg_gross < 50)

gross_avg_dom_yearly <- ggplot(year_avg_dom_gross, 
                               aes(x = year, 
                                   y = mean_avg_gross)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Mean Opening Weekend Earnings (in millions of $)", 
       title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022",
       subtitle = "The average opening weekend revenue for 2020 is heavily impacted by the COVID-19 pandemic.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(3, 28)






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


