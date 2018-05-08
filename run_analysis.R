###Getting and Cleaning Data Course###
###Course Project###
###Alberto Vicens###

#Set working directory to the project folder
setwd("~/cursos/data_science_Coursera/3_cleaning_data/course_project/")

#1. Merge training and test datasets to get one dataset
##Load Training dataset
trainSet<-read.table(file="UCI_HAR_dataset/train/X_train.txt")
trainLab<-read.table(file="UCI_HAR_dataset/train/y_train.txt")
trainDf<-cbind(trainLab,trainSet)

##Load Test dataset
testSet<-read.table(file="UCI_HAR_dataset/test/X_test.txt")
testLab<-read.table(file="UCI_HAR_dataset/test/y_test.txt")
testDf<-cbind(testLab, testSet)

##Merge datasets
fullDf<-rbind(trainDf,testDf)
rm(trainDf, testDf)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##Load Features dataset
features<-read.table(file="UCI_HAR_dataset/features.txt")
feat<-as.character(features$V2)

##Create a vector with column indexes of "mean" or "std" values 
idx<-grep("mean\\(\\)|std",feat)

##Retrieve columns to a new datset
myDf<-fullDf[,idx]

#4. Appropriately labels the data set with descriptive variable names. 
##Create vector of variable names
idx_names<-grep("mean\\(\\)|std",feat,value=TRUE)
colnames(myDf)<-idx_names

#3. Uses descriptive activity names to name the activities in the data set
##Load activity_labels file
actLab<-read.table("UCI_HAR_dataset/activity_labels.txt",header=FALSE)
activity<-sapply(fullDf$V1,function(x) actLab$V2[x])
myDf$activity<-activity

#5.  creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

##Load subject vectors and append a Subject column
trainSubj<-read.table("UCI_HAR_dataset/train/subject_train.txt",header=FALSE)
testSubj<-read.table("UCI_HAR_dataset/test/subject_test.txt",header=FALSE)
fullSubj<-rbind(trainSubj,testSubj)
myDf$Subject<-fullSubj$V1

##Create a tidy dataset with averages of each variable for each activity and each subject.
library(dplyr)
#Group the data by Activity and Subject
groupData<-group_by(myDf, activity, Subject)
#Apply mean function for all variables
tidyDf<- groupData %>% summarize_all(funs(mean))

#Export dataset
write.table(tidyDf,file="Samsung_means.txt",sep = "\t", row.names = F, col.names = T)
