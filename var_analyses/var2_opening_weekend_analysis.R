# Opening weekend revenue: Opening weekend revenue
# KEY TAKEAWAYS
## -heavily impacted by 2020 covid pandemic

## Exploration 1: How do the overall average opening weekend earnings change over the years from 2007-2022?
year_opening_success <- movie_data |> 
  group_by(year) |> 
  summarize(mean_opening_success = round(mean(opening_weekend_million, 
                                              na.rm = TRUE)))  |> 
  arrange(desc(mean_opening_success)) 

# year_opening_success |> 
  #DT::datatable()

potential_outliers <- year_opening_success |>
  filter(mean_opening_success == 20 | mean_opening_success == 9)

opening_wknd_yearly <- ggplot(year_opening_success, 
                              aes(x = year, 
                                  y = mean_opening_success)) +
  geom_line() +
  geom_point() +
  geom_text_repel(data = potential_outliers, 
                  aes(label = "")) +
  geom_label(data = data.frame(label = "2008 Great 
 Recession"),
             aes(x = 2007, 
                 y = 17.1, 
                 label = label),
             fill = "gray", 
             alpha = 0.2, 
             hjust = 0, 
             vjust = 0) +
  geom_label(data = data.frame(label = "COVID-19 
 Pandemic"),
             aes(x = 2018.9, 
                 y = 6.2, 
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
       y = "Mean Opening Weekend Earnings (in millions of $)", 
       title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022",
       subtitle = "2008 is heavily impacted by the Great Recession. 2020 is heavily impacted by the 
COVID-19 pandemic.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(3, 28) +
  scale_x_continuous(breaks = seq(min(year_opening_success$year), 
                                  max(year_opening_success$year), 
                                  by = 2))






### Exploration 2: Which genre has the highest mean opening weekend earning? 
genre_opening_wknd_table <- movie_data |> 
  group_by(genre) |> 
  summarize(mean_opening_success = mean(opening_weekend_million)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3)|> 
  DT::datatable()

genre_opening_wknd_plot <- movie_data |> 
  group_by(genre) |> 
  summarize(mean_opening_success = mean(opening_weekend_million)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 5) |> 
  ggplot(aes(x = fct_infreq(genre, 
                             mean_opening_success), 
             y = mean_opening_success,
             fill = genre)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 5 Genres with Highest Opening 
Weekend Earnings",
       subtitle = "The sci-fi, fantasy genre combination has the highest 
average opening weekend revenue.",
       x = "Genre",
       y = "Mean Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        axis.title.y = element_text(size = 7),
        legend.position = "none") 

### Exploration 3: Which script type has the highest mean opening weekend earning? 
scripttype_opening_wknd_table <- movie_data |> 
  group_by(script_type) |> 
  summarize(mean_opening_success = round(mean(opening_weekend))) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 3) |> 
  DT::datatable()

scripttype_opening_wknd_plot <- movie_data |> 
  group_by(script_type) |> 
  summarize(mean_opening_success = mean(opening_weekend_million)) |> 
  arrange(desc(mean_opening_success)) |> 
  slice_head(n = 5) |> 
  ggplot(aes(x = fct_infreq(script_type, 
                             mean_opening_success), 
             y = mean_opening_success,
             fill = script_type)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 5 Script Types with Highest Opening 
Weekend Earnings",
       subtitle = "The sequel, adaptation script type combination has 
the highest average opening weekend revenue.",
       x = "Script Type",
       y = "Mean Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        axis.title.y = element_text(size = 7),
        legend.position = "none")  +
  scale_fill_viridis_d() 

genre_opening_wknd_plot + scripttype_opening_wknd_plot



# Revenue and Oscar Wins: Analyze the relationship between opening wknd revenue and the number of Oscar wins.
opening_wknd_oscar <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = opening_weekend_million, y = oscar_winners)) +
  geom_boxplot() +
  labs(title = "Opening Weekend Revenue by Oscar Wins",
       subtitle = "Oscar winning movies have a lower average of opening weekend revenue earnings.",
       x = "Opening Weekend Revenue (in millions of $)",
       y = "Oscar Winner") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")

# Correlation between opening weekend rev and gross
opening_wknd_domgross <- movie_data |> 
  ggplot(aes(x = opening_weekend_million, 
             y = domestic_gross_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Domestic Gross by Opening Weekend Revenue",
       subtitle = "There is a strong positive association between the two 
variables.",
       x = "Opening Weekend Revenue (in millions of $)",
       y = "Domestic Gross (in millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")

opening_wknd_forgross <- movie_data |> 
  ggplot(aes(x = opening_weekend_million, 
             y = foreign_gross_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = " Foreign Gross by Opening Weekend Revenue",
       subtitle = " There is a strong positive association between the two 
 variables.",
       x = "Opening Weekend Revenue (in millions of $)",
       y = "Foreign Gross (in millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")

opening_wknd_domgross + opening_wknd_forgross

## Exploration 4: How do the different critic ratings correlate with opening weekend success?
rt_critic_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings by Rotten Tomatoes Critics Rating",
       x = "Rotten Tomatoes Critics Rating",
       y = "Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 8.5),
        plot.title.position = "plot",
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 7))
rt_critic_success_cor

rt_audience_success_cor <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings by Rotten Tomatoes Audience Rating",
       x = "Rotten Tomatoes Audience Rating",
       y = "Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 8.5),
        plot.title.position = "plot",
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 7))
rt_audience_success_cor

