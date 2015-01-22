# run_analysis.R

# unzip dataset
u <- unzip("UCI HAR Dataset.zip")

# Load training sets and subjects
trainSetX <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
trainSetY <- read.table("./UCI HAR Dataset/train/Y_train.txt", colClasses="numeric")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="numeric")

#Load test sets and subjects
testSetX <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses="numeric")
testSetY <- read.table("./UCI HAR Dataset/test/Y_test.txt", colClasses="numeric")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="numeric")


# Load all column names
colNames <- read.table("./UCI HAR Dataset/features.txt")

# Select only the required 66 columns that contain the string "mean()" or "std()
selectedCols = grep("std\\(\\)|mean\\(\\)", as.character(colNames[,2]))


# Combine subject data from both training and test sets;
fullSubjects <- as.numeric(rbind(trainSubjects, testSubjects)[,1])


# Contains labels for the fullDataset
fullLabels <- as.numeric(rbind(trainSetY, testSetY)[,1])

# Contains both training and test data of observations
fullDataset <- as.data.frame(rbind(trainSetX, testSetX))

# Label the full dataset
colnames(fullDataset) <- colNames[,2]

# Leave only the required labels, i.e., those containing mean() and std()
fullDataset <- fullDataset[,selectedCols]

# Add activity labels and subjects to fulldataset
fullDataset$activity <- fullLabels
fullDataset$subject <- fullSubjects

# Compute the means by factors activity (6 unique values) and
# subject (30 unique values). (It probably took me a couple of hours to get
# this simple operation work. I tried so many different functions (dplyr,
# tapply, split..) until realizing aggregate function is the way to go)
tidyset <- aggregate(x=fullDataset, by=list(fullDataset$activity, fullDataset$subject), FUN=mean)


# Load character labels for activities
labels <- read.table("./UCI HAR DATASET/activity_labels.txt", sep=" ")

# Change the labels to character format (WALKING2, LAYING)
# instead of numbers 1:6
tidyset$activity <- labels[tidyset$activity,2]

# Remove the new group columns added by aggregate function
tidyset$Group.1 <- NULL
tidyset$Group.2 <- NULL
# Reorder columns so that subject is first, then activity and then all the other columns
tidyset <- tidyset[,c(68, 67,1:66)]