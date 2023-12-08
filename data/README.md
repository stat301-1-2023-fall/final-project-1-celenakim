## The "movie_data" dataset, from Hollywood Hits and Flops (2007-2023) on Kaggle

The data source that I chose for my project is called [Hollywood Hits and Flops (2007 - 2023)](https://www.kaggle.com/datasets/sujaykapadnis/hollywood-hits-and-flops-2007-2023/) found on [Kaggle](https://www.kaggle.com), created by David McCandless. 

- `movie_data.csv`
- `movie_data_codebook.csv` 

The original data set consisted of 16 separate files to represent the 16 years from 2007-2022, but I cleaned and joined them all to create one main data set to work with for my project: "movie_data". This data set contains 33 variables of information on 1,967 movies from 2007-2022, such as their critic ratings, genre, opening weekend revenue, foreign and worldwide gross, IMDb ratings, Oscar wins, etc. All of these variables represent details that contribute to the success rate of each movie.

This new data set, "movie_data", differs from the original data files as the variable names are now in snake case form, variable types were changed when necessary for the analysis, the observations of the "oscar winner" variable were changed to either display true or false to denote an oscar win, original variables whose columns solely consisted of NAs were removed, NAs in the "Genre" variable were replaced with observations from the "Primary Genre" variable, NAs in the "worldwide gross revenue" variable were replaced with the sum of the domestic and foreign gross revenues, incorrect conversions for values to "millions" were fixed, a new variable called "season" was created to represent the season that each movie was released in based on the release date variable, a new variable called "oscar count" was created to represent the number of Oscars that a movie won, and variable names were made uniform ("Genre" vs. "Genres"). A more detailed account of this data cleaning process can be found in the "Final Report" under "Appendix: technical info about the data joining/clean-up process" section.
