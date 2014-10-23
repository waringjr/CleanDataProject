#Coursera: Getting and Cleaning Data, course project
#23 Oct 2014
#Written in RStudio, R v. 3.1.0, Windows 7

require(data.table)
library(dplyr)

#The dataset will be downloaded to the working directory and then unzipped
data<-download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','data')
unzip('./data.zip')

# Read the training data
file1<-".\\UCI HAR Dataset\\train\\subject_train.txt"
train_sub <- read.table(file1, sep=" ", header=F, stringsAsFactors=F)

file2<-".\\UCI HAR Dataset\\train\\X_train.txt"
train_set<-read.csv(file2,sep='',stringsAsFactors=F,header=F)

file3<-".\\UCI HAR Dataset\\train\\y_train.txt"
train_labels<-read.table(file3, sep=" ", header=F, stringsAsFactors=F)

train_data<-cbind(train_sub,train_labels,train_set)


# Read the test data
file4<-".\\UCI HAR Dataset\\test\\subject_test.txt"
test_sub <- read.table(file4, sep=" ", header=F, stringsAsFactors=F)

file5<-".\\UCI HAR Dataset\\test\\X_test.txt"
test_set<-read.csv(file5,sep='',stringsAsFactors=F,header=F)

file6<-".\\UCI HAR Dataset\\test\\y_test.txt"
test_labels<-read.table(file6, sep=" ", header=F, stringsAsFactors=F)

test_data<-cbind(test_sub,test_set,test_labels)

#The data frames for the test set and the training set are then combined into one new 
#data frame 'df'
df<-rbind(train_data,test_data)


#Next read the features file, and label the 561 features in the data frame
file7<-".\\UCI HAR Dataset\\features.txt"
feats<-read.table(file7)
colnames(df)[1:2]<-c("subject","activity")
colnames(df)[3:563]<-as.character(feats[,2])

#Now read the activities file and replace activity code with an appropriate label

file8<-".\\UCI HAR Dataset\\activity_labels.txt"
acts<-read.table(file8,stringsAsFactors=F)
acts[,2]<-sub("_"," ",acts[,2])

#use a for loop to cycle through 'acts' and replacing activity names in df

for (i in 1:nrow(acts)){
  df$activity[df$activity==i]<-acts[i,2]
}

#For question 5, take the average of each measurement across subjects and activities
df1<-group_by(df,subject,activity) 
df2<-summarise_each(df1,funs(mean))
write.table(df2,".\\CourseProjectQ5.txt",row.name=FALSE)
