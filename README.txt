##This is the Getting and Gleaning Course Project

This script takes the "Human Activity Recognition Using Smartphones Data Set"  from the "Center for Machine Learning and Intelligent Systems"
and does the following:


- combines the test and train data
- selects the variables of interest i.e. Subject, Activity and the mean and standard deviation of all the variables
- makes the data easier to read
- creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Directions:
- To run this all you need to do is download the data into your working directory and unzip it.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
- Copy "run_analysis.R" into your working directory and then use source(run_analysis.R) in RStudio
- This will create the TidyOutputData file which can be easily read back into R using 
TidyOutputData<-read.table("TidyOutputData",header = TRUE)
or similar.