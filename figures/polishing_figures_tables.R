# Github link:
# https://github.com/stat301-1-2023-fall/final-project-1-celenakim

### VAR1_RATINGS_ANALYSIS
ratings_yearly_plot
# ![](figures/var1_figures/ratings_yearly_plot.png)
# Average ratings for both groups increased over the years, critics rate lower than audiences.

critic_ratings_oscar
# ![](figures/var1_figures/critic_ratings_oscar_plot.png)
# Movies who have won at least one Oscar have a higher mean rt critic rating than those who have not won any Oscars.

rating_rt_critcs_opening_wknd
# ![](figures/var1_figures/rating_rt_critcs_opening_wknd_plot.png)
# Movies who have won at least one Oscar have a higher mean.

ratings_script_type_plot
# ![](figures/var1_figures/ratings_script_type_plot.png)
# A majority of script types do not have information available for the IMDb rating.

ratings_deviance_genre
# ![](figures/var1_figures/ratings_deviance_genre_plot.png)
# Lowest difference for biography, largest for sci-fi.

rt_metacritic_deviance_genre
# ![](figures/var1_figures/rt_metacritic_deviance_genre_plot.png)
# Opposite results from previous plot.

critic_rating_dom_gross_genre + aud_rating_dom_gross_genre 
# ![](figures/var1_figures/critic_vs_aud_dom_gross_plot.png)
# Action has steepest correlation in both graphs, but steeper for audience graph.

critic_ratings_distributor + aud_ratings_distributor
# ![](figures/var1_figures/critic_vs_aud_distr_plot.png)
# A24 has highest critic ratings, atlas has highest aud ratings.

critic_pcnt_abroad + aud_pcnt_abroad
# ![](figures/var1_figures/critic_vs_aud_abroad_plot.png)
# No correlation


### VAR2_OPENING_WEEKEND_REV_ANALYSIS
opening_wknd_yearly
# ![](figures/var2_figures/opening_wknd_yearly_plot.png)
# The opening weekend rev for 2020 is highly impacted by the pandemic, 2008 by the great recession.

opening_wknd_budget_rcvry_script_type
# ![](figures/var2_figures/budget_rcvry_opening_wknd_plot.png)
# There is a very strong positive association between the two variables. For movie genres, adventure has the steepest correlation, for script type remake has the steepest correlation.

genre_opening_wknd_plot + scripttype_opening_wknd_plot
# ![](figures/var2_figures/opening_wknd_genre_script_plot.png)
# Top 5 opening weekend revenues by genre and script type.

opening_wknd_oscar
# ![](figures/var2_figures/opening_wknd_oscar_plot.png)
# Movies who have won oscars have a lower average opening weekend revenue.

opening_wknd_domgross + opening_wknd_forgross
# ![](figures/var2_figures/opening_wknd_dom_for_plot.png)
# Both plots have strong positive associations, very close to a correlation value of 1. 
# However, the line is steeper for domestic gross, indicating a stronger/more positive correlation.

distr_opening_wknd
# ![](figures/var2_figures/distr_opening_wknd_plot.png)
# Walt Disney Studios is the most successful.

rt_audience_by_opening_wknd
# ![](figures/var2_figures/rt_audience_by_opening_wknd_plot.png)
# Positive relationship


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

gross_domestic_script_type + gross_foreign_script_type
# ![](figures/var3_figures/gross_script_type_plot.png)
# Sequel, adaptation is the most successful among both audiences.

dom_gross_distributor + for_gross_distributor
# ![](figures/var3_figures/gross_distributor_plot.png)
# Walt Disney Studios has the most successful gross performance for both domestic and foreign.

ww_gross_budget_rcvry
# ![](figures/var3_figures/ww_gross_budget_rcvry_plot.png)
# There is an overall positive association between a movie's ww gross performance and budget recovery percentage 

genre_prcnt_earned_abroad
# ![](figures/var3_figures/genre_prcnt_earned_abroad_plot.png)
# Sci-fi category has the highest proportion of its earnings from abroad audiences.

script_type_prcnt_earned_abroad
# ![](figures/var3_figures/script_type_prcnt_earned_abroad_plot.png)
# Based on a true story, remake hybrid has highest proportion of its earnings from abroad audiences.


