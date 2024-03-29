## Raw data

The data source that I chose for my project is called [Hollywood Hits and Flops (2007 - 2023)](https://www.kaggle.com/datasets/sujaykapadnis/hollywood-hits-and-flops-2007-2023/) by David McCandless found on [Kaggle](https://www.kaggle.com). This data set contains numerous details regarding the success rate of hundreds of movies from 2007-2022, such as each movie's Rotten Tomatoes score, audience size, genre, opening weekend revenue, Oscar wins, etc. In its raw form, there are 16 different CSV files, each containing movie data for each year from 2007-2023. While the content of the 16 files is mostly similar with relatively the same variables/columns, there are some slight differences between the files. For one, the data sets for 2007-2010 have 33 variables, 2011-2018 have 34 variables, and 2019-2022 have 35 variables. The 2007-2010 data sets are missing the variables "financial source, if not The numbers" and "film list here", and the 2011-2018 data sets are missing the "film list here" variable. However, for the data sets where these variables exist, there are NA values in every observation for these variable columns, so these extra variables do not seem to be necessary. Additionally, there are some slight variances in variable names between the data sets. For example, the variable that displays the genre of the movie is called "Genre" for data sets representing the years 2007-2018, while this same variable for the data sets representing the years 2019-2022 is called "Genres". Also, in general, none of the variables are in snake case form. Joining the 16 data sets appears to be necessary, and I anticipate a good amount of cleaning to be carried out.


