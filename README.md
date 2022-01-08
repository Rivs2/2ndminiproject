# 2nd Mini Project 
Task # 1
 
 ## Preliminary Step
 Installed the "dplyr" package, a grammar for data manipulation

 Using the read.table() function, the files were read into data frames and then saved to variables.
 Column names wre also added using the colnames() function.
 
 ## Step 1 (Merge the training and the test sets to create one data set)
 Combined similar data into rows from the test and train folders using the rbind() function. Data such as the X datasets (x_train.txt & x_test.txt), Y datasets (y_train.txt & y_test.txt), and the Subject datasets (subject_train.txt & subject_test.txt).
 
 Merged the combined datasets (X,Y, Subject) from the previous step using the cbind() function to create a single dataset (saved to "Combined_Data" varaible).
 
 ## Step 2 (Extracts only the measurements on the mean and standard deviation for each measurement)
 The select() function from the "dplyr" package and the contains() function, was used to extract only the measurements on the mean and standard deviation for each measurement. For the extraction, select() was used to select the columns (subject, activity) from the merged dataset , which is to be filtered using contains(), containg the words "mean" and "std". The result was then saved to the "Tidy_Data" varaible.
 
 ## Step 3 (Uses descriptive activity names to name the activities in the data set)
 To have descriptive names tothe activities in the dataset, the "activity" column is to be manipulated (it contains numbers from 1-6). From the preliminary step, supporting data was also read which includes "activity_labels.txt", it has 2 columns, number code for the activity (1-6) and the types of activity. Matching numbers from the "activity" column and number code (from activity_labels.txt) was replaced by the corresponding activity type.
 
 ## Step 4 (Appropriately labels the data set with descriptive variable names)
 By examining the data, the following acronyms can be replaced:
 * Acc can be replaced with Accelerometer
 * Gyro can be replaced with Gyroscope
 * BodyBody can be replaced with Body
 * Mag can be replaced with Magnitude
 * Character f can be replaced with Frequency
 * Character t can be replaced with Time

 The name() function was used to get the same of names from the dataset and the gsub() function was used to replace the acronyms in the dataset
 
 ## Step 5 (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject)
 First, the columns (subject & activity) was grouped using the group_by() function from the "dplyr" package. Then, using the summarise_all() function (to summarise and mutate multiple columns) from the same package, the list of means (list(mean)) was summarised.
 
 The tidy dataset was written, using the write.table() function, to the "Tidy_Data.txt" file.
 
