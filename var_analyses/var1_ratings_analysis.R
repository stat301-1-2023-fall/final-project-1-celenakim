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
  ylim(0, 100)
ratings_yearly_plot



## Exploration 2: What is the distribution of average critic ratings?
movie_data |> 
  ggplot(aes(x = average_critics)) +
  geom_histogram(binwidth = 4) +
  labs(x = "Average Rotten Tomatoes and Metacritic Critic Rating",
       y = "Count",
       title = "Distribution of Average Rotten Tomatoes and Metacritic Critic Rating")


## Exploration 3: How do the overall average rotten tomato critic ratings change over the years from 2007-2022?
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


## Exploration 4: How do the overall average metacritic critic ratings change over the years from 2007-2022?
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


### Exploration 5: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
critic_ratings_oscar_table <- movie_data |> 
  filter(!is.na(oscar_winners)) |> 
  group_by(oscar_winners) |> 
  summarize(mean_critic_rating = round(mean(average_critics, 
                                            na.rm = TRUE))) |> 
  DT::datatable()


### Exploration 6: Which distributor has the highest IMDb rating?
imdb_rating_by_dist <- movie_data |> 
  group_by(distributor) |> 
  summarize(mean_imdb = mean(im_db_rating, na.rm = TRUE),
            mean_opening_wknd_rev = mean(opening_weekend_million, na.rm = TRUE),
            mean_worldwide_gross = mean(worldwide_gross_million, na.rm = TRUE)) |> 
  arrange(desc(mean_imdb)) |> 
  slice_head(n = 3) |> 
  DT::datatable()
imdb_rating_by_dist



### Exploration 7: What is the correlation between a movie's IMDb rating and opening weekend success?
movie_data |> 
  ggplot(aes(x = im_db_rating, y = opening_weekend_million)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "IMDb Rating",
       y = "Opening Weekend Earnings (millions)",
       title = "Opening Weekend Earnings (millions) by IMDb Rating",
       subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")




## Explore the average ratings (critics and audience) for each primary genre.
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


