
sub_test<-read.table("subject_test.txt",header=FALSE)
sub_train<-read.table("subject_train.txt",header=FALSE)
sub_test<-read.table("subject_test.txt",header=FALSE)
Y_train<-read.table("y_train.txt",header=FALSE)
Y_test<-read.table("y_test.txt",header=FALSE)
X_train<-read.table("X_train.txt",header=FALSE)
X_test<-read.table("X_test.txt",header=FALSE)
variable_names<-read.table("features.txt",header=FALSE)
activity_names<-read.table("activity_labels.txt",header=FALSE)
X_train[,562]<-sub_train
X_train[,563]<-Y_train
X_test[,562]<-sub_test
X_test[,563]<-Y_test
Combined_DF<-rbind(X_train,X_test)
vname<-variable_names[,2]
vname<-append(as.vector(vname),"Subject",after=length(vname))
vname<-append(as.vector(vname),"Activity",after=length(vname))
colnames(Combined_DF)<-vname
anames=activity_names[,2]
Combined_DF$Activity[Combined_DF$Activity=="1"]<-as.character(anames[1])
Combined_DF$Activity[Combined_DF$Activity=="2"]<-as.character(anames[2])
Combined_DF$Activity[Combined_DF$Activity=="3"]<-as.character(anames[3])
Combined_DF$Activity[Combined_DF$Activity=="4"]<-as.character(anames[4])
Combined_DF$Activity[Combined_DF$Activity=="5"]<-as.character(anames[5])
Combined_DF$Activity[Combined_DF$Activity=="6"]<-as.character(anames[6])

# Variables with mean and Std. Dev only

Comb_DF<-Combined_DF[,grepl("mean|Mean|std|Std",names(Combined_DF))]
Comb_DF[,length(Comb_DF)+1]<-Combined_DF$Subject
colnames(Comb_DF)[length(Comb_DF)]<-"Subject"
Comb_DF[,length(Comb_DF)+1]<-Combined_DF$Activity
colnames(Comb_DF)[length(Comb_DF)]<-"Activity"
Tiny_DS<-aggregate(Comb_DF[, 1:(length(Comb_DF)-2)], list(Comb_DF$Activity,Comb_DF$Subject),mean)
colnames(Tiny_DS)[1]<-"Subject"
colnames(Tiny_DS)[2]<-"Activity"
write.table(Tiny_DS,file="D1.txt",row.names=FALSE)

