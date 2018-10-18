# cleaningDataAssignment

The project is for the final project for Coursera's 'Getting and Cleaning Data'. 

## What this repo contains 
* codebook.txt  
This text file describes the vairables contained in the dataset after the 'run_analysis.R' file is executed on the dataset avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

* run_analysis.R  
This R file contains the script to carry-out the tasks for this assignment.

## Analysis path in brief: 

## 1. Create one tidy dataset 
This step required many subparts that are listed below. 

### a. Create dataframe for 'test' data

* 'Test' data was read into R, by first reading in the dataframes for 'subjects', 'X-test', and 'Y-test'.
* 'X-test' variables were renamed to descriptive variable names provided in 'features.txt'.

### b. Create dataframe for 'train' data
* 'Train' data was read into R, by first reading in the dataframes for 'subjects', 'X-train', and 'Y-train'.
* 'X-train' variables were renamed to descriptive variable names provided in 'features.txt'.

### c. Both datasets were combined using cbind (LEFT OUTER JOIN) on 'subject'

## 2. Cleaning the dataset 
* Only variables containing mean and standard deviations of measurements were kept. 
* Variables were renamed to more descriptive names. Please refer to 'codebook.txt', which is a part of this repo. 

## 3. Create a new tidy dataset
* Mean of every subject for every activity was calculated and created in a new dataset. 


