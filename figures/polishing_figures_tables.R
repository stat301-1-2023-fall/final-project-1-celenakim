library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

### VAR1_RATINGS_ANALYSIS
ratings_yearly_plot
# ![](figures/var1_figures/ratings_yearly_plot.png)
# Average ratings for both groups increased over the years, critics rate lower than audiences.

critic_ratings_oscar_table
# ![](figures/var1_figures/critic_ratings_oscar_table.png)
# Movies who have won at least one Oscar have a higher mean rt critic rating than those who have not won any Oscars.

rating_rt_critcs_opening_wknd
# ![](figures/var1_figures/rating_rt_critcs_opening_wknd_plot.png)
# Movies who have won at least one Oscar have a higher mea

ratings_script_type_plot
# ![](figures/var1_figures/ratings_script_type_plot.png)
# A majority of script types do not have information available for the IMDb rating.



### VAR2_OPENING_WEEKEND_REV_ANALYSIS
opening_wknd_yearly
# ![](figures/var2_figures/opening_wknd_yearly_plot.png)
# The opening weekend rev for 2020 is highly impacted by the pandemic, 2008 by the great recession.

genre_opening_wknd_plot + scripttype_opening_wknd_plot
# ![](figures/var2_figures/opening_wknd_genre_script_plot.png)
# Top 5 opening weekend revenues by genre and script type.

budget_rcvry_opening_wknd
# ![](figures/var2_figures/budget_rcvry_opening_wknd_plot.png)
# There is a very strong positive asociation between the two variables

opening_wknd_oscar
# ![](figures/var2_figures/opening_wknd_oscar_plot.png)
# Movies who have won oscars have a lower average opening weekend revenue.

opening_wknd_domgross + opening_wknd_forgross
# ![](figures/var2_figures/opening_wknd_dom_for_plot.png)
# Both plots have strong positive associations, very close to a correlation value of 1. 
# However, the line is steeper for domestic gross, indicating a stronger/more positive correlation.



### VAR3_GROSS_ANALYSIS
gross_dom_yearly
# ![](figures/var3_figures/gross_dom_yearly_plot.png)
# Same pattern for opening wknd, 2020 is highly impacted by the pandemic, 2008 by great recession.

gross_rel_plot
# ![](figures/var3_figures/gross_rel_plot.png)
# There is a direct strong positive correlation, domestic and foreign audiences have similar behavior in movie favorability.

gross_domestic_genre + gross_foreign_genre
# ![](figures/var3_figures/gross_genre_plot.png)
# Sci fi has best domestic gross performance, action and adventure are tied for the best foreign gross performance.

dom_gross_distributor + for_gross_distributor
# ![](figures/var3_figures/gross_distributor_plot.png)
# Walt Disney Studios has the most successful gross performance for both domestic and foreign.

ww_gross_budget_rcvry
# ![](figures/var3_figures/ww_gross_budget_rcvry_plot.png)
# There is an overall positive association between a movie's ww gross performance and budget recovery percentage 



### VAR4_BUDGET_ANALYSIS
budget_yearly
# ![](figures/var4_figures/budget_yearly_plot.png)
# Same pattern, 2020 is highly impacted by the pandemic, 2008 by great recession.

budget_opening_wknd + budget_ww_gross
# ![](figures/var4_figures/budget_opening_wknd_ww_gross_plot.png)
# There is a direct postive association.

budget_by_genre
# ![](figures/var4_figures/budget_by_genre_plot.png)
# Fantasy genre has the highest production budget.

budget_oscars
# ![](figures/var4_figures/budget_oscars_plot.png)
# Fantasy genre has the highest production budget.

budget_critic + budget_audience + budget_imdb
# ![](figures/var4_figures/budget_ratings_plot.png)
# Weak positive associations for all graphs



### VAR5_OSCAR_ANALYSIS
genre_oscar_wins + script_type_oscar_wins
# ![](figures/var5_figures/oscars_genre_script_type_plot.png)
#

oscar_win_ww_gross
# ![](figures/var5_figures/oscar_win_ww_gross_plot.png)
# Movies that have won at least one Oscar have a higher average ww gross.

plot
# ![](figures/var5_figures/_plot.png)
#

plot
# ![](figures/var5_figures/_plot.png)
#

plot
# ![](figures/var5_figures/_plot.png)
#