### VAR4_BUDGET_ANALYSIS
budget_yearly
# ![](figures/var4_figures/budget_yearly_plot.png)
# Same pattern, 2020 is highly impacted by the pandemic, 2008 by great recession.

budget_opening_wknd + budget_ww_gross
# ![](figures/var4_figures/budget_opening_wknd_ww_gross_plot.png)
# There is a direct positive association.

budget_by_genre
# ![](figures/var4_figures/budget_by_genre_plot.png)
# Fantasy genre has the highest production budget.

budget_by_script_type
# ![](figures/var4_figures/budget_by_script_type_plot.png)
# Sequel, adaptation script type has the highest production budget.

distr_budget
# ![](figures/var4_figures/distr_budget_plot.png)
# Walt Disney Studios has the highest budget.

budget_oscars
# ![](figures/var4_figures/budget_oscars_plot.png)
# Fantasy genre has the highest production budget.

budget_critic + budget_audience + budget_imdb
# ![](figures/var4_figures/budget_ratings_plot.png)
# Weak positive associations for all graphs


### VAR5_OSCAR_ANALYSIS
oscar_movie_titles
# ![](figures/var5_figures/oscar_movie_titles_plot.png)
# Everything Everywhere All at Once won the most Oscars

genre_oscar_wins + script_type_oscar_wins
# ![](figures/var5_figures/oscars_genre_script_type_plot.png)
# "Biography, history" genre has most Oscar wins, "Original screenplay" script type has most Oscar wins.

oscar_win_ww_gross
# ![](figures/var5_figures/oscar_win_ww_gross_plot.png)
# Movies that have won at least one Oscar have a higher average ww gross.

oscar_avg_critic_aud
# ![](figures/var5_figures/oscar_avg_critic_aud_plot.png)
# "Best Supporting Actress (Patricia Arquette)" has the highest critic rating, Best Picture, Best Director, Best Original Screenplay and Best International Feature Film" has the highest avg audience rating.

oscar_count_opening_wknd
# ![](figures/var5_figures/oscar_count_opening_wknd_plot.png)
# Movies with 6 Oscars have the highest average opening weekend revenue: "Mad Max: Fury Road"

oscar_count_dom_gross + oscar_count_for_gross
# ![](figures/var5_figures/oscar_count_opening_wknd_plot.png)
# Movies that have won 1 Oscar have both the highest average domestic and highest average foreign gross.


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

season_opening_wknd_by_budget
# ![](figures/var6_figures/seasonal_budget_plot.png)
# Steepest correlation for movies released in the Spring.

seasonal_oscar_plot
# ![](figures/var6_figures/seasonal_oscar_plot.png)
# Highest number of Oscar wins for movies released in the Fall, makes sense with past trends-- movies released later in the year are more likely to win an oscar.

seasonal_genre_plot
# ![](figures/var6_figures/seasonal_genre_plot.png)
# The action genre is the most prevalent across all seasons except Fall.

seasonal_script_type_plot
# ![](figures/var6_figures/seasonal_script_type_plot.png)
# The original screenplay script type is the most prevalent across all seasons.


# ADDITIONAL EXPLORATIONS
primary_genre_script_type_plot
# ![](figures/extra_explos_figures/primary_genre_script_type_plot.png)

genre_trends
# ![](figures/extra_explos_figures/genre_trends_plot.png)

highest_critic_rating
# ![](figures/extra_explos_figures/highest_critic_rating_table.png)

highest_audience_rating
# ![](figures/extra_explos_figures/highest_audience_rating_table.png)

highest_opening_wknd
# ![](figures/extra_explos_figures/highest_opening_wknd_table.png)

highest_dom_gross
# ![](figures/extra_explos_figures/highest_dom_gross_table.png)

highest_for_gross
# ![](figures/extra_explos_figures/highest_for_gross_table.png)

highest_ww_gross
# ![](figures/extra_explos_figures/highest_ww_gross_table.png)

highest_earned_abroad
# ![](figures/extra_explos_figures/highest_earned_abroad_table.png)

highest_budget
# ![](figures/extra_explos_figures/highest_budget_table.png)

highest_budget_recovered
# ![](figures/extra_explos_figures/highest_budget_recovered_table.png)

highest_oscar_wins
# ![](figures/extra_explos_figures/highest_oscar_wins_table.png)
