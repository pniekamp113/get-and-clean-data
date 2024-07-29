
library(dplyr)

getwd()
#download zipped files
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./Assingment Getting and Cleaning Data/projectdata.zip")

#unzip
unzip(zipfile = "./Assingment Getting and Cleaning Data/projectdata.zip", exdir = "./Assingment Getting and Cleaning Data")

#check for files in directory
list.files("./Assingment Getting and Cleaning Data")
list.files("./Assingment Getting and Cleaning Data/UCI HAR Dataset")
list.files("./Assingment Getting and Cleaning Data/UCI HAR Dataset/test")
list.files("./Assingment Getting and Cleaning Data/UCI HAR Dataset/train")


#read in data files
x_test <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

#read in feature vector
features <- read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/features.txt")

activities = read.table("./Assingment Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")

colnames(activities) <- c("activityId", "activityLabel")


#merge data sets

humanActivity <- rbind(
  cbind(subject_train, x_train,y_train),
  cbind(subject_test, x_test, y_test)
)

# assign column names
colnames(humanActivity) <- c("subject", features[, 2], "activity")


#extract only measurements on the mean and std for each measurement
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))
humanActivity <- humanActivity[, columnsToKeep]

#use descriptive activity names to name the activities

humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])


#label dataset with descriptive variables
humanActivityCols <- colnames(humanActivity) #get column names
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols) # remove special characters

# expand abbreviations and clean up names
humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

colnames(humanActivity) <- humanActivityCols #use new labels as columns names

#create a second independent tidy data set

# group by subject and activity and summarise using mean
humanActivityMeans <- humanActivity %>% 
  group_by(subject, activity) %>%
  summarise(across(everything(), mean, na.rm = TRUE))

# output to file "tidy_data.txt"
write.table(humanActivityMeans, "./Assingment Getting and Cleaning Data/tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
