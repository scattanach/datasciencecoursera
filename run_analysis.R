#install.packages("stringr")
library("stringr")
#install.packages("plyr")
library("plyr")
#install.packages("dplyr")
library("dplyr")

test.subject.test <- read.table("subject_test.txt", header=FALSE) # [1] 2947    1
test.x.test <- read.table("X_test.txt", header=FALSE) # [1] 2947  561
test.y.test <- read.table("Y_test.txt", header=FALSE) # [1] 2947    1

#test.b.a.x <- read.table("Inertial Signals/body_acc_x_test.txt", header=FALSE) # [1] 2947  128
#test.b.a.y <- read.table("Inertial Signals/body_acc_y_test.txt", header=FALSE) # [1] 2947  128
#test.b.a.z <- read.table("Inertial Signals/body_acc_z_test.txt", header=FALSE) # [1] 2947  128

#test.b.g.x <- read.table("Inertial Signals/body_gyro_x_test.txt", header=FALSE) # [1] 2947  128
#test.b.g.y <- read.table("Inertial Signals/body_gyro_y_test.txt", header=FALSE) # [1] 2947  128
#test.b.g.z <- read.table("Inertial Signals/body_gyro_z_test.txt", header=FALSE) # [1] 2947  128

#test.t.a.x <- read.table("Inertial Signals/total_acc_x_test.txt", header=FALSE) # [1] 2947  128
#test.t.a.y <- read.table("Inertial Signals/total_acc_y_test.txt", header=FALSE) # [1] 2947  128
#test.t.a.z <- read.table("Inertial Signals/total_acc_z_test.txt", header=FALSE) # [1] 2947  128

train.subject.test <- read.table("subject_train.txt", header=FALSE) # [1] 7352    1
train.x.test <- read.table("X_train.txt", header=FALSE) # [1] 7352  561
train.y.test <- read.table("Y_train.txt", header=FALSE) # [1] 7352    1

#train.b.a.x <- read.table("Inertial Signals/body_acc_x_train.txt", header=FALSE) # [1] 7352  128
#train.b.a.y <- read.table("Inertial Signals/body_acc_y_train.txt", header=FALSE) # [1] 7352  128
#train.b.a.z <- read.table("Inertial Signals/body_acc_z_train.txt", header=FALSE) # [1] 7352  128

#train.b.g.x <- read.table("Inertial Signals/body_gyro_x_train.txt", header=FALSE) # [1] 7352  128
#train.b.g.y <- read.table("Inertial Signals/body_gyro_y_train.txt", header=FALSE) # [1] 7352  128
#train.b.g.z <- read.table("Inertial Signals/body_gyro_z_train.txt", header=FALSE) # [1] 7352  128

#train.t.a.x <- read.table("Inertial Signals/total_acc_x_train.txt", header=FALSE) # [1] 7352  128
#train.t.a.y <- read.table("Inertial Signals/total_acc_y_train.txt", header=FALSE) # [1] 7352  128
#train.t.a.z <- read.table("Inertial Signals/total_acc_z_train.txt", header=FALSE) # [1] 7352  128

act.lab <- read.table("activity_labels.txt", header=FALSE) # [1] 6 2
features <- read.table("features.txt", header=FALSE) # [1] 561   2

subject.test <- rbind(test.subject.test, train.subject.test)
x.test <- rbind(test.x.test, train.x.test)
y.test <- rbind(test.y.test, train.y.test)

#b.a.x <- rbind(test.b.a.x, train.b.a.x)
#b.a.y <- rbind(test.b.a.y, train.b.a.y)
#b.a.z <- rbind(test.b.a.z, train.b.a.z)

#b.g.x <- rbind(test.b.g.x, train.b.g.x)
#b.g.y <- rbind(test.b.g.y, train.b.g.y)
#b.g.z <- rbind(test.b.g.z, train.b.g.z)

#t.a.x <- rbind(test.t.a.x, train.t.a.x)
#t.a.y <- rbind(test.t.a.y, train.t.a.y)
#t.a.z <- rbind(test.t.a.z, train.t.a.z)

names(subject.test) <- c("Subject")

y.test$V1[y.test$V1 == 1]  <- "WALKING"
y.test$V1[y.test$V1 == 2] <- "WALKING_UPSTAIRS"
y.test$V1[y.test$V1 == 3]  <- "WALKING_DOWNSTAIRS"
y.test$V1[y.test$V1 == 4] <- "SITTING"
y.test$V1[y.test$V1 == 5] <- "STANDING"
y.test$V1[y.test$V1 == 6] <- "LAYING"

names(y.test) <- c("Activity")

tidyData <- cbind(cbind(subject.test, y.test), x.test)

aggData <- ddply(tidyData, c("Subject", "Activity"), numcolwise(mean))

names(tidyData) <- c("Subject","Activity", str_replace_all(features$V2, "[^[:alnum:]]", ""))

names(aggData) <- c("Subject","Activity", str_replace_all(features$V2, "[^[:alnum:]]", ""))

tidyData <- tidyData[,grepl("std|mean|Subject|Activity", names(tidyData))]

aggData <- aggData[,grepl("std|mean|Subject|Activity", names(aggData))]



