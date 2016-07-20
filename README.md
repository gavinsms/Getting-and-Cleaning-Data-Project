# Getting-and-Cleaning-Data-Project

This script loads and merges data from a UCI experiment on various signals associated with subjects doing certain actitivties while wearing a Samsung smartphone. 

More info on the study can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script merges the test and training sets (keeping these parts of the resulting merged data set appropriately labeled), and averages each of the mean and standard deviation measurements based on subject and activity. Thus, a given line has the average mean and standard deviation for each measurement associated with a certain subject while doing a certain activity.
Ultimately, the script exports a file 'UCI Grouped Means Data.txt' that contains this grouped means data set.
