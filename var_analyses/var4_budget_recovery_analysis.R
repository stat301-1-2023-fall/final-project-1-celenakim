# Budget recovery: Budget recovered, and during opening weekend alone

## Exploration 1: How do the overall movie budgets change over the years from 2007-2022?
yearly_movie_budget <- movie_data |> 
  group_by(year) |> 
  summarize(mean_movie_budget = round(mean(budget_million, na.rm = TRUE)))  |> 
  arrange(desc(mean_movie_budget)) 

potential_budget_outliers <- yearly_movie_budget |>
  filter(mean_movie_budget == 47 | mean_movie_budget == 49)

budget_yearly <- ggplot(yearly_movie_budget, aes(x = year, y = mean_movie_budget)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_budget_outliers, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "2008 Great 
 Recession"),
 aes(x = 2007, 
     y = 39, 
     label = label),
 fill = "gray", 
 alpha = 0.2, 
 hjust = 0, 
 vjust = 0) +
  geom_label(data = data.frame(label = "COVID-19 
 Pandemic"),
 aes(x = 2019, 
     y = 37, 
     label = label),
 fill = "gray", 
 alpha = 0.2, 
 hjust = 0, 
 vjust = 0) +
  geom_point(data = potential_budget_outliers, 
             color = "red") +
  geom_point(
    data = potential_budget_outliers,
    color = "red", 
    size = 3, 
    shape = "circle open") +
  labs(x = "Year", 
       y = "Mean Budget (in millions of $)", 
       title = "Average Movie Budgets for Hollywood Movies from 2007-2022",
       subtitle = "There are significant drops in the years 2008 and 2020.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 70) +
  scale_x_continuous(breaks = seq(min(yearly_movie_budget$year), max(yearly_movie_budget$year), by = 2))



## Exploration 2: What is the correlation between a movie's budget and opening weekend success? Worldwide gross?
budget_opening_wknd <- movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions of $)",
       y = "Opening Weekend Earnings (millions of $)",
       title = "Movie Budget by Opening Weekend Revenue",
       subtitle = "There is a direct positive association between the 
two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", 
                                  size = 12),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 11))

budget_ww_gross <- movie_data |> 
  ggplot(aes(x = budget_million, y = worldwide_gross_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions of $)",
       y = "Worldwide Gross (millions of $)",
       title = "Movie Budget by Worldwide Gross",
       subtitle = "There is a direct positive association between the 
two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 12),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 11))

budget_opening_wknd + budget_ww_gross



## Exploration 3: Facet by genre
budget_by_genre <- movie_data |> 
  filter(!is.na(budget_million) & 
           !is.na(primary_genre) & 
           primary_genre != "")  |> 
  ggplot(aes(x = reorder(primary_genre, 
                         -budget_million), 
             y = budget_million, 
             fill = primary_genre)) +
  geom_boxplot() +
  labs(title = "Genre-specific Movie Budgets",
       subtitle = "The fantasy genre has the highest average production budget.",
       x = "Genre",
       y = "Average Budget (millions of $)",
       fill = "Primary Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")


## Exploration 4: Facet by script type
budget_by_scripttype <- movie_data |> 
  filter(!is.na(budget_million) & 
           !is.na(script_type) & 
           script_type != "")  |> 
  ggplot(aes(x = reorder(script_type, 
                         -budget_million), 
             y = budget_million, 
             fill = script_type)) +
  geom_boxplot() +
  labs(title = "Movie Budgets by Script Type",
       subtitle = "The 'sequel, adaptation' script type has the highest average production budget.",
       x = "Script Type",
       y = "Average Budget (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        legend.position = "none")



## Exploration 5: facet by distributor
distr_budget <- movie_data |> 
  filter(!is.na(budget_million) & 
           !is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(mean_budget = round(mean(budget_million, 
                                     na.rm = TRUE))) |> 
  arrange(desc(mean_budget)) |>  
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(distributor,
                         -mean_budget),
             y = mean_budget,
             fill = distributor)) +
  geom_bar(stat = "identity") +
  labs(x = "Distributor",
       y = "Average Budget (millions of $)",
       title = "Top 10 Distributors with Highest Average Movie Budgets",
       subtitle = "Walt Disney Studios has the highest average production budget.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1,
                                   size = 7),
        legend.position = "none")



## Exploration 6: budget vs. oscar wins
budget_oscars <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = budget_million, y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Distribution of Movie Budget by Oscar Wins",
       subtitle = "Oscar winning movies have a lower average budget.",
       x = "Production Budget (millions of $)",
       y = "Oscar Winner") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")



## Exploration 7: Relationship between budget and avg critic & audience ratings, IMDb
budget_critic <- movie_data |> 
  ggplot(aes(x = budget_million, y = average_critics)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Budget (millions of $)",
       y = "Average Critic Rating",
       title = "Critic Ratings by Movie Budget",
       subtitle = "There is a very weak association between 
the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9))

budget_audience <- movie_data |> 
  ggplot(aes(x = budget_million, y = average_audience)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Budget (millions of $)",
       y = "Average Audience Rating",
       title = "Audience Ratings by Movie Budget",
       subtitle = "There is a very weak association between 
the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9))

budget_imdb <- movie_data |> 
  ggplot(aes(x = budget_million, y = im_db_rating)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Budget (millions of $)",
       y = "IMDb Rating",
       title = "IMDb Ratings by Movie Budget",
       subtitle = "There is a very weak association between 
the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9))

budget_critic + budget_audience + budget_imdb





## EXTRA EXPLORATIONS:

## What is the correlation between a movie's opening weekend revenue and its budget recovered during opening weekend?
budget_rcvry_opening_wknd <- movie_data |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, y = budget_recovered_millions)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Opening Weekend Earnings (millions of $)",
       y = "Budget Recovery Earnings (millions of $)",
       title = "Opening Weekend Earnings by Budget Recovery",
       subtitle = "There is an overall strong positive association between the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")