mc_critic_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_critics, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Critics Rating",
       x = "Metacritic Critics Rating",
       y = "Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 8.5),
        plot.title.position = "plot",
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 7))
mc_critic_success_cor

mc_audience_success_cor <- movie_data |> 
  ggplot(aes(x = metacritic_audience, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Opening Weekend Earnings (millions) by Metacritic Audience Rating",
       x = "Metacritic Audience Rating",
       y = "Opening Weekend Earnings (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 8.5),
        plot.title.position = "plot",
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 7))
mc_audience_success_cor

rt_critic_success_cor + mc_critic_success_cor


### Exploration 5: What is the correlation between a movie's budget and opening weekend success?
opening_wknd_budget_plot <- movie_data |> 
  ggplot(aes(x = budget_million, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Movie Budget (millions of $)",
       y = "Opening Weekend Earnings (millions of $)",
       title = "Opening Weekend Earnings by Movie Budget",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")


### Exploration 6: What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")







## Exploration 2 by genre
opening_wknd_budget_rcvry_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, 
             y = budget_recovered_millions,
             color = primary_genre)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Opening Weekend Earnings (millions of $)",
       y = "Budget Recovery Earnings (millions of $)",
       title = "Opening Weekend Earnings by Budget Recovery for 
Each Genre",
       subtitle = "The 'adventure' genre has the steepest correlation.",
       color = "Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.text = element_text(size = 7),
        legend.title = element_text(size = 6),
        axis.title.x = element_text(size = 6),
        axis.title.y = element_text(size = 6))


opening_wknd_budget_rcvry_script_type <- movie_data |> 
  filter(!is.na(script_type)) |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, 
             y = budget_recovered_millions,
             color = script_type)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Opening Weekend Earnings (millions of $)",
       y = "Budget Recovery Earnings (millions of $)",
       title = "Opening Weekend Earnings by Budget Recovery for 
Each Script Type",
       subtitle = "The 'remake' script type has the steepest correlation.",
       color = "Script Type") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.text = element_text(size = 7),
        legend.title = element_text(size = 6),
        axis.title.x = element_text(size = 6),
        axis.title.y = element_text(size = 6))

opening_wknd_budget_rcvry_genre + opening_wknd_budget_rcvry_script_type






## Exploration 2 by genre
opening_wknd_budget_rcvry_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, 
             y = budget_recovered_millions,
             color = primary_genre)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Opening Weekend Earnings (millions of $)",
       y = "Budget Recovery Earnings (millions of $)",
       title = "Opening Weekend Earnings by Budget Recovery for 
Each Genre",
subtitle = "The 'adventure' genre has the steepest correlation.",
color = "Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.text = element_text(size = 7),
        legend.title = element_text(size = 6),
        axis.title.x = element_text(size = 6),
        axis.title.y = element_text(size = 6))


opening_wknd_budget_rcvry_script_type <- movie_data |> 
  filter(!is.na(script_type)) |> 
  mutate(budget_recovered_millions = round(budget_million * (budget_recovered / 100))) |> 
  ggplot(aes(x = opening_weekend_million, 
             y = budget_recovered_millions,
             color = script_type)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Opening Weekend Earnings (millions of $)",
       y = "Budget Recovery Earnings (millions of $)",
       title = "Opening Weekend Earnings by Budget Recovery for 
Each Script Type",
subtitle = "The 'remake' script type has the steepest correlation.",
color = "Script Type") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 9),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 7),
        legend.text = element_text(size = 7),
        legend.title = element_text(size = 6),
        axis.title.x = element_text(size = 6),
        axis.title.y = element_text(size = 6))

opening_wknd_budget_rcvry_genre + opening_wknd_budget_rcvry_script_type




# distributor with highest average opening weekend successes
distr_opening_wknd <- movie_data |> 
  filter(!is.na(distributor)) |> 
  group_by(distributor) |> 
  summarize(avg_opening_wnkd = mean(opening_weekend_million, na.rm = TRUE)) |> 
  arrange(desc(avg_opening_wnkd)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(distributor, 
                         -avg_opening_wnkd),
             y = avg_opening_wnkd,
             fill = distributor)) +
  geom_bar(stat = "identity") +
  labs(title = "Top 10 Movie Distributors with Greatest Average Opening Weekend Success",
       subtitle = "Walt Disney Studios has the most opening weekend earnings.",
       x = "Distributor",
       y = "Average Opening Weekend Revenue (millions of $)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        axis.title.y = element_text(size = 9))


# opening wknd success by rotten tomatoes audience
rt_audience_by_opening_wknd <- movie_data |> 
  ggplot(aes(x = opening_weekend_million,
             y = rotten_tomatoes_audience)) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(title = "Opening Weekend Revenue by Rotten Tomatoes Audience Score",
       subtitle = "There is a positive relationship between the two variables.",
       x = "Opening Weekend (millions of $)",
       y = "Rotten Tomatoes Audience Score") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot")


