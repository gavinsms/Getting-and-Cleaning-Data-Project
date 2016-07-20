library(dplyr)

#Load features and labels sets for naming variables in later steps
labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
labels_text<-as.character(labels[,2])
features<-read.table("./UCI HAR Dataset/features.txt")
features_text<-as.character(features[,2])


#Tidly process the trainning set. Load subject.id and label as factors
#for groupby later
train_subj<-read.table("./UCI HAR Dataset/train/subject_train.txt")
names(train_subj)[1]<-"subject.id"
train_subj[,1]<-as.factor(train_subj[,1])

train_x<-read.table("./UCI HAR Dataset/train/X_train.txt")
for (i in 1:length(names(train_x))){
  names(train_x)[i]<-features_text[i]
}

processed_labels<-character(0)
train_y<-read.table("./UCI HAR Dataset/train/y_train.txt")
names(train_y)[1]<-"activity.label"
for (i in 1:length(train_y$activity.label)){
  j<-train_y[i,]
  processed_labels[i]<-labels_text[j]
}
processed_labels<-as.factor(processed_labels)
train_ident<-rep("training",length(processed_labels))

train<-cbind(train_subj,train_x,processed_labels,train_ident)
names(train)[563]<-"label"
names(train)[564]<-"data.group"

#Tidly process the test set. Load subject.id and label as factors
#for groupby later

test_subj<-read.table("./UCI HAR Dataset/test/subject_test.txt")
names(test_subj)[1]<-"subject.id"
test_subj[,1]<-as.factor(test_subj[,1])

test_x<-read.table("./UCI HAR Dataset/test/X_test.txt")
for (i in 1:length(names(test_x))){
  names(test_x)[i]<-features_text[i]
}

test_processed_labels<-character(0)

test_y<-read.table("./UCI HAR Dataset/test/y_test.txt")
names(test_y)[1]<-"activity.label"
for (i in 1:length(test_y$activity.label)){
  j<-test_y[i,]
  test_processed_labels[i]<-labels_text[j]
}
test_processed_labels<-as.factor(test_processed_labels)
test_ident<-rep("test",length(test_processed_labels))

test<-cbind(test_subj,test_x,test_processed_labels,test_ident)
names(test)[563]<-"label"
names(test)[564]<-"data.group"


#Merge test and training sets
merged<-rbind(train,test)

#Subset to only mean and std measurements, subj.id, label, and data.group
#After these lines, the 'filtered' table is the first table the assignment
#requests
means_and_stds<-merged[,grep("std|mean",names(merged))]
filtered<-cbind(merged$subject.id,means_and_stds,merged[,563:564])
names(filtered)[1]<-"subject.id"

#Create new table with average of each variable by subject and activity
#The resulting 'grouped_means' table is the second table that the 
#assignment requests

grouped<-group_by(filtered,subject.id,label)
grouped_means<-summarise_each(grouped,funs(mean))

#Export new table to the working directory as a .txt file
write.table(grouped_means,file="UCI Grouped Means Data",row.names=FALSE)
