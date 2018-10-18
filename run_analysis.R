library(dplyr)
library(plyr)
###1:Merges the training and the test sets to create one data set. 
#Dowload files 
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              '/Users/aniketkumar/Downloads/zip.zip')
#Unzip the file and store in folder 'data' 
unzip(zipfile = '/Users/aniketkumar/Downloads/zip.zip', exdir = '/Users/aniketkumar/Downloads/')

###Create a dataframe for 'test'
##Subjects data frame 
subjectsTest <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/test/subject_test.txt', 
                         header = FALSE, sep = "")
colnames(subjectsTest) <- c('subject')

##X_test dataframe
x_test <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/test/X_test.txt', 
                        header = FALSE, sep = "")
#Get feature names 
features <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/features.txt', 
                     header = FALSE, sep = "")
#Extract feature names and place them in vector to rename columns for x_test
feature_vector <- features$V2
colnames(x_test) <- feature_vector
##Y-test dataframe 
y_test <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/test/Y_test.txt', 
                        header = FALSE, sep = "")
colnames(y_test) <- c('label')
##Combine all of these using cbind to create test_df
test_df <- cbind(subjectsTest, x_test, y_test)
##Remove the unneeded dataframes 
rm(features, subjectsTest, x_test, y_test)

##Similarly, create dataset for train
#Subject dataframe 
subjectsTrain <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/train/subject_train.txt', 
                              header = FALSE, sep = "")
colnames(subjectsTrain) <- c('subject')
#X-train dataframe 
x_train <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/train/X_train.txt', header = FALSE, sep = "")
colnames(x_train) <- feature_vector
#Y-train dataset 
y_train <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/train/Y_train.txt', header = FALSE, sep = "")
colnames(y_train) <- c('label')
#Combine all of these using cbind to create train_df
train_df <- cbind(subjectsTrain, x_train, y_train)
#Remove the unneeded dataframes 
rm(feature_vector, subjectsTrain, x_train, y_train)

#Create one dataset mergin test_df on train_df
final_df <- rbind(test_df, train_df)
#Remove unused datasets
rm(test_df, train_df)

###2.Extracts only the measurements on the mean and standard deviation for each measurement
colInd <- append(grep("mean|std", colnames(final_df)), c(1, 563))
final_df1 <- final_df[,colInd]
remColInd <- grep(pattern = "^((?!Freq).)*$", colnames(final_df1), perl = T)
final_df1 <- final_df1[,remColInd]
final_df <- final_df1
rm(colInd, remColInd, final_df1)

###3. Uses descriptive activity names to name the activities in the data set
activityLab <- read.csv('/Users/aniketkumar/Downloads/UCI HAR Dataset/activity_labels.txt', 
                         header = FALSE, sep = "")
final_df1 <- merge(x = final_df, y = activityLab, by.x = 'label', by.y = 'V1')
final_df <- final_df1
rm(final_df1, activityLab)
final_df <- final_df[,-1]

###4. Appropriately labels the data set with descriptive variable names.
namesColFin <- c("bodyAccel_mean_X", "bodyAccel_mean_Y", "bodyAccel_mean_Z",         
                 "bodyAccel_std_X", "bodyAccel_std_Y", "bodyAccel_std_Z",           
                 "gravityAccel_mean_X", "gravityAccel_mean_Y", "gravityAccel_mean_Z",       
                 "gravityAccel_std_X", "gravityAccel_std_Y", "gravityAccel_std_Z",        
                 "bodyAccelJerk_mean_X", "bodyAccelJerk_mean_Y", "bodyAccelJerk_mean_Z",      
                 "bodyAccelJerk_std_X", "bodyAccelJerk_std_Y", "bodyAccelJerk_std_Z",       
                 "bodyGyro_mean_X", "bodyGyro_mean_Y", "bodyGyro_mean_Z",         
                 "bodyGyro_std_X", "bodyGyro_std_Y", "bodyGyro_std_Z",          
                 "bodyGyromJerk_mean_X", "bodyGyromJerk_mean_Y", "bodyGyromJerk_mean_Z",     
                 "bodyGyromJerk_std_X", "bodyGyromJerk_std_Y", "bodyGyromJerk_std_Z",      
                 "bodyAccelMagn_mean", "bodyAccelMagn_std", "gravityAccelMagn_mean",      
                 "gravityAccelMagn_std", "bodyAccelJerkMagn_mean", "bodyAccelJerkMagn_std",      
                 "bodyGyroMagn_mean", "bodyGyroMagn_std", "bodyGyroJerkMagn_mean",    
                 "bodyGyroJerkMagn_std", "freqBodyAccel_mean_X", "freqBodyAccel_mean_Y",     
                 "freqBodyAccel_mean_Z", "freqBodyAccel_std_X", "freqBodyAccel_std_Y",           
                 "freqBodyAccel_std_Z", "freqBodyAccelJerk_mean_X", "freqBodyAccelJerk_mean_Y",   
                 "freqBodyAccelJerk_mean_Z", "freqBodyAccelJerk_std_X", "freqBodyAccelJerk_std_Y",     
                 "freqBodyAccelJerk_std_Z", "freqBodyGyro_mean_X", "freqBodyGyro_mean_Y",      
                 "freqBodyGyro_mean_Z", "freqBodyGyro_std_X", "freqBodyGyro_std_Y",          
                 "freqBodyGyro_std_Z", "freqBodyAccelMagn_mean", "freqBodyAccelMagn_std",          
                 "freqBodyAccJerkMagn_mean", "freqBodyAccJerkMagn_std", "freqBodyGyroMagn_mean",    
                 "freqBodyGyroMagn_std", "freqBodyGyroJerkMagn_mean", "freqBodyGyroJerkMagn_std", 
                 "subject", "activity")
colnames(final_df) <- namesColFin
rm(namesColFin)

###5. From the data set in step 4, creates a second, independent tidy data set 
###   with the average of each variable for each activity and each subject.

final_df_summ <- aggregate(final_df, by = list(final_df$activity, final_df$subject), FUN = mean)
final_df_summ <- final_df_summ[,-c(69, 70)]
final_df_summ <- rename(x = final_df_summ, replace = c('Group.1' = 'activity', 'Group.2' = 'subject'))


