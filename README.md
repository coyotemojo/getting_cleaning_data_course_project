Coursera Geting and Cleaning Data: Course Project
==============================

| **Name**  | Jason Ament |
|----------:|:-------------|
| **Email** | jason.ament@gmail.com |

## Instructions ##

The following packages must be installed prior to running this code:

- `dplyr`

In addition, this project contaings a CodeBook.md file with some explanation of the variables in the resulting dataset.

To run this code, please enter the following commands in R:

```
library(devtools)
source_url("https://raw.githubusercontent.com/coyotemojo/getting_cleaning_data_course_project/master/run_analysis.r")
```

This file expects to find the data directory /UCI HAR Dataset/ in the current working directory.  This dataset is described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

You can download the .zip file of the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and unzip it in the currenct working directory to get the /UCI HAR Dataset directory.

The output of the script will be a locally saved file called tidy_summary_of_UCI_HAR_Dataset.txt, a file containing a tidy dataset with average measurements of a specified set of variables for each activity for each subject.  

## How it works ##
1.  First the script loads in the features.txt file and uses grepl() to get the indices of variables that have either mean() or std() in their names
2.  The script loads the X_test and X_train data and stacks the data using rbind.
3.  The script then subsets the combined dataframe using the indices of the 'columns to keep' found in step 1.
4.  The script does a few manipulations to the variable names to make them R-compliant column names and a little more descriptive
5.  The script assigns the cleaned up column names to the combined measurement dataframe
6.  Load the activity_labels id-to-descriptive label mapping file
7.  Load the y_test and y_train activity ids and stack them using rbind (in the same order as step 2 above!).
8.  Join the y data with the descriptive labels by joining on 'id'
9.  Load subject_test.txt and subject_train.txt files and stack them in the same order as steps 2 and 7.
10.  Create the overall dataframe by cbinding subject ids, activity labels, and all measurement data
11.  Use dplyr to group by subject id and activity and use summarise_each to calculate the mean value of all the measurement variables.
12.  Write the data out to a file.  Done!

## Discussion ##

The instructions for the project were to select "only the measurements on the mean and standard deviation for each measurement."  I took this to mean the 66 features that specifically had only "mean()" or "std()" in their names.  A case could be made to include columns with things like "meanFreq" but I decided not to include these.

Additionally, the instructions asked that the solution script "labels the data set with descriptive variable names."  I chose to remove the all parenteses (ie "(" and ")") from all variable names as well as to replace "t" with "time" and "f" with "frequency" in the variable names.  I decided against expanding "Acc" as "Acceleration," "Gyro" as "Gyroscopic," and "Mag" as "Magnitude" as I felt that the abbreviations were already clear enough given the "features_info.txt" explanatory file, and I thought the resulting expanded column names would be far too long to be useful.  

I also took the instructions around descriptive variable names to be more about not leaving the variables named something like "V1," "V2," etc. and less about fully expanding all of the abbreviations in the variable names.

