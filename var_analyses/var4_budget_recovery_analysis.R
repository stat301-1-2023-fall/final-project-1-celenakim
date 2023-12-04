library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Budget recovery: Budget recovered, and during opening weekend alone
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic

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




### Exploration 2: What is the correlation between a movie's budget and opening weekend success?
movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions)",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings by Movie Budget (millions)",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")



### Exploration 3: What is the correlation between a movie's opening weekend revenue and its budget recovered during opening weekend?
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



### Exploration 4: Facet by script type
movie_data |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = budget_recovered_millions, fill = script)) +
  geom_bar(stat = "identity") 



### Exploration 5: budget vs. oscar wins





