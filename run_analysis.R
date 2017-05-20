## Getting and Cleaning Data Course Project by Jay Sabido

# dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(dataset_url, "HARdata.zip")     # even though the URL of the source file is https, no method = "curl"in the arguments since I am using a Windows machine
# dateDownloaded <- date()
# unzip("HARdata.zip", exdir = getwd())

library("dplyr")
library("plyr")
library("reshape2")

# Requirement 0: Read all the files in the dataset. Since all the data files are in .txt format, R function used for reading is read.table()

setwd("./UCI HAR Dataset")

activity_labels <- read.table("./activity_labels.txt")     # Legend of 6 activities
features <- read.table("./features.txt")     # 561 features measured or computed


# Read the test files - 30% of the subjects = 0.3 * 30 = 9 subjects
        
setwd("./test")
subject_test <- read.table("./subject_test.txt")     # Listing of the persons per row == 'data.frame':	2947 obs. of  1 variable
subject_test <- dplyr::rename(subject_test, subject = V1)

x_test <- read.table("./X_test.txt")     # 1 of 9 subjects/persons + 1 of 6 activities VS. One of 561 features == 'data.frame':	2947 obs. of  561 variables
# colnames(x_test) <- features$V2

y_test <- read.table("./y_test.txt")     # 'data.frame':	2947 obs. of  1 variable
y_test <- dplyr::rename(y_test, activity = V1)

# Combine Subject + Activity + Data
test_data <- cbind(subject_test, y_test, x_test)     # 'data.frame':	2947 obs. of  563 variables

setwd("./Inertial Signals")
body_acc_x_test <- read.table("./body_acc_x_test.txt")     # 'data.frame':	2947 obs. of  128 variables
body_acc_y_test <- read.table("./body_acc_y_test.txt")
body_acc_z_test <- read.table("./body_acc_z_test.txt")

body_gyro_x_test <- read.table("./body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./body_gyro_z_test.txt")

total_acc_x_test <- read.table("./total_acc_x_test.txt")
total_acc_y_test <- read.table("./total_acc_y_test.txt")
total_acc_z_test <- read.table("./total_acc_z_test.txt")

# What are these 128 variables in the above intertial signals?

setwd("..")
setwd("..")

# Read the train files - 70% of the subjects = 0.7 * 30 = 21 subjects

setwd("./train")
subject_train <- read.table("./subject_train.txt")     # 'data.frame':	7352 obs. of  1 variable
subject_train <- dplyr::rename(subject_train, subject = V1)

x_train <- read.table("./X_train.txt")     # 1 of 21 subjects/persons + 1 of 6 activities VS. One of 561 features == 'data.frame':	7352 obs. of  561 variables
# colnames(x_train) <- features$V2

y_train <- read.table("./y_train.txt")     # 'data.frame':	7352 obs. of  1 variable
y_train <- dplyr::rename(y_train, activity = V1)

# Combine Subject + Activity + Data
train_data <- cbind(subject_train, y_train, x_train)     # 'data.frame':	7352 obs. of  563 variables

setwd("./Inertial Signals")
body_acc_x_train <- read.table("./body_acc_x_train.txt")     # 'data.frame':	7352 obs. of  128 variables
body_acc_y_train <- read.table("./body_acc_y_train.txt")
body_acc_z_train <- read.table("./body_acc_z_train.txt")

body_gyro_x_train <- read.table("./body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./body_gyro_z_train.txt")

total_acc_x_train <- read.table("./total_acc_x_train.txt")
total_acc_y_train <- read.table("./total_acc_y_train.txt")
total_acc_z_train <- read.table("./total_acc_z_train.txt")

# What are these 128 variables in the above intertial signals?


setwd("..")
setwd("..")
setwd("..")

# Done reading

# Requirement 1: Merge the training and the test sets to create one data set.
# Combine train + test data

all_subjects <- rbind(test_data, train_data)
all_subjects_df <- tbl_df(all_subjects)

all_subjects_df <- arrange(all_subjects_df, subject, activity)

features$V2 <- as.character(features$V2)
features2 <- rbind(c(1, "subject"), c(2, "activitycode"), features)
colnames(all_subjects_df) <- features2$V2

# Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# I chose to include all measurements with mean() and std().
# I also included meanFreq() since meanFreq() is the "Weighted average of the frequency components to obtain a mean frequency"
# In addition, I included these since they were obtained by "averaging the signals in a signal window sample. These are used on the angle() variable:
        
