#######################################################################################
# Section 1: Merges the training and the test sets to create one data set.
#######################################################################################

  # Get the Data
  # Assume the folder structure was placed as is inside the working directory
  setwd('UCI HAR Dataset')
  # load the features.txt file
  features <- read.table('features.txt')
  
  # load the activity labels -- activity_labels.txt
  activity_labels <- read.table('activity_labels.txt')
  
  # load the training data files
  setwd('train')
    
    # load the subject indices for each row of data -- subject_train.txt
    subject_indices_train <- read.table('subject_train.txt')
  
    # load the activity numbers for each row of data -- y_train.txt
    activity_numbers_train <- read.table('y_train.txt')
  
    # now load the training data -- X_train.txt
    x_train_data <- read.table('X_train.txt')
    
    # return up to the previous folder level
    setwd('..')
  
  # load the test data files
  setwd('test') 
  
    # load the subject indices for each row of data -- subject_test.txt
    subject_indices_test <- read.table('subject_test.txt')
  
    # load the activity numbers for each row of data -- y_test.txt
    activity_numbers_test <- read.table('y_test.txt')
  
    # now load the training data -- X_test.txt
    x_test_data <- read.table('X_test.txt')
  
    # return up to the previous folder level
    setwd('..')
  
  # return to the working directory
  setwd('..')

  # now stitch it together
    # start by merging the test and training indices together
    subject_indices_all <- rbind(subject_indices_train, subject_indices_test)

    # next merge the activity numbers together
    activity_numbers_all <- rbind(activity_numbers_train, activity_numbers_test)

    # now merge the test and train data together to a table that we'll use later
    merged_data_set <- rbind(x_train_data, x_test_data)

    # apply the subject indices to each row of the merged data set
    merged_data_set <- cbind(merged_data_set, subject_indices_all)

    # merge the activity numbers to the merged data set
    merged_data_set <- cbind(merged_data_set, activity_numbers_all)
    
    # Now apply the names to every column in the merged_data_set
    feature_names <- as.character(features[,2])
    extra_names <- c("subject", "Activity_Num")
    column_names <- make.names(c(feature_names, extra_names), unique=TRUE)
    names(merged_data_set) <- column_names

######################################################################################################
# Section 2: Extracts only the measurements on the mean and standard deviation for each measurement.
######################################################################################################

    # now lets subset the data to just the columns we want
    # at first I was concerned this was too inclusive becuase it includes all columns with std or mean in
    # them, but then I read the discussion forum notes from the TA saying that either way to interpret this
    # was fine
    reduced_merged_data_set <- merged_data_set[,grep("std()|mean()|subject|Activity_Num", column_names)] 


######################################################################################################
# Section 3: Uses descriptive activity names to name the activities in the data set
######################################################################################################
    #join the labels to the merged data set using the activity number
    rmds_with_activity <- merge(reduced_merged_data_set, activity_labels, by.x="Activity_Num", by.y="V1") 
    
    # lets properly name the column.  Currently it is set to V2
    #names(rmds_with_activity)[names(rmds_with_activity)=="V2"] <- "Activity_Label"


######################################################################################################
# Section 4: Appropriately labels the data set with descriptive variable names.
######################################################################################################
    
    # I've already applied names to the columns in step 1 because I feel that is much cleaner and
    # understandable.  Here I will reapply the names to the smaller data set and in the process
    # change the label of the Activity Label column from v2 to Activity_Label
    feature_name_subset <- feature_names[grep("std()|mean()", feature_names)]
    new_col_names <- c("Activity_Num", feature_name_subset, "subject", "Activity_Label")
    names(rmds_with_activity) <- new_col_names


######################################################################################################
# Section 5: From the data set in step 4, creates a second, independent tidy data set with the average of 
#            each variable for each activity and each subject.
######################################################################################################

    # I find it easier to subset the data using a data table, so let's import the library
    library(data.table)
    # now turn the DF into a DT
    myDT <- data.table(rmds_with_activity)

    # get all the column names besides the subject, Activity_Label, and Activity_Num
    remove <- c("Activity_Label", "subject", "Activity_Num")
    variables <- names(myDT)[! names(myDT) %in% remove]
    # now apply the mean function to the datatable to compute the average of each variable for each subject and activity
    # and product a Data Frame as a result
    UnsortedTidyDF <- as.data.frame(myDT[, lapply(.SD, mean), .SDcols=variables, by=list(subject, Activity_Label)])
 
    # Now we have a new "almost" tidy data frame, but it is unsorted and the column names don't really represent
    # the true description of the values.  Let's fix that.
    # first get the current names
    Old_Col_Names <- names(UnsortedTidyDF)
    # now add Avg to each name to indicate the represent and Average value
    new_col_names_tidy <- paste(Old_Col_Names, "Avg", sep=" ")
    # fix the subject and Activity_Label column names because they aren't averages
    new_col_names_tidy[1] <- "subject"
    new_col_names_tidy[2] <- "Activity_Label"

    # now apply the correct names to the tidy data frame
    names(UnsortedTidyDF) <- new_col_names_tidy

    # now sort the data frame by subject and activity and save as TidyDF
    TidyDF <- UnsortedTidyDF[with(UnsortedTidyDF, order(subject, Activity_Label)),]

    # finally, write the tidy dataframe to a text file called Tidy.txt
    write.table(TidyDF, "Tidy.txt", row.name=FALSE)
