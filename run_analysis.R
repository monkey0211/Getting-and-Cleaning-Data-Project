##Q1
setwd("~/Downloads/UCI HAR Dataset/train")
 X_train<-read.table("X_train.txt")
 y_train<-read.table("y_train.txt")
 subject_train<-read.table("subject_train.txt")
 y_train<-read.table("y_train.txt")
 X_train<-read.table("X_train.txt",header = FALSE)
 
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

x_data<-rbind(X_train,X_test)
 y_data<-rbind(y_train,y_test)
 colnames(y_data)<-"activity"
 subject_data<-rbind(subject_train,subject_test)
 data<-cbind(x_data,y_data,subject_data)
##Q2
 feature<-read.table("features.txt")
feature1<-grep(".*mean.*|.*std.*",feature[,2])
 featureName<-feature[feature1,2]
 featureName<-gsub('-mean', 'Mean', featureName)
 featureName <- gsub('-std', 'Std', featureName)
 featureName <- gsub('[-()]', '', featureName)
 
 ##Q3&Q4
 x_data1<-rbind(X_train,X_test)[feature1]
 data1<-cbind(x_data1,y_data,subject_data)
 colnames(data1)<-c(featureName,"activity","subject")
 
 names(data1)<-gsub("^t", "time", names(data1))
 names(data1)<-gsub("^f","Frequency",names(data1))
 names(data1)<-gsub("Acc", "Accelerometer", names(data1))
 names(data1)<-gsub("Mag", "Magnitude", names(data1))
 names(data1)<-gsub("BodyBody", "Body", names(data1))
 
 ##Q5
 data2<-aggregate(.~subject+activity,data1,mean)
 data2<-data2[order(data2$subject,data2$activity),]
 write.table(data2,file="tidydata.txt",row.names = FALSE)
 