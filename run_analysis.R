# Peer-graded Assignment : Getting and Cleaning Data Course Project

# UCI HAR Dataset : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# ------------------------------------------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
setwd('D:/Documents/PPD PAPAR/COURSERA/MODULE 3 WEEK 4 PROJECT/UCI HAR Dataset');

# 1.1 Import features and activity label data
features <- read.table('./features.txt',header=FALSE);

activityLabel <- read.table('./activity_labels.txt',header=FALSE); 

colnames(activityLabel) <- c("activityId","activityType");

# 1.2 Import and merge train data
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE); 

colnames(subjectTrain) <- "subjectId";

xTrain <- read.table('./train/x_train.txt',header=FALSE); colnames(xTrain) <- features[,2];

yTrain <- read.table('./train/y_train.txt',header=FALSE); colnames(yTrain) <- "activityId";

trainSet = cbind(yTrain,subjectTrain,xTrain);

# 1.3 Import and merge Test Data 
subjectTest <- read.table('./test/subject_test.txt',header=FALSE); 

colnames(subjectTest) <- "subjectId";

xTest <- read.table('./test/x_test.txt',header=FALSE); colnames(xTest) <- features[,2];

yTest <- read.table('./test/y_test.txt',header=FALSE); colnames(yTest) <- "activityId";

testSet = cbind(yTest,subjectTest,xTest);

# 1.4 Combine Train Data and Test Data and create vector
combineDataSet = rbind(trainSet,testSet);

columns <- colnames(combineDataSet);

# ------------------------------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# 2.1 Create a vector that indentifies the ID, mean & stddev columns
indentifier <- (grepl("activity..",columns) | grepl("subject..",columns) | grepl("-mean..",columns) &
             !grepl("-meanFreq..",columns) & !grepl("mean..-",columns) | 
             grepl("-std..",columns) & !grepl("-std()..-",columns));

# Update combined train data and test data based on previously identified columns
combineDataSet <- combineDataSet[indentifier==TRUE];

# ------------------------------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set

# 3.1 Add in descriptive activity names to combined train data dan test data
combineDataSet <- merge(combineDataSet, activityLabel, by='activityId', all.x=TRUE);

combineDataSet$activityId <-activityLabel[,2][match(combineDataSet$activityId, activityLabel[,1])] 

# 3.2 Update columns vector
columns <- colnames(combineDataSet);

# ------------------------------------------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names.

# 4.1 Rename with descriptive column names
for (i in 1:length(columns)) 
{
  columns[i] <- gsub("\\()","",columns[i])
  columns[i] <- gsub("-std","StdDev",columns[i])
  columns[i] <- gsub("-mean","Mean",columns[i])
  columns[i] <- gsub("^(t)","Time",columns[i])
  columns[i] <- gsub("^(f)","Frequency",columns[i])
  columns[i] <- gsub("BodyBody","Body",columns[i])
  columns[i] <- gsub("Gyro","Gyroscope",columns[i])
  columns[i] <- gsub("Acc","Accelerometer",columns[i])
  columns[i] <- gsub("Mag","Magnitude",columns[i])
};

# 4.2 Update combineDataSet with new column names
colnames(combineDataSet) <- columns;

# 4.3 Remove activityType column
combineDataSet <- combineDataSet[,names(combineDataSet) != 'activityType'];

# ------------------------------------------------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject.

# 5.1 Create summerize data set
tidyData <- aggregate(combineDataSet[,names(combineDataSet) != c('activityId','subjectId')], 
                      by=list(activityId=combineDataSet$activityId, 
                      subjectId=combineDataSet$subjectId),mean);

# 5.2 Export tidyData set 
write.table(tidyData, './TidyData.txt',row.names=FALSE,sep='\t')
