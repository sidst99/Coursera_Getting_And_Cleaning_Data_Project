library(plyr)

train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/Y_train.txt")
train_subject <- read.table("train/subject_train.txt")

test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/Y_test.txt")
test_subject <- read.table("test/subject_test.txt")

data_x <- rbind(train_x, test_x)
data_y <- rbind(train_y, test_y)
data_subject <- rbind(train_subject, test_subject)

features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[,2])
data_x <- data_x[, mean_and_std_features]
names(data_x) <- features[mean_and_std_features, 2]

activities <- read.table("activity_labels.txt")
data_y[, 1] <- activities[data_y[, 1], 2]
names(data_y) <- "activity"

names(data_subject) <- "subject"
data_all <- cbind(data_x, data_y, data_subject)

data_averages <- ddply(data_all, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(data_averages, "averages_data.txt", row.name=FALSE)
