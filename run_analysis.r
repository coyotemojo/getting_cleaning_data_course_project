# load dplyr, useful library for data manipulation
library(dplyr)

#download the file
#file <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download.file(url = file, destfile = './project.zip', method='curl')

################################################################################
# Measurements
################################################################################
# read in variable names
features <- read.table('./UCI HAR Dataset/features.txt',
                       colClasses = c('NULL', 'character'),
                       col.names = c(NA, 'feature'))
# find only mean/std variables
vars_to_keep <- which(grepl('mean\\(\\)|std\\(\\)', features$feature))

# load the measurement data
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt')

# join X test and train
X_all <- rbind(X_test, X_train)

# keep only mean/std columns
X_all_specified_cols <- X_all[,vars_to_keep]

# make column names a little more descriptive and r naming convention compliant
# NOTE: not expanding 'Gyro, 'Acc,' and 'Mag' since the resulting column names
# would be very long, and these are fairly clear anyway in my opinion
var_names_to_keep <- features$feature[vars_to_keep]
var_names_to_keep <- sub('\\(\\)', '', var_names_to_keep)
var_names_to_keep <- sub('^t', 'time', var_names_to_keep)
var_names_to_keep <- sub('^f', 'frequency', var_names_to_keep)
var_names_to_keep

colnames(X_all_specified_cols) <- var_names_to_keep

################################################################################
# Activity
################################################################################
# load activities id to description map
activities <- read.table('./UCI HAR Dataset/activity_labels.txt',
                         colClasses = c('numeric', 'character'),
                         col.names = c('id','activity'))

# load the label ids
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt',
                     col.names='id')
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt',
                      col.names='id')

# combine activity ids, in the same order as combined measurements above
y_all <- rbind(y_test, y_train)

# join activity ids to meaningful activity labels
y_all_descriptive <- inner_join(y_all, activities, by='id')

################################################################################
# Subject IDs
################################################################################
# load the subject ids
id_test <- read.table('./UCI HAR Dataset/test/subject_test.txt',
                      col.names='subject_id')
id_train <- read.table('./UCI HAR Dataset/train/subject_train.txt',
                       col.names='subject_id')

# combine subhect ids, in the same order as combined measurements above
subject_id_all <- rbind(id_test, id_train)

################################################################################
# Combine All
################################################################################

all_df <- cbind(subject_id_all, X_all_specified_cols, activity=y_all_descriptive$activity)

################################################################################
# aggregate, summarize, save as file
################################################################################
tidy_all <- group_by(all_df, subject_id, activity) %>%
    summarise_each(funs(mean)) %>%
    as.data.frame()

write.table(tidy_all, file = './tidy_summary_of_UCI_HAR_Dataset.txt')

