#Getting and Cleaning Data - Course Project


In order for the script to run, the original zip file containing the data should be in the current working directory, found originally at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script will unzip the data, perform the analysis, and output a file called 'data.txt', which contains a data frame with variables:

	* subject_id: the id number of the subject (person) on which the experiment was performed

	* activity: factor variable with the activity the subject was performing when the measurement was taken

	* variable: measurement name

	* mean: the mean value of that measurement for the subject and activity