library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

# Ratings: Rotten Tomatoes, Metacritic, and IMDb ratings, both critic and audience


## Exploration 1: Average critic and audience ratings over the years
ratings_yearly_plot <- movie_data |> 
  group_by(year) |> 
  summarize(avg_critics_ratings = mean(average_critics, 
                                       na.rm = TRUE),
            avg_audience_ratings = mean(average_audience, 
                                        na.rm = TRUE)) |> 
  ggplot(aes(x = year)) +
  geom_line(aes(y = avg_critics_ratings, 
                color = "Critics"), 
            size = 1.5) +
  geom_line(aes(y = avg_audience_ratings, 
                color = "Audience"), 
            linetype = "dashed", 
            size = 1.5) +
  labs(title = "Average Audience and Critic Ratings Over the Years",
       subtitle = "Both the average audience and average critic ratings have increased 
over the years overall. Critics seem to rate lower than audiences.",
       x = "Year",
       y = "Average Rating",
       color = "Rating Type") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot") +
  ylim(0, 100) +
  scale_x_continuous(breaks = seq(min(movie_data$year), max(movie_data$year), by = 2)) 
ratings_yearly_plot



### Exploration 2: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
critic_ratings_oscar <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  ggplot(aes(x = average_critics, y = oscar_winners)) +
  geom_boxplot() +
  labs(x = "Average Critic Rating",
       y = "Oscar Winner",
       title = "Distribution of Critic Ratings by Oscar Wins",
       subtitle = "Oscar winning movies have a higher mean critic rating.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "top")



## Exploration 3: How do rotten tomato critic ratings influence its opening weekend rev?
rating_rt_critcs_opening_wknd <- movie_data |> 
  ggplot(aes(x = rotten_tomatoes_critics,
             y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Rotten Tomatoes Critic Rating",
       y = "Opening Weekend Revenue (millions of $)",
       title = "Opening Weekend Earnings by Rotten Tomatoes Critic Rating",
       subtitle = "There is a slight positive association between a movie's Rotten Tomatoes critic score and its opening 
weekend revenue.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "top")



## Exploration 4: Explore the average ratings (critics and audience) for each primary genre.
ratings_script_type_plot <- movie_data |> 
  filter(!is.na(script_type)) |> 
  group_by(script_type) |> 
  summarize(avg_rotten_tomatoes_critics = mean(rotten_tomatoes_critics, 
                                               na.rm = TRUE),
            avg_metacritc_critics = mean(metacritic_critics, 
                                         na.rm = TRUE),
            avg_im_db_rating = mean(im_db_rating, 
                                    na.rm = TRUE)) |> 
  gather(key = "rating_type", 
         value = "average_rating", 
         -script_type) |> 
  ggplot(aes(x = script_type, 
             y = average_rating, 
             fill = rating_type)) +
  geom_bar(stat = "identity", 
           position = "dodge", 
           color = "white",
           width = 1) +
  labs(title = "Average IMDb, Metacritic, and Rotten Tomatoes Critic Ratings by Script Type",
       subtitle = "A majority of script types are missing information about their average IMDb rating.",
       x = "Script Type",
       y = "Average Rating",
       fill = "Rating Type") +
  scale_fill_manual(values = c("avg_rotten_tomatoes_critics" = "salmon", 
                               "avg_metacritc_critics" = "lightblue", 
                               "avg_im_db_rating" = "lightgreen"),
                    labels = c(avg_rotten_tomatoes_critics = "Rotten Tomatoes Critics",
                               avg_metacritc_critics = "Metacritic Critics",
                               avg_im_db_rating = "IMDb")) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "top")



## Exploration 5: Audience vs critics ratings deviance by genre
ratings_deviance_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  group_by(primary_genre) |> 
  summarize(average_deviance = mean(audience_vs_critics_deviance, 
                                    na.rm = TRUE)) |> 
  ggplot(aes(x = reorder(primary_genre, 
                         -average_deviance), 
             y = average_deviance,
             fill = primary_genre))  +
  labs(x = "Genre",
       y = "Audience vs. Critics Deviance",
       title = "Audience vs. Critics Ratings Deviance by Genre",
       subtitle = "Audience and critics have the lowest difference in ratings for the 'biography' genre, and the largest for 
the 'sci-fi' genre.") +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) 



## Exploration 6: Rotten Tomatoes vs Metacritics audience ratings deviance by genre
rt_metacritic_deviance_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  group_by(primary_genre) |> 
  summarize(aveg_dev = mean(rotten_tomatoes_vs_metacritic_deviance, 
                            na.rm = TRUE)) |> 
  ggplot(aes(x = reorder(primary_genre, 
                         -aveg_dev), 
             y = aveg_dev,
             fill = primary_genre))  +
  labs(x = "Genre",
       y = "Deviance",
       title = "Rotten Tomatoes vs. Metacritic Audience Ratings Deviance by Genre",
       subtitle = "The 'sci-fi' genre has the lowest deviance, and the 'biography' genre has the highest.") +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) 



## Exploration 7: Audience and Critic Ratings, correlated with domestic gross, by genre
# critics
critic_rating_dom_gross_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  ggplot(aes(x = average_critics, 
             y = domestic_gross_million,
             color = primary_genre)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Average Critic Rating",
       y = "Domestic Gross (millions of $)",
       title = "The Relationship of Average Rotten Tomatoes & Metacritic 
Critic Ratings and Domestic Gross, by Genre",
subtitle = "The 'action' genre has the highest correlation between the two variables.",
color = "Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 11),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        legend.position = "bottom",
        legend.text = element_text(size = 7.5),   
        legend.title = element_text(size = 7.5)) +
  xlim(0, 100) +
  ylim(0, 800)

# audience
aud_rating_dom_gross_genre <- movie_data |> 
  filter(!is.na(primary_genre)) |> 
  ggplot(aes(x = average_audience, 
             y = domestic_gross_million,
             color = primary_genre)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Average Audience Rating",
       y = "Domestic Gross (millions of $)",
       title = "The Relationship of Average Rotten Tomatoes & Metacritic 
Audience Ratings and Domestic Gross, by Genre",
subtitle = "The 'action' genre has the highest correlation between the two variables.",
color = "Genre") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 11),
        plot.title.position = "plot",
        plot.subtitle = element_text(size = 9),
        legend.position = "bottom",
        legend.text = element_text(size = 7.5),   
        legend.title = element_text(size = 7.5)) +
  xlim(0, 100) +
  ylim(0, 800)

