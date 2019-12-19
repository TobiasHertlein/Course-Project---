#run_analysis.R
#by Tobias Hertlein, 2019-12-19

#instructions for the design of this R script:
#You should create one R script called run_analysis.R that does the following.
#Step 1: Merges the training and the test sets to create one data set.
#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 3: Uses descriptive activity names to name the activities in the data set
#Step 4: Appropriately labels the data set with descriptive variable names.
#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
#        of each variable for each activity and each subject

#Step 1
#Merges the training and the test sets to create one data set.
features <- read.table("features.txt") #the features.txt file is derived from the original data folder
features$V2 <- as.character(features$V2)
#loading the training set
train_subject <- read.table("subject_train.txt")
train_activity <- read.table("y_train.txt")
train_values <- read.table("X_train.txt")
train <- data.frame(train_subject,train_activity,train_values)
colnames(train) <- c("subject","activity",features$V2)
#load the test set
test_subject <- read.table("subject_test.txt")
test_activity <- read.table("y_test.txt")
test_values <- read.table("X_test.txt")
test <- data.frame(test_subject,test_activity,test_values)
colnames(test) <- c("subject","activity",features$V2)
#merge both data sets
train_and_test <- rbind(train,test)

#Step 2
#Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_vector <- grep("mean|std",colnames(train_and_test))
selected <- train_and_test[,c(1:2,mean_std_vector)]

#Step 3
#Uses descriptive activity names to name the activities in the data set
#information about activity labels from file: activity_labels.txt
#1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
class(selected$activity)
activity <- c("Walking","Walking_upstairs","Walking_downstairs","Sitting","Standing","Laying")
for (i in 1:6) {
  selected$activity <- sub(i,activity[i],selected$activity)
}

#Step 4
#Appropriately labels the data set with descriptive variable names.
#already done in previous step (line 29, by defining the colnames(which I needed for the grep command in line 35))
#decided not to alter the variable names given by the original data collectors since they are, in my opinion, 
#the shortest way to include all necessary info about the variable in a resonable length
#further information about the variables is supplied in the codebook

#Step 5
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject
library(dplyr)
tidy_results <- group_by(selected, subject, activity)
tidy_results <- summarize_all(tidy_results, mean)

#Exporting the final tidy data set
write.table(tidy_results, "tidy_results.txt", row.name=FALSE) 
