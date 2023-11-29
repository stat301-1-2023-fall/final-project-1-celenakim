## Hollywood Hits and Flops: An EDA

This repository contains an analysis of data collected on 1,967 movies from 2007-2022 and their success rate variables. The purpose of the analysis is to investigate what factors contribute to the "success" of a movie, as defined in various ways such as the critic score, opening weekend revenue, and Oscar wins.

## What is in the Repo
Here is a brief overview of what you can find in the repo:

- `data/`: Here you can find the data set I will be working with throughout this EDA: "movie_data", a cleaned and joined version of the "Hollywood Hits and Flops" data set. Inside the `raw/` folder, you can find the original "Hollywood Hits and Flops" data set in its raw form of 16 separate files.
- `figure/`: This folder contains pngs of all of the plots and tables used for my analysis.


## R scripts

- `0a_data_collection.R`: This R file shows each of the 16 files in the "Hollywood Hits and Flops" data set being read in and assigned to their own variables.
- `0b_data_cleaning.R`: Here, the process of cleaning the 16 data files, joining them into one data set ("movie_data"), and carrying out more post-join cleaning is shown.
- `1_univariate_analysis.R`: All of my univariate analyses can be found in this R file.
- `2_multivariate_analysis.R`: All of my multivariate analyses can be found in this R file.
- `3_polishing_figures_tables.R`: This R file contains the png code and explanations for all of my univariate and multivariate tables and plots.


## Project Memos
- `Kim_Celena_progress_memo_1.qmd`: This memo is the first step in my project, in which I identified my data set and anticipated potential issues/next steps.
- `Kim_Celena_progress_memo_1_qmd`: This next memo demonstrates a start on my EDA through a cleaned/joined data set and initial uni/multivariate analyses.
