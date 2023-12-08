## Hollywood Hits and Flops: An EDA

This repository contains an analysis of data collected on 1,967 movies from 2007-2022 and their success rate variables. The purpose of the analysis is to investigate what factors contribute to the "success" of a movie, as defined in various ways such as the critic score, opening weekend revenue, and Oscar wins.

### What is in the Repo

-   `data/`: Here you can find the data set I will be working with throughout this EDA: "movie_data", a cleaned and joined version of the "Hollywood Hits and Flops" data set. You can also find the R scripts that contain the process for reading in, joining, and cleaning the raw data set, as well as the codebook for movie_data.

    -   `0a_data_collection.R`: This R file shows each of the 16 files in the "Hollywood Hits and Flops" data set being read in and assigned to their own variables.

    -   `0b_data_cleaning.R`: Here, the process of cleaning the 16 data files, joining them into one data set ("movie_data"), and carrying out more post-join cleaning is shown.

    -   `codebook_creation.R`: In this R file, I create the codebook for my variables.

        -   Inside the `raw/` folder, you can find the original "Hollywood Hits and Flops" data set in its raw form of 16 separate files.
        

-   `figures/`: Separated into seven subfolders for each of my six variable analyses and extra explorations, this folder contains pngs of all of the plots and tables used in my EDA.
    -   `polishing_figures_tables.R`: This R file contains the png codes for plots and tables from my analyses, as well as their explanations.

    -   `extra_explos_figures/`: Plots and tables for the extra explorations.
    
    -   `var1_figures/`: Plots and tables for the ratings variable analysis.
    
    -   `var2_figures/`: Plots and tables for the opening weekend revenue variable analysis.
    
    -   `var3_figures/`: Plots and tables for the gross variable analysis.
    
    -   `var4_figures/`: Plots and tables for the budget/budget recovery variable analysis.
    
    -   `var5_figures/`: Plots and tables for the oscars variable analysis.
    
    -   `var6_figures/`: Plots and tables for the seasons analysis.
    
-   `Kim_Celena_final_report.qmd`: My complete final report, including the full EDA and explanations.
    
-   `Kim_Celena_executive_summary.qmd`: My complete executive summary for my EDA.

-   `memos/`: This folder contains my Progress Memos 1 and 2

    -   `Kim_Celena_progress_memo_1.qmd`: This memo is the first step in my project, in which I identified my data set and anticipated potential issues/next steps.
    
    -   `Kim_Celena_progress_memo_2_qmd`: This next memo demonstrates a start on my EDA through a cleaned/joined data set and initial uni/multivariate analyses.

-   `var_analyses/`: This folder contains separate R scripts for each of my six variable analyses, as well as an additional R script for extra explorations.

    -   `extra_exlp.R`: Here, I included extra explorations in addition to the 6 variable analyses, such as identifying the films with the highest mean budget, gross revenue, opening weekend, etc.

    -   `var1_ratings_analysis.R`: Uni/multivariate analyses of the various ratings/reviews variables in the data set.

    -   `var2_opening_weekend_analysis.R`: Uni/multivariate analyses of the opening weekend revenue variables.

    -   `var3_gross_analysis.R`: Uni/multivariate analyses of the domestic, foreign, and worldwide gross variables.

    -   `var4_budget_recovery_analysis.R`: Uni/multivariate analyses of the various variables pertaining to a movie's budget.

    -   `var5_oscars_analysis.R`: Uni/multivariate analyses of the various variables pertaining to a movie's Oscar wins.

    -   `var6_seasons_analysis.R`: Uni/multivariate analyses of the trends of movie success by the season it was released in.