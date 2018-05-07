###Getting and Cleaning Data Course###
###Course Project###
###Alberto Vicens###

setwd("~/cursos/data_science_Coursera/3_cleaning_data/")

##Assembly datasets
activity<-read.table(file="UCI HAR Dataset/activity_labels.txt")
features<-read.table(file="UCI HAR Dataset/features.txt")

#Training dataset
trainSet<-read.table(file="UCI HAR Dataset/train/X_train.txt")
trainLab<-read.table(file="UCI HAR Dataset/train/y_train.txt")

colnames(trainSet)<-features$V2
trainDf<-cbind(trainLab,trainSet)

#Test dataset
testSet<-read.table(file="UCI HAR Dataset/test/X_test.txt")
testLab<-read.table(file="UCI HAR Dataset/test/y_test.txt")


