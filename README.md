README.txt for run_analysis.R
===============================================================================
run_analysis.R
by Tobias Hertlein
===============================================================================
The R script run_analysis.R was written to generate a tidy data set for further
downstream analysis of following dataset:

Human Activity Recognition Using Smartphones Dataset
Version 1.0
by
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
===============================================================================
The original dataset was derived from 30 volunteers who performed 6 different
activities while wearing a Samsung smartphone to record the activity with its
sensors (accelerometer and gyroscope).

The R script run_analysis.R was aimed to generate a tidy dataset which includes
the average of all mean and standard deviation (std) values from the original 
dataset in relation to the volunteer and activity.

#Step 1
To achieve this goal, it first loads the necessary raw data from the working
directory into R, then merges the "train" and the "test" dataset to one dataset
called train_and_test (lines 13 to 33).

#Step 2
The 2nd step is to extract only the mean and std values for each measurement. 
This is done by "greping" all mean and std cols ind line 37 and subsetting the
train_and_test dataset for only these cols (line 38). The resulting dataframe 
is named "selected" since only selected variables are further processed in this 
script.

#Step 3
The 3rd step is to give the activities descriptive names, not only numbers. 
This is achieved in lines 40 to 48 by using a for loop to exchange the numbers
which are indicating the activity by its respective "clear" name.

#Step 4
The 4th step is to label the variables (in the columns) by descriptive names. 
Since I already applied the names from the original dataset to the dataframes
(including the "selected" dataframe) to "grep" all mean and std values in code
line 37, my dataframe has already descriptive names for the variables. I 
decided to keep the names from the original raw data set, since I think that 
they include all necessary, understandable information about the variable in
the shortest possible way.

#Step 5
Step 5, finally, is to create a tidy data set which includes the average of
each variable for each activity and subject. I did this in code lines 57 to 62
by grouping the dataframe "selected" with the dplyr function "group_by" by 
subject and activity and then summarizing the mean of all variables (with 
exception of subject and activity) by the dplyr command "summarize_all".

The resulting data set is then finally exported as .txt file (as proposed) in
code line 65.