### VAR6_SEASONS_ANALYSIS
seasonal_critics_plot + seasonal_audience_plot
# ![](figures/var6_figures/seasonal_ratings_plot.png)
# Same pattern for both rating groups: Both critic and audience rating groups gave the highest ratings for movies released in the Fall
# As Figure 1 revealed, the audience rating group gives higher ratings for these Hollywood movies than the critic rating group.

seasonal_opening_wknd_plot
# ![](figures/var6_figures/seasonal_opening_wknd_plot.png)
# Highest mean opening weekend revenue for movies released in the Spring

seasonal_gross_plot
# ![](figures/var6_figures/seasonal_gross_plot.png)
# Highest worldwide gross for movies released in the Summer. Perhaps this is due to the fact that in many countries around the world, kids are on summer vacation, and thus are more likely to go to the movies.

seasonal_budget_plot
# ![](figures/var6_figures/seasonal_budget_plot.png)
# Highest budgets for movies released in the Spring, directly aligns with previous findings.

seasonal_oscar_plot
# ![](figures/var6_figures/seasonal_oscar_plot.png)
# Highest number of Oscar wins for movies released in the Fall, makes sense with past trends-- movies released later in the year are more likely to win an oscar.



# ADDITIONAL EXPLORATIONS
primary_genre_script_type_plot
# ![](figures/extra_explos_figures/primary_genre_script_type_plot.png)


# ![](figures/extra_explos_figures/seasonal_movie_count_table.png)


