## read in activity decoder ring file and features file, label columns
activities <- read.table("./UCI_HAR_Dataset/activity_labels.txt")
names(activities) <- c("Index","ActivityType")
features <- read.table("./UCI_HAR_Dataset/features.txt")
names(features) <- c("Index","Feature")

## identify which indices are associated with data needed (mean and std for each measurement)
keepData <- grepl("[Ss][Tt][Dd]", features$Feature) | grepl("[Mm][Ee][Aa][Nn]", features$Feature)
## 86 cols to keep

## do the following for the test data

  ## read in Subject file, store in a var (S), label variables, label as Test data
  subTest <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
  names(subTest) <- c("Subject")
  subTest$DataType <- rep("Test",nrow(subTest))

  ## read in activity performed file, store in a var (Y) 
  activitiesTest <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
  names(activitiesTest) <- c("Activity")
  
  ## translate activities in (Y) into english
  for (i in 1:nrow(activitiesTest))
    activitiesTest[i,"Activity"] <- as.character(activities[activitiesTest[i, "Activity"], "ActivityType"])

  ## read in data file (X) and properly label the columns
  dataTest <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
  names(dataTest) <- features[,"Feature"]
  
  ## keep only the columns we want
  newDataTest <- dataTest[,keepData]
  
  ## bind columns (S) (Y) (X)
  testData <- cbind(subTest, activitiesTest, newDataTest)
  
  ## housekeeping
  rm(list = c("activitiesTest", "dataTest","newDataTest","subTest"))
  
## repeat for the training data
  
  ## read in Subject file, store in a var (S), label variables, label as Training data
  subTrain <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
  names(subTrain) <- c("Subject")
  subTrain$DataType <- rep("Train",nrow(subTrain))
  
  ## read in activity performed file, store in a var (Y) 
  activitiesTrain <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
  names(activitiesTrain) <- c("Activity")
  
  ## translate activities in (Y) into english
  for (i in 1:nrow(activitiesTrain))
    activitiesTrain[i,"Activity"] <- as.character(activities[activitiesTrain[i, "Activity"], "ActivityType"])
  
  ## read in data file (X) and properly label the columns
  dataTrain <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
  names(dataTrain) <- features[,"Feature"]
  
  ## only keep the columns we want
  newDataTrain <- dataTrain[,keepData]
  
  ## bind columns (S) (Y) (X)
  trainData <- cbind(subTrain, activitiesTrain, newDataTrain)
  
  ## housekeeping
  rm(list = c("activitiesTrain", "dataTrain","newDataTrain","subTrain"))
  
## global housekeeping
rm(list = c("activities","features"))
  
## merge the data sets 
allTheData <- rbind(testData, trainData)

## from the created data set, create a second data set with the average for 
## each variable for each activity and each subject; save to a file 
groupedMeans <- aggregate(allTheData[,4:89], list(allTheData$Subject, allTheData$Activity), mean)
write.table(allTheData, file ="allTheData.txt", row.names = FALSE)