critic_rating_dom_gross_genre + aud_rating_dom_gross_genre 



## Exploration 8: Top 10 distributors by avg critic and audience ratings
aud_ratings_distributor <- movie_data |> 
  group_by(distributor) |> 
  summarize(avg_aud = mean(average_audience, na.rm = TRUE)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(distributor, 
                         -avg_aud),  
             y = avg_aud,
             fill = distributor)) +
  geom_bar(stat = "identity") +
  labs(x = "Distributor",
       y = "Average Audience Rating",
       title = "Top 10 Movie Distributors with Highest Average 
Rotten Tomatoes & Metacritic Audience Ratings",
subtitle = "Atlas Distribution Company has the highest audience ratings.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) +
  ylim(0, 95)

critic_ratings_distributor <- movie_data |> 
  group_by(distributor) |> 
  summarize(avg_critic = mean(average_critics, na.rm = TRUE)) |> 
  slice_head(n = 10) |> 
  ggplot(aes(x = reorder(distributor, 
                         -avg_critic),  
             y = avg_critic,
             fill = distributor)) +
  geom_bar(stat = "identity") +
  labs(x = "Distributor",
       y = "Average Critic Rating",
       title = "Top 10 Movie Distributors with Highest Average 
Rotten Tomatoes & Metacritic Critic Ratings",
subtitle = "A24 has the highest critic ratings.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) +
  ylim(0, 95)

critic_ratings_distributor + aud_ratings_distributor



## Exploration 9: Average Critic and Audience, ratings by percent earned abroad
critic_pcnt_abroad <- movie_data |> 
  ggplot(aes(x = average_critics, y = of_gross_earned_abroad)) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Average Critic Rating",
       y = "% of Gross Earned Abroad",
       title = "Percent of Gross Earned Abroad by Critic Ratings",
       subtitle = "There is no correlation between the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.subtitle = element_text(size = 9),
        plot.title.position = "plot")

aud_pcnt_abroad <- movie_data |> 
  ggplot(aes(x = average_audience, y = of_gross_earned_abroad)) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE) +
  labs(x = "Average Audience Rating",
       y = "% of Gross Earned Abroad",
       title = "Percent of Gross Earned Abroad by Audience Ratings",
       subtitle = "There is no correlation between the two variables.") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold",
                                  size = 10),
        plot.subtitle = element_text(size = 9),
        plot.title.position = "plot")