# 
# 
# 
# ### FROM PROGRESS MEMO 2:
# # UNIVARIATE
# ## Exploration 1: How does the overall average opening weekend earning change over the years from 2007-2022?
# year_opening_success |> 
#   DT::datatable()
# # ![](figures/avg_opening_wknd_earnings_yearly_table.png)
# ggplot(year_opening_success, aes(x = year, y = mean_opening_success)) +
#   geom_line() +
#   geom_point() +
#   labs(x = "Year", y = "Mean Opening Weekend Earnings (in millions)", title = "Average Opening Weekend Earnings for Hollywood Movies from 2007-2022") +
#   ylim(0, 28)
# # ![](figures/avg_opening_wknd_earnings_yearly.png)
# # These visualizations represent the change in the mean opening weekend earnings (in millions) for Hollywood movies from 2007-2008. As can be seen by the graph, the years with the most successful opening weekends in terms of mean earnings are the years 2012 and 2014, closely tied with an average earning of 27 million dollars. The lowest point on the graph corresponds to 2020, with that year earning the least during opening weekend: 8 million dollars. This data definitely reflects the times/economy of the country during this year, as 2020 was the year that America was under quarantine and movie theaters were shut down.
# 
# ## Exploration 2: How do the overall average rotten tomato critic ratings change over the years from 2007-2022?
# ggplot(yearly_rt_critic_rating, aes(x = year, y = mean_rt_rating)) +
#   geom_line() +
#   geom_point() +
#   labs(x = "Year", y = "Rotten Tomatoes Critic Ratings", title = "Average Rotten Tomatoes Critic Ratings for Hollywood Movies from 2007-2022") 
# # ![](figures/yearly_rt_critic_rating_plot.png)
# #A Rotten Tomatoes score is one of the most trusted recommendation resources for movie entertainment and represents the percentage of professional critic reviews that are positive. If at least 60% of reviews for a movie are positive, then the movie is considered "Fresh", and if less than 60% of reviews are positive, then the title is considered "Rotten". This graph represents the change in the average Rotten Tomatoes critic ratings for Hollywood movies for each year from 2007-2022. Overall, it seems that the average critic ratings have increased significantly over the years, with about a 30% increase in ratings from 2007 to 2022.
# 
# ## Exploration 3: How do the overall average metacritic critic ratings change over the years from 2007-2022?
# ggplot(yearly_mc_critic_rating, aes(x = year, y = mean_mc_rating)) +
#   geom_line() +
#   geom_point() +
#   labs(x = "Year", y = "Metacritic Critic Ratings", title = "Average Metacritic Critic Ratings for Hollywood Movies from 2007-2022") 
# # ![](figures/yearly_mc_critic_rating_plot.png)
# # A Metacritic "Metascore" is curated from a weighted average of critic reviews from a scale of 1-100. This graph represents the change in the average Metacritic critic ratings for Hollywood movies for each year from 2007-2022. Like the previous Rotten Tomatoes critic rating plot, this data also seems to have followed the trend of critic ratings increasing over the years, but this increase is less dramatic with it being only 20%. Also, both the Rotten Tomatoes critic and Metacritic rating plots seem to follow similar trends of increase, decrease, and peaks, such as ratings increasing significantly from 2009-2012, and dropping significantly from 2019-2020.
# 
# ### Exploration 4: How do the overall movie budgets change over the years from 2007-2022?
# ggplot(yearly_movie_budget, aes(x = year, y = mean_movie_budget)) +
#   geom_line() +
#   geom_point() +
#   labs(x = "Year", 
#        y = "Moviet Budget (millions)", 
#        title = "Average Budgets in Millions for Hollywood Movies from 2007-2022") 
# # ![](figures/yearly_movie_budget_plot.png)
# 
# 
# ## Exploration 5: What is the distribution of script type?
# ggplot(script_type_dist, aes(x = script_type)) +
#   geom_bar() +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   labs(x = "Script Type",
#        y = "Count",
#        title = "Distribution of Movie Script Type")
# # ![](figures/script_type_dist_plot.png)
# 
# ## Exploration 6: What is the distribution of average critic ratings?
# movie_data |> 
#   ggplot(aes(x = average_critics)) +
#   geom_histogram(binwidth = 4) +
#   labs(x = "Average Rotten Tomatoes and Metacritic Critic Rating",
#        y = "Count",
#        title = "Distribution of Average Rotten Tomatoes and Metacritic Critic Rating")
# # ![](figures/avg_critic_rating_plot.png)
# 
# 
# 
# # BIVARIATE
# ### Exploration 1: Which genre has the highest mean opening weekend earning? 
# genre_opening_success
# # ![](figures/genre_opening_success_mean.png)
# # As shown in the table, the "sci-fi & fantasy" genre combination had the most success in terms of highest opening weekend earnings, with about 248 million dollars in earnings.
# 
# ### Exploration 2: Which genre has the highest Oscar wins?
# genre_oscar_counts
# # ![](figures/genre_oscar_counts_table.png)
# # In terms of Oscar win success, the "biography & history" genre was the most successful as this genre combination earned the most amount of Oscars.
# 
# ### Exploration 3: Which script type has the highest mean opening weekend earning? 
# scripttype_opening_success
# # ![](figures/script_type_opening_success_table.png)
# # The script type combination that had the most successful opening weekend is "sequel & adaptation", with a mean opening weekend earning of about 84 million dollars.
# 
# ### Exploration 4: Which script type has the highest Oscar wins?
# scripttype_oscar_counts
# # ![](figures/script_type_oscar_counts_table.png)
# # The script type that earned the most Oscars is "original screenplay", with 28 Oscar wins.
# 
# ### Exploration 5: Do movies that have won Oscars have better Rotten Tomatoes critic ratings?
# rt_rating_oscar
# # ![](figures/rt_rating_oscar_table.png)
# # The table shows that movies that have won an Oscar have a much higher average Rotten Tomatoes critic rating than those who have not won an Oscar (89 vs. 54).
# 
# 
# ### Exploration 6: How do the various critic ratings correlate with opening weekend success?
# rt_critic_success_cor
# # ![](figures/rt_critic_success_cor_plot.png)
# rt_audience_success_cor
# # ![](figures/rt_audience_success_cor_plot.png)
# mc_critic_success_cor
# # ![](figures/mc_critic_success_cor_plot.png)
# mc_audience_success_cor
# # ![](figures/mc_audience_success_cor_plot.png)


# ### Exploration 7: Which distributor has the highest IMDb rating?
# imdb_rating_by_dist
# # ![](figures/imdb_rating_by_distr_table.png)
# 
# 
# ### Exploration 8: What is the correlation between a movie's budget and opening weekend success?
# movie_data |> 
#   ggplot(aes(x = budget_million, y = opening_weekend_million)) +
#   geom_point() +
#   geom_smooth(method = "lm") +
#   labs(x = "Movie Budget (millions)",
#        y = "Opening Weekend Earnings (millions)",
#        title = "Opening Weekend Earnings by Movie Budget (millions)",
#        subtitle = "There is an overall positive association between a movie's budget and it's opening weekend earnings.")
# # ![](figures/opening_weekend_by_budget_plot.png)
# 
# 
# 



