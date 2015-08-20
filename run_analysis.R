library(dplyr)

# These if statements check to see if the data files have been read into R yet
# If not, it will read the data files in. Only works if the data files have been
# downloaded into the working directory 
if(!exists("featureLabels")){
    featureLabels<-read.table("./UCI HAR Dataset/features.txt",header = FALSE)
}
if(!exists("XtestData")){
    XtestData<-read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE,col.names = featureLabels[,2])
}
if(!exists("YtestData")){
    YtestData<-read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE,col.names = "Activity" )
}
if(!exists("subjectTest")){
    subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,col.names = "Subject")
}
if(!exists("XtrainData")){
    XtrainData<-read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE,col.names = featureLabels[,2])
}
if(!exists("YtrainData")){
    YtrainData<-read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE,col.names = "Activity")
}
if(!exists("subjectTrain")){
    subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE,col.names = "Subject")
}

# This combines all the test and train variables. Then it combines the two data frames
# into one big data frame
testData<-cbind(subjectTest,YtestData,XtestData)
trainData<-cbind(subjectTrain,YtrainData,XtrainData)
CombinedData<-arrange(rbind(testData,trainData),Subject)

# This will select only the variables of interest. i.e subject, activity and all 
# variables containing "mean" and "std".
MeanSTDData<-cbind(select(CombinedData,1:2,contains("mean")),select(CombinedData,contains("std")))

# This replaces the activity code with its description. There is defaintly a 
# better way of doing this.
MeanSTDData$Activity[MeanSTDData$Activity=="1"]<-"WALKING"
MeanSTDData$Activity[MeanSTDData$Activity=="2"]<-"WALKING_UPSTAIRS"
MeanSTDData$Activity[MeanSTDData$Activity=="3"]<-"WALKING_DOWNSTAIRS"
MeanSTDData$Activity[MeanSTDData$Activity=="4"]<-"SITTING"
MeanSTDData$Activity[MeanSTDData$Activity=="5"]<-"STANDING"
MeanSTDData$Activity[MeanSTDData$Activity=="6"]<-"LAYING"

# This changes the variable names into somthing slightly more readable
names(MeanSTDData)<-gsub("^t","Time",names(MeanSTDData))
names(MeanSTDData)<-gsub("^f","Frequency",names(MeanSTDData))
names(MeanSTDData)<-gsub("BodyBody","Body",names(MeanSTDData))
names(MeanSTDData)<-gsub("Acc","Acceleration",names(MeanSTDData))
names(MeanSTDData)<-gsub("Mag","Magnitude",names(MeanSTDData))
names(MeanSTDData)<-gsub("[[:punct:]]","",names(MeanSTDData))
names(MeanSTDData)<-gsub("mean","Mean",names(MeanSTDData))
names(MeanSTDData)<-gsub("std","StandardDeviation",names(MeanSTDData))

# This is where all the magic happens. It groups the data by subject and activity
# and then averages all the variables. Much better than for loops.
groupedData<-group_by(MeanSTDData,Subject,Activity)
outputData<-summarise_each(groupedData,funs(mean))

# This creates a file with the outputData.
write.table(outputData,file = "TidyOutputData.txt",row.names = FALSE)

# You can use this line to read it into R again. Worked for me but you might 
# need to change it if your on a Mac or if you didn't put the file in your
# working directory.

# TidyOutputData<-read.table("TidyOutputData",header = TRUE)