#                    gravityMean
#                    tBodyAccMean
#                    tBodyAccJerkMean
#                    tBodyGyroMean
#                    tBodyGyroJerkMean

# Source for the quoted text is the features_info.txt file of the UCI HAR Dataset

short_df <- all_subjects_df[ , c(1, 2, grep( "[Mm]ean|std", names(all_subjects_df)))]


# Requirement 3: Use descriptive activity names to name the activities in the data set

# Descriptive activity names are from the activity_labels.txt file
activity_labels <- dplyr::rename(activity_labels, activitycode = V1, activity = V2)     # to match the names of the short_df data frame
activity_labels$activity <- tolower(activity_labels$activity)     # convert to lowercase for easy manipulation

short_df <- join(short_df, activity_labels, by = "activitycode")
# reference for the above approach from Ben as he discussed in http://stackoverflow.com/questions/15303283/how-to-do-vlookup-and-fill-down-like-in-excel-in-r
# above approach uses the join() function from the plyr package

# need to rearrange the columns
short_df2 <- select(short_df, subject, activitycode, activity, everything())
# reference for the above approach from gjabel as discussed in http://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame
# above approach uses the everything() function from the dplyr package. See help(everything) for more information



# Requirement 4: Appropriately labels the data set with descriptive variable names.
# header <- features2$V2

header <- names(short_df2)
header2 <- names(short_df2)[1:3]     # initialize another vector with the first 3 variables

## For loop
for (i in 4:length(header)) {
        
        header_var <- ""
        
        if (grepl("^angle", header[i])) {
                header_var <- header[i]
        } else {
              
                if (grepl("^t", header[i])) {
                        header_var <- paste0(header_var, "Time")  
                } else if (grepl("^f", header[i])) {
                        header_var <- paste0(header_var, "Freq")
                } else stop("invalid outcome")
                
                if (grepl("meanFreq", header[i])) {
                        header_var <- paste0(header_var, "MeanFreq")
                } else if (grepl("[Mm]ean", header[i])) {
                        header_var <- paste0(header_var, "Mean")
                } else if (grepl("std", header[i])) {
                        header_var <- paste0(header_var, "Stddev") 
                } else stop("invalid outcome")
                
                if (grepl("Gravity", header[i])) {
                        header_var <- paste0(header_var, "GravityAcc")
                } else if (grepl("Body", header[i])) {
                        
                        if (grepl("Jerk", header[i])) {
                                header_var <- paste0(header_var, "Jerk")
                        }
                        
                        header_var <- paste0(header_var, "Body")
                        if (grepl("Acc", header[i])) {
                                header_var <- paste0(header_var, "Acc")
                        } else if (grepl("Gyro", header[i])) {
                                header_var <- paste0(header_var, "Gyro")
                        } else stop("invalid outcome")
                        
                } else stop("invalid outcome")
                
                
                if (grepl("Mag", header[i])) {
                        header_var <- paste0(header_var, "Mag")
                } else if (grepl("X$", header[i])) {
                        header_var <- paste0(header_var, "Xaxis")  
                } else if (grepl("Y$", header[i])) {
                        header_var <- paste0(header_var, "Yaxis")      
                } else if (grepl("Z$", header[i])) {
                        header_var <- paste0(header_var, "Zaxis")  
                } else stop("invalid outcome")     
              
        }
        header2 <- c(header2, header_var)
        
}

names(short_df2) <- header2      


# Requirement 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# From our week 1 lecture, tidy data has the following characteristics:
# 1. Each variable you measure should be in one column
# 2. Each different observation of that variable should be in a different row
# 3. There should be one table for each "kind" of variable
# 4. If you have multiple tables, they should include a column in the table that allows them to be linked. For example, an ID.


short_df2 %>%
        group_by(subject, activitycode, activity) %>%
        summarise_each(funs(mean(., na.rm = TRUE))) -> answer_df
# reference for the part of the above approach from Artem Klevtsov as he discussed in http://stackoverflow.com/questions/21644848/summarizing-multiple-columns-with-dplyr
# above approach uses the summarise_each() function from the dplyr package

# reference for the part of the above approach from Paulo E. Cardoso as he discussed in http://stackoverflow.com/questions/33152620/how-to-group-by-two-columns-in-r
# above approach uses the group_by() function from the dplyr package


# Submission

write.table(answer_df, "./Course3AssignTidyData.txt", row.name=FALSE)
