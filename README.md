# Project Title: Getting and Cleaning Data Course Project

Getting and Cleaning Data Course Project by Jay Sabido

Course project based on the Human Activity Recognition Using Smartphones Dataset, Version 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita,Alessandro Ghio, Luca Oneto.

Dataset reference is:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

URL for the dataset used in this project is Reference for the data set is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, retrieved last May 15, 2017.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

1. The Tidy Data
Please use the following code to read the Tidy Data text file I uploaded in the coursera website:

    address <- https://s3.amazonaws.com/coursera-uploads/peer-review/038aaaeeb35dd3856c98dd65dc149b31/Course3AssignTidyData.txt
    address <- sub("^https", "http", address)
    data <- read.table(url(address), header = TRUE) 
    View(data)

Above code from: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ written by David Hood, retrieved on May 20, 2017.

The R script is in the run_analysis.R file. Please make sure you have the UCI HAR Dataset folder in your R working directory. The script assumes that your working directory contains that UCI HAR Dataset. 

2. My GitHub repo
https://github.com/JaySabido/GettingandCleaningData

The GitHub repository contains the following:

* run_analysis.R : R script
* CodeBook.md : a code book that describes the variables, the data, and any transformations or work performed to clean up the data
* README.md : read me file


### Prerequisites

1. If you don't have the data set, please use the lines of code I commented on the script. This will download the zipped data set and put the UCI HAR Dataset folder in your working directory. If you already have the dataset, please make sure your working directory contains the UCI HAR dataset folder. The R script assumes that. 

2. R packages used:
library("dplyr")
library("plyr")
library("reshape2")



### Installing and running the script

Run the R command:

    source("run_analysis.R)

### Output of the script

Output is the tidy data set in a text file in your working directory called "Course3AssignTidyData.txt".
The tidy data set contains the mean of each of the 86 variables, for each of the 6 activities, for each of the 30 subjects studied. The tidy data set has dimensions 180 x 89. The first 3 columns are the "subject", "activitycode" and "activity". The 86 variables were extracted from the 561 features of the original data set. These 86 chosen features are the measurements on the mean or standard deviation for each measurement.

### And coding style 

The script does the following per the project assignment requirement https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script is divided into 6 parts, one part for each requirement. Requirement 0 is reading all the txt files.

Although the script reads both the Inertial Signals folders for the test and train data sets, these were not used. The 128 variables of the inertial signals data were not defined in the UCI HAR Dataset readme file. And these variables do not seem to match the 561-feature vector in the "features.txt" file.

For parts of the script that were challenging to the author, references were given as comments in the actual script.

## Deployment

No additional notes on deployment

## Built With

* R version: I used R version 3.3.3, dated 2017-03-06
* Computer OS: I wrote the R code on a Windows 10 Pro version 1703 machine


## Acknowledgments

* Billie Thompson, [PurpleBooth](https://github.com/PurpleBooth), "README.md template" from https://gist.github.com/PurpleBooth/109311bb0361f32d87a2#file-readme-template-md, retrieved on May 20, 2017
* David Hood, "Getting and Cleaning the Assignment", https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/, retrieved on May 20, 2017
* etc

