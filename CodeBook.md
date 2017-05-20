# Project Title: Getting and Cleaning Data Course Project

Getting and Cleaning Data Course Project by Jay Sabido
Date: May 20, 2017

Course project based on the Human Activity Recognition Using Smartphones Dataset, Version 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita,Alessandro Ghio, Luca Oneto.

License:
Use of this dataset in publications must be acknowledged by referencing the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

URL for the dataset used in this project is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, retrieved last May 15, 2017.

# About the "raw" data set

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data Set Characteristics:  Multivariate, Time-Series
Number of Instances: 10299
Area: Computer
Attribute Characteristics: N/A
Number of Attributes: 561
Date Donated: 2012-12-10
Associated Tasks: Classification, Clustering
Missing Values? N/A

Source:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones; retrieved May 15, 2017:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six (6) activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

# The processing done on the "raw" data by the R script run_analysis.R

The script does the following per the project assignment requirement as stated in this URL: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project:

0. Reads the text files

Since all the data files are in .txt format, R function used for reading is read.table()
- 'features.txt': List of all features. This list will be used for to generate the variable names in the tidy data set.
- 'activity_labels.txt': Links the class labels with their activity name. Used in step 3. 6 activities total. This file maps the activity label with one of six activity names.
- 'train/X_train.txt': Training set. 21 subjects, 6 activities, numerous repititions measuring 561 variables
- 'train/y_train.txt': Training labels. Activity labels for the 'train/X_train.txt' file.
- 'test/X_test.txt': Test set. 9 subjects, 6 activities, numerous repititions measuring 561 variables
- 'test/y_test.txt': Test labels. Activity labels for the 'test/X_test.txt' file.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

1. Merges the training and the test sets to create one data set.

Combined using rbind(). Combined data frame is all_subjects
Then the data frame is made into a tibble for the dplyr package, for easier data manipulation.
Data is then arranged by subject and then by activity per subject using the arrange() function in the dplyr package.

subject column values: 1:30. This is essentially the person ID; 1 out of 30. This is the first column of the processed data frame.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

I chose to include all measurements with mean() and std().
I also included meanFreq() since meanFreq() is the "Weighted average of the frequency components to obtain a mean frequency"
In addition, I included these since they were obtained by "averaging the signals in a signal window sample. These are used on the angle() variable: 
                    gravityMean
                    tBodyAccMean
                    tBodyAccJerkMean
                    tBodyGyroMean
                    tBodyGyroJerkMean
Source for the quoted text is the features_info.txt file of the UCI HAR Dataset

3. Uses descriptive activity names to name the activities in the data set

Descriptive activity names are from the activity_labels.txt file
I renamed the column name of the short_df data frame and the activity_labels to "activitycode" to facilitate joining or using a lookup table approach.

activitycode values: 1:6. This is the second column of the processed data frame.

The activities are as follows:
                    walking
                    walking_upstairs
                    walking_downstairs
                    sitting
                    standing
                    laying
The activity listing is the third column of the processed data frame.

4. Appropriately labels the data set with descriptive variable names.

This applies to the 4th to the 89th column of the processed and tidy data set.

The grepl() and paste0() functions were used to create these labels from the features.txt labels. The new labels were made more readable. Spaces and special characters were removed. I couldn't avoid using capital letters since the labels were quite long since there were too many "words" to paste together to form the new label. Capital letters were used to make the labels more readable.

Mapping:
- angle(): Angle between the following two vectors:
                    gravityMean
                    tBodyAccMean
                    tBodyAccJerkMean
                    tBodyGyroMean
                    tBodyGyroJerkMean
                    X
                    Y
                    Z

- Starts with 't' or 'f': this corresponds to either time ('Time') or frequency ('Freq') domain
- Either 'meanFreq', 'mean()' or 'std()', mapped to 'MeanFreq', 'Mean' or 'StdDev'; where Stddev is standard deviation
- Either 'Body' or 'Gravity': The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration ('Body') and gravity ('Gravity'). The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2). But all features were normalized and bounded within [-1,1]. 
- If Body motion, further classified as:
    * Jerk: both the body linear acceleration and angular velocity were derived in time to obtain Jerk signals
    * Acc: corresponds to linear acceleration. The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2). But all features were normalized and bounded within [-1,1]. 
    * Gyro: corresponds to angular velocity. The gyroscope units are rad/seg. But all features were normalized and bounded within [-1,1]. 
    * Finally, either 'Mag', 'X', 'Y' or 'Z'.
    Mag: the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
    X: in the X-axis
    Y: in the Y-axis
    Z: in the Z-axis

The list of new labels are in the header2 vector.


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The 10,299 rows of observations were grouped by subject and activity (30 subjects x 6 activities per subject = 180 groups). For each group and one of 86 variables, the mean was calculated using the summarise_each() function from the dplyr package. The resulting data table has 180 rows and 89 columns (subject, activitycode, activity, 86 variables). The resulting data set (answer_df) is tidy.