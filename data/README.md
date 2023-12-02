## The "movie_data" dataset, from Hollywood Hits and Flops (2007-2023) on Kaggle

The data source that I chose for my project is called [Hollywood Hits and Flops (2007 - 2023)](https://www.kaggle.com/datasets/sujaykapadnis/hollywood-hits-and-flops-2007-2023/) found on [Kaggle](https://www.kaggle.com), uploaded by Sujay Kapadnis. 

- `movie_data.csv`
- `movie_data_codebook.csv` 

The original data set consisted of 16 separate files to represent the 16 years from 2007-2022, but I cleaned and joined them all to create one main data set to work with for my project: "movie_data". This data set contains 33 variables of information on 1,967 movies from 2007-2022, such as their critic ratings, genre, opening weekend revenue, foreign and worldwide gross, IMDb ratings, Oscar wins, etc. All of these variables represent details that contribute to the success rate of each movie.

This new data set, "movie_data", differs from the original data files as the variable names are now in snake case form, variable types were changed from character to integer, original variables whose columns just consisted of NAs were removed, NAs in the "Genre" variable were replaced with observations from the "Primary Genre" variable, incorrect conversions for values to "millions" were fixed, a new variable called "season" was created to represent the season that each movie was released in based on the release date variable, and variable names were made uniform ("Genre" vs. "Genres").
