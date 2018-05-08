# Getting and Cleaning Data Course Project

## Description
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The task will consist on collecting data from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

I will create one R script called **run_analysis.R** that does the following.

* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* 3. Uses descriptive activity names to name the activities in the data set
* 4. Appropriately labels the data set with descriptive variable names.
* 5. Creates a tidy data set with the average of each variable for each activity and each subject.

# Workflow
## 1.Merge training and test datasets
I first loaded the training and test datasets, with their respective label files, into R. I then merged the data and label files for each dataset, creating **trainDf** and **testDf**. After this, I merged these two dataframes to get a full dataset called to which I named **fullDf**.

## 2. Extracts the measurements on the mean and standard deviation for each measurement. 
To achieve this, I loaded the features file (**features.txt**) into R and extracted the column with the feature values, which passed to be a vector (**feat**).
Later, I created a vector with the indexes (**idx**) of columns containing *mean* and *std* by applying the *grep* function on the **feat** vector.
I then extracted the *mean* and *std* columns by subsetting the **fullDF** with the **idx** vector, creating a new dataset **myDf**

## 4. Appropriately label the data set with descriptive variable names.
Note that I performed this step before step 3 for convenience.

I created a vector with names (**idx_names**) applying the *grep* function mentioned above but this time with the argument *value=TRUE* to get the values of matches.
I then declared this vector as the column names of **myDf**

## 3. Use descriptive activity names to name the activities in the data set
For this step, I loaded the **activity_labels.txt** file into R. Then, by using the *sapply* function on the column of the fullDf (corresponding to the activity numbers) I created a vector with **Activity** names that assigns as first column of myDf.

## 5. Creates a tidy data set with the average of each variable for each activity and each subject.
I loaded the subject datasets (**subject_train.txt**, **subject_test.txt**) into R. I concatenated them with *cbind* and assign the first column of resulting datset (**fullSubj**) as the first column of myDf.

I then grouped the myDf based on **Subject** and **activity** columns, and I appliefd the *summarize_all* function implemented in dplyr to generate a new dataset with the mean of each variable. 






