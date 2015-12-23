Getting and Cleaning Data Course Project - CodeBook
==============================

| **Name**  | Jason Ament |
|----------:|:-------------|
| **Email** | jason.ament@gmail.com |

## Variable Description ##

The "run_analysis.r" script produces a tidy text file with columns described below:

- subject_id - the unique identifer of each study participant
- activity - the participant's action when the data was collected. Is one of "LAYING," "SITTING," "STANDING," "WALKING," "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS." 
- 66 measurement columns:
    - The original 561 column names are defined in the "features_info.txt" file that is unpacked when the data is unzipped
    - As instructed, I kept only the 66 columns with "mean()" or std()" in their name
    - I removed the parentheses in the variable names so that the names would be R-compliant column names
    - I expanded the "t" for variables that started with "t" to "time" to better convey the time-based essence of the variable
    - I expanded the "f" for variables that started with "f" to "frequency" to better convey the frequency-count essence of the variable
    - I left "Acc," "Gyro", and "Mag" as is as the "features_info.txt" explains the meaning of these variables with no ambiguity
- Values - the values for each measurement are the mean values for all of the 66 measurements for each participant during each activity.  So there are 6 observations (one for each activity) for each of the 30 participants.  The raw measurements prior to aggregation were all normalized values within the [-1,1] closed interval. 
