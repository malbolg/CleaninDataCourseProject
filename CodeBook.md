Code Book
---------

This data set contains 180 rows and 68 variables:

- subject
- activity
- 66 processed original variables from UCI HAR data set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) for which you can see the descriptions in file features_info.txt in the dataset

Each row in the dataset corresponds to one activity done by one subject so each subject-activity combination is unique row in the dataset. The 66 variables from the original dataset have the same name, but these are actually means of the corresponding observations from the original dataset, taken over the corresponding subject-activity combination.

Also, full original dataset was used, i.e., training and test set was merged to a total of 10299 observations, from which the means were computed per each subject and activity.



## Subject
Subject is an id integer between 1:30, corresponding to one test subject recording the movements

## Activity
Activity is a string factor describing the movements recorded by the test subject. There are 6 activities:

- LAYING
- SITTING
- STANDING
- WALKING
- WALKING_DOWNSTAIRS
- WALKING_UPSTAIRS

## 66 variables from feature_info.txt
These are all means of the variables from the original dataset per each subject-activity combination. In the raw dataset these were all means and standard deviations from particular measures.

