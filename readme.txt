The R script 'run_analysis.R' seeks to satisfy the course project requirements for "Getting and Cleaning Data".

The data set is assumed to be downloaded and unzipped into a working directory (~/GetCleanData). 

First, the script reads the training set data files into data frames, which include the subject #s, actual data, and data lables (train_sub,train_set,train_labels respectivley).
These 3 data frames are merged into one by columns. 

Likewise, the script reads the test set data files into data frames, which include the subject #s, actual data, and data lables (test_sub,test_set,test_labels respectivley).
These 3 data frames are merged into one by columns. 

The two data frames are merged into one complete data set by rows.  

Next the file containing the feature names (eg. tBodyAcc-mean()-X) is read.  The feature names are applied to the merged data frame, with 'subject' and 'activities' designated the names of columns 1 and 2.

Next the file containing the names of the activities (eg. WALKING) is read, and the underscores are replaced by spaces.  The activity names are then substituted for activity codes in the merged data frame.  

Finally, the analysis in question 5 is carried out.  The data mean of the features for every subject and activity is taken using the dplyr library.  The generated data frame is titled 'df2' and is written to a text file for submission.