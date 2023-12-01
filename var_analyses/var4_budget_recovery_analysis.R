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

yearly_movie_budget |> 
  DT::datatable()

ggplot(yearly_movie_budget, aes(x = year, y = mean_movie_budget)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Moviet Budget (millions)", 
       title = "Average Budgets in Millions for Hollywood Movies from 2007-2022") 


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
movie_data |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, y = budget_recovered_millions)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Opening Weekend Earnings (millions)",
       y = "Budget Recovery Earnings (millions)",
       title = "Opening Weekend Earnings by Budget Recovery (millions)",
       subtitle = "There is an overall strong positive association between a movie's opening weekend earnings and the percentage of its budget that it recovers.")


### Exploration 4: Facet by script type
movie_data |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = budget_recovered_millions, fill = script)) +
  geom_bar(stat = "identity") 



### Exploration 5: budget vs. oscar wins





