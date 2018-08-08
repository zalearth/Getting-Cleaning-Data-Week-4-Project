Peer-graded Assignment: Getting and Cleaning Data Course Project


A. DATA

1. features:
	- data imported from features.txt
	- contain 2 column and 561 row of data 

2. activityLabel 
	- data set imported from activity_labels.txt
	- contain 2 column and 6 row of data 

3. subjectTrain :
	- data imported from subject_train.txt
	- contain 1 column and 7352 row of data

4. xTrain - data imported from x_train.txt 

5. yTrain - data imported from y_train.txt 

6. trainSet - dataset obtained by merging yTrain, subjectTrain and xTrain

7. subjectTest - data imported from subject_test.txt 

8. xTest - data imported from x_test.txt 

9. yTest - data imported from y_test.txt 

10. testSet - dataset obtained by merging yTest, subjectTest and xTest

11. combineDataSet - dataset obtained by merging trainSet, testSet

12. columns - column names list of 'combineDataSet'

13. tidyData - independent tidy data set with the average of each variable for each activity and each subject form 'combineDataSet'



B. VARIABLE 

1. indentifier - vector created to indentify the ID, mean & stddev columns is TRUE from 'combineDataSet' 



C. PROCESS ON GETTING TIDY DATA

1. Read and import data from file to obtain feature, activityLabel, subjectTrain, xTrain, yTrain, subjectTest, xTest and yTest 

2. Assign column name for activityLabel, subjectTrain and subjectTest

3. Merging data for dataset trainSet, testSet and combineDataSet 

4. Getting the list of column names from 'combineDataSet' and assign it to 'columns'

5. Cleaning 'combineDataSet' to get only required column which is contain 'activity', 'subject', 'mean' and 'std' by using created vector named 'indentifier'

6. Rename column name of 'combineDataSet'with descriptive name

7. Remove column 'activityType' 

8. Summerize data by calculating average value of each variable for each activity and each subject by using aggregate function

9. Assign summerized data to 'TidyData'

10. Export 'TinyData' data set to 'TinyData.txt' 



