# run_analysis.R

# unzip dataset
u <- unzip("UCI HAR Dataset.zip")

# Load labels
labels <- read.table("./UCI HAR DATASET/activity_labels.txt", sep=" ")


# Load training sets and subjects
trainSetX <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
trainSetY <- read.table("./UCI HAR Dataset/train/Y_train.txt", colClasses="numeric")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="numeric")



#Load test sets and subjects
testSetX <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses="numeric")
testSetY <- read.table("./UCI HAR Dataset/test/Y_test.txt", colClasses="numeric")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="numeric")



# Combine activities similar to training set
#testSetX$activity <- labels[as.numeric(testSetY[,1]),2]


#load column names

colNames <- read.table("./UCI HAR Dataset/features.txt")
selectedCols = grep("std\\(\\)|mean\\(\\)", as.character(colNames[,2]))

# Include the manually added activity in selected columns (562)
#selectedCols <- c(selectedCols, dim(colNames)[1] +1)

#colNames[selectedCols,] <- colNames[selectedCols,]
#col


# Combine subject data from both training and test sets;
fullSubjects <- as.numeric(rbind(trainSubjects, testSubjects)[,1])

#fullSubjects <- rbind(trainSubjects, testSubjects)
#colnames(fullSubjects) <- "subject"

# Contains labels for the fullDataset
fullLabels <- as.numeric(rbind(trainSetY, testSetY)[,1])

#fullLabels <- rbind(trainSetY, testSetY)
#colnames(fullLabels) <- "activity"

# Change the labels to character format (WALKING2, LAYING)
# instead of numbers 1:6


#textLabels <- labels[fullLabels,2]


#textLabels <- merge(fullLabels, labels, by.x="activity", by.y="V1")
#colnames(textLabels) <- c("activity", "activitytext")


# Fix the column names and delete duplicate column
#textLabels$activity <- NULL
#colnames(textLabels) <- "activity"

# Contains both training and test sets
fullDataset <- as.data.frame(rbind(trainSetX, testSetX))


# Label the full dataset
colnames(fullDataset) <- colNames[,2]

# Leave only the necessary labels, i.e., those containing mean and std
fullDataset <- fullDataset[,selectedCols]

# Add activity labels and subjects to fulldataset

#fullDataset$activity <- textLabels
fullDataset$activity <- fullLabels
#fullDataset$activitytext <- textLabels$activitytext
fullDataset$subject <- fullSubjects

#compute the means
#library(dplyr)
#s <- split(fullDataset, list(textLabels,fullSubjects))
#test <- data.frame(lapply(s,  colMeans))

tidyset <- aggregate(x=fullDataset, by=list(fullDataset$activity, fullDataset$subject), FUN=mean)

# Change the activity column from numerical to character values
tidyset$activity <- labels[tidyset$activity,2]
# Remove the new group columns
tidyset$Group.1 <- NULL
tidyset$Group.2 <- NULL
# Reorder columns so that subject is first, then activity and then all the other columns
tidyset <- tidyset[,c(68, 67,1:66)]


#test <- aggregate(x=fullDataset, by=list(Atest = fullDataset$activity), FUN=mean)



#test2 <- tapply(fullDataset, list(textLabels,fullSubjects), colMeans)
#ddply(fullDataset, .(subject, activity), summarize, mean)
# these columns are the only columns in the data that include means and stds from features
#cols <- c(1:6,41:46,81:86,121:126, 161:166, 201:202,214:215, 227:228,
#             240:241, 253:254, 266:271, 345:350, 424:429, 503:504,
#             516:517, 529:530, 542:543)