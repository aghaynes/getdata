# Get the data
# (technically not required)

# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Coursera_Projectdata.zip")
# unzip("Coursera_Projectdata.zip")
# file.info("Coursera_Projectdata.zip")


# load & merge training and test data sets
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
dat <- rbind(train, test)

# apply names to data 
nams <- read.table("UCI HAR Dataset/features.txt")
names(dat) <- nams[,2]

# extract mean and standard deviation columns
extract <- dat[,grepl("mean(", names(dat), fixed=TRUE)|grepl("std", names(dat))]

# load and label activities activities
trainy <- read.table("UCI HAR Dataset/train/y_train.txt")
testy <- read.table("UCI HAR Dataset/test/y_test.txt")
ys <- rbind(trainy, testy)
activ <- read.table("UCI HAR Dataset/activity_labels.txt")
activity <- factor(x = ys$V1, levels = activ[,1], labels=activ[,2])

# load subject identifiers 
sub_tr <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub_te <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(sub_tr, sub_te)

# merge extracted data, activities and subjects
all_data <- cbind(extract, activity, subject=subject$V1)

# summarise data
means <- aggregate(. ~ activity + subject, all_data, mean)

# export the data
write.table(means, "CourseraProjectSummary.txt", row.names = FALSE)




