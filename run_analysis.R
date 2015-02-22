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
extract <- dat[,grepl("mean", names(dat), ignore.case=TRUE)|grepl("std", names(dat))]

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
write.table(means, "Mean_Samsung_data.txt", row.names = FALSE)


# CODEBOOK
nm <- names(means)
labs <- paste(ifelse(nm=="activity", "Activity", ""),
              ifelse(nm=="subject", "Participant identifier", ""),
              ifelse(grepl("mean(", nm, fixed=TRUE), "Mean ", ""),
              ifelse(grepl("meanF", nm), "Mean frequency ", ""),
              ifelse(grepl("std", nm), "Standard deviation of ", ""),
              ifelse(grepl("Body", nm), "body movement ", ""),
              ifelse(substr(nm, 1, 1) == "t", "time ", ""),
              ifelse(substr(nm, 1, 1) == "f", "fast fourier transformed time ", ""),
              ifelse(substr(nm, 1, 5) == "angle", "Angle ", ""),
              ifelse(grepl("Acc", nm), "accelerometer ", ""),
              ifelse(grepl("Gyro", nm), "gyroscope ", ""),
              ifelse(grepl("Jerk", nm), "jerk ", ""),
              ifelse(grepl("Mag", nm), "magnitude ", ""),
              ifelse(grepl("X", nm), "X-axis", 
                     ifelse(grepl("Y", nm), "Y-axis", 
                            ifelse(grepl("Z", nm), "Z-axis", "")
                            )
                     ), 
              ifelse(substr(nm, 1, 1) == "t", "(seconds)", ""),
              ifelse(substr(nm, 1, 1) == "f", "(frequency)", ""),
              ifelse(grepl("angle", nm), "(degrees)", ""),
              sep=""
              )

nmlabs <- data.frame(variable_name = nm, label = labs)

wh <- which(nmlabs$variable_name=="activity")
codebook <- rbind(nmlabs[1:wh,], 
                  data.frame(variable_name = rep("", nrow(activ)), 
                             label = paste(activ[,1], "\t",  activ[,2])),
                  nmlabs[wh+1:nrow(nmlabs),])
write.table(codebook, "CodeBook.txt", row.names = FALSE)

