Code book for coursera getting and cleaning data assignment week 4

The README.md file contains text explaining the analysis of the data.
The run_analysis.R file contains the code to run the analysis.
The tidy_data.txt file contain the final output file.


The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The analysis performs the following steps:
1. Downloads zipped file and unzips the files
2. Lists all file
3. reads in the files using the read.table function
4. Assigns column names
5. Merges different data sets
6. Adds descriptive names for variables
7. Groups by subjects and calculates the mean
8. Write the final tidy_data.txt file