critic_pcnt_abroad + aud_pcnt_abroad




# EXTRA EXPLORATIONS
## What is the distribution of average critic ratings?
movie_data |> 
  ggplot(aes(x = average_critics)) +
  geom_histogram(binwidth = 4) +
  labs(x = "Average Rotten Tomatoes and Metacritic Critic Rating",
       y = "Count",
       title = "Distribution of Average Rotten Tomatoes and Metacritic Critic Rating")


## How do the overall average rotten tomato critic ratings change over the years from 2007-2022?
yearly_rt_critic_rating <- movie_data |> 
  group_by(year) |> 
  summarize(mean_rt_rating = round(mean(rotten_tomatoes_critics, na.rm = TRUE)))  |> 
  arrange(desc(mean_rt_rating)) 

yearly_rt_critic_rating |> 
  DT::datatable()

ggplot(yearly_rt_critic_rating, aes(x = year, y = mean_rt_rating)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Rotten Tomatoes Critic Ratings", 
       title = "Average Rotten Tomatoes Critic Ratings for Hollywood Movies from 2007-2022") 


## How do the overall average metacritic critic ratings change over the years from 2007-2022?
yearly_mc_critic_rating <- movie_data |> 
  group_by(year) |> 
  summarize(mean_mc_rating = round(mean(metacritic_critics, na.rm = TRUE)))  |> 
  arrange(desc(mean_mc_rating)) 

yearly_mc_critic_rating |> 
  DT::datatable()

ggplot(yearly_mc_critic_rating, aes(x = year, y = mean_mc_rating)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", 
       y = "Metacritic Critic Ratings", 
       title = "Average Metacritic Critic Ratings for Hollywood Movies from 2007-2022") 


## Which distributor has the highest IMDb rating?
imdb_rating_by_dist <- movie_data |> 
  group_by(distributor) |> 
  summarize(mean_imdb = mean(im_db_rating, na.rm = TRUE),
            mean_opening_wknd_rev = mean(opening_weekend_million, na.rm = TRUE),
            mean_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(mean_imdb)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
imdb_rating_by_dist


## What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")


# Which distributor has the highest rotten tomato critic rating? 
# How do its opening weekend rev and worldwide gross compare to other distributors
movie_data |> 
  group_by(distributor) |> 
  summarize(mean_rt_critics = mean(rotten_tomatoes_critics, na.rm = TRUE)) |> 
  arrange(desc(mean_rt_critics)) |> 
  slice_head(n = 5) |> 
  DT::datatable()

movie_data |> 
  filter(distributor == "Cinereach" | distributor == "Sony Pictures Classics" | distributor == "A24") |>
  group_by(distributor) |> 
  summarize(mean_imdb = mean(im_db_rating, na.rm = TRUE),
            mean_opening_wknd_rev = mean(opening_weekend_million, na.rm = TRUE),
            mean_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE))

summarize(mean_imdb = mean(im_db_rating, na.rm = TRUE),
          mean_opening_wknd_rev = mean(opening_weekend_million, na.rm = TRUE),
          mean_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE))














ratings_deviance_scripttype <- movie_data |> 
  filter(!is.na(script_type)) |> 
  group_by(script_type) |> 
  summarize(average_deviance = mean(audience_vs_critics_deviance, 
                                    na.rm = TRUE)) |> 
  ggplot(aes(x = script_type, 
             y = average_deviance,
             fill = script_type))  +
  labs(x = "Genre",
       y = "Audience vs. Critics Deviance",
       title = "Audience vs. Critics Ratings Deviance by Genre",
       subtitle = "Audience and critics have the lowest difference in ratings for the 'biography' genre, and the largest for 
the 'sci-fi' genre.") +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) 

movie_data |> 
  filter(!is.na(primary_genre)) |> 
  group_by(primary_genre) |> 
  summarize(aveg_dev = mean(rotten_tomatoes_vs_metacritic_deviance, 
                            na.rm = TRUE)) |> 
  ggplot(aes(x = reorder(primary_genre, 
                         -aveg_dev), 
             y = aveg_dev,
             fill = primary_genre))  +
  labs(x = "Genre",
       y = "Deviance",
       title = "Rotten Tomatoes vs. Metacritic Audience Ratings Deviance by Genre",
       subtitle = "The 'sci-fi' genre has the lowest deviance, and the 'biography' genre has the highest.") +
  geom_bar(stat = "identity") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        plot.title.position = "plot",
        legend.position = "none",
        axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) 