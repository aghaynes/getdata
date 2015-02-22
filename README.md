# getdata
"Getting and cleaning data" project

The run_analysis.R file contains R code to load, merge and summarise the Samsung activity data and export the mean values of mean and standard deviation variables. These means are exported to file "Mean_Samsung_data.txt".

Lines 4-6 download and unzip the data to the working directory. The zip file is saved as Coursera_Projectdata.zip and is then unziped into the UCI HAR Dataset folder.

Lines 10 and 11 load the raw data from the training and test dataset and line 12 then merges these two files together. Line 15 retrieves the variable names from the features file and Line 16 applies these names to the dataset. These names seem to be as good as any other names I could come up with so I have refrained from changing them.

Line 19 produces a dataset called extract containing only those variables containing mean and standard deviation variables.

Lines 22-24 load the information as to what activity each participant was performing at what time point. Lines 25 & 26 load the labels for each of the activities and generates a factor variable with the values 1:6 and the appropriate text labels.

Lines 29-31 load the participant identifiers.
Line 34 combines the extract data with the activity and participant identifiers.

Line 37 calculates the mean of all variables for each combination of participant and activity.

In my opinion, this data is already tidy - 
 - each column represents one type of data,
 - each row represents the observations relating to each activity, and 
 - the data can be considered to be an aggregation of a number of tables, each referring to unique participants (http://vita.had.co.nz/papers/tidy-data.pdf).

It would be possible to convert this to a long format (e.g. merging the individual X, Y and Z changes with a new column to identify direction), which would reduce the number of variables by almost a third, but these should be kept seperate in my opinion. It makes subsequent analysis easier for one thing.

Line 40 exports the data to "Mean_Samsung_data.txt".

dat <- read.table("Mean_Samsung_data.txt", head=TRUE) should be sufficient to load this data into R

## Codebook
Lines 43 onwards generate a codebook for the dataset using a series of logical tests to paste the appropriate text together and writes the output to a file called "CodeBook.txt" (file CodeBook.txt in the repo). The text in this file is surrounded by quotations to distinguish the columns.










