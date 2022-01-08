library(dplyr)

# Reading supporting data 
features <- read.table("specdata/features.txt")
activities <- read.table("specdata/activity_labels.txt")

# Reading training data
subject_train <- read.table("specdata/train/subject_train.txt")
x_train <- read.table("specdata/train/X_train.txt")
y_train <- read.table("specdata/train/y_train.txt")

# Reading test data
subject_test <- read.table("specdata/test/subject_test.txt")
x_test <- read.table("specdata/test/X_test.txt")
y_test <- read.table("specdata/test/y_test.txt")

# Added column name for the supporting files
colnames(features) <- c("n","functions")
colnames(activities) <- c("activity", "activity")

# Added column name for the subject files
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

# add column name for measurement files
colnames(x_train) <- features$functions
colnames(x_test) <- features$functions

# add column name for label files
colnames(y_train) <- "activity"
colnames(y_test) <- "activity"

#
# Merge the training and the test sets to create one data set
#

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Combined_Data <- cbind(Subject, Y, X)

#
# Extracts only the measurements on the mean and standard deviation for each measurement
#

Tidy_Data <- select(Combined_Data, subject, activity, contains("mean"), contains("std"))

#
# Uses descriptive activity names to name the activities in the data set
#

Tidy_Data$activity <- activities[Tidy_Data$activity, 2]

#
# Appropriately labels the data set with descriptive variable names
# 

names(Tidy_Data)<-gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data)<-gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data)<-gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data)<-gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data)<-gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data)<-gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data)<-gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data)<-gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-std()", "STD", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data)<-gsub("gravity", "Gravity", names(Tidy_Data))

#
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# 

Final_Data <- Tidy_Data %>% group_by(subject, activity) %>% summarise_all(list(mean))

# Write the tidy dataset to a file
write.table(Final_Data, "Tidy_Data.txt", row.name=FALSE)