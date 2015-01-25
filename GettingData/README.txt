==================================================================
Human Activity Recognition Using Smartphones Dataset Summarized
Version 1.0
==================================================================

This script takes the Human Activity Recognition data and summarizes it in a tidy data set 

Here are the steps taken:

#######################################################################################
# Section 1: Merges the training and the test sets to create one data set.
#######################################################################################

  # Step 1A: Get the Data
      # Assume the folder structure was placed as is inside the working directory.  This means
        That there is a folder in the working directory called UCI HAR Dataset.  Inside that folder
        there are the following files:
            activity_labels.txt
            features.txt
            /test/subject_test.txt
            /test/X_test.txt
            /test/y_test.txt
            /train/subject_train.txt
            /train/X_train.txt
            /train/y_train.txt
  
  # Step 1B: load the features.txt file
  
  # Step 1C: load the activity labels -- activity_labels.txt
  
  # Step 1D: load the training data files

    # Step 1D-1: Change the working directory to the training subfolder
    
    # Step 1D-2: load the subject indices for each row of data -- subject_train.txt
    
    # Step 1D-3: load the activity numbers for each row of data -- y_train.txt
    
    # Step 1D-4: now load the training data -- X_train.txt
    
    # Step 1D-5: return up to the previous folder level
    
  # Step 1E: load the test data files
  
    # Step 1E-1: Change the working directory to the test subfolder

    # Step 1E-2: load the subject indices for each row of data -- subject_test.txt
    
    # Step 1E-3: load the activity numbers for each row of data -- y_test.txt
    
    # Step 1E-4: now load the training data -- X_test.txt
    
    # Step 1E-5: return up to the previous folder level
    
  # Step 1F: return to the working directory
  
  # Step 1G: now stitch it together.
    # Step 1G-1: start by merging the test and training indices together
    
    # Step 1G-2: next merge the activity numbers together
    
    # Step 1G-3: now merge the test and train data together to a table that we'll use later
    
    # Step 1G-4: apply the subject indices to each row of the merged data set
    
    # Step 1G-5: merge the activity numbers to the merged data set
    
    # Step 1G-6: Now apply the names to every column in the merged_data_set.  The instructions say to do this later, but
                I think it is much cleaner and understandable to do this step now.
    

######################################################################################################
# Section 2: Extracts only the measurements on the mean and standard deviation for each measurement.
######################################################################################################

    # Step 2A: now lets subset the data to just the columns we want
    # at first I was concerned this was too inclusive becuase it includes all columns with std or mean in
    # them, but then I read the discussion forum notes from the TA saying that either way to interpret this
    # was fine
    

######################################################################################################
# Section 3: Uses descriptive activity names to name the activities in the data set
######################################################################################################
    # Step 3A: join the labels to the merged data set using the activity number
    
    # Step 3B: lets properly name the column.  Currently it is set to V2


######################################################################################################
# Section 4: Appropriately labels the data set with descriptive variable names.
######################################################################################################
    
    # I've already applied names to the columns in step 1 because I feel that is much cleaner and
    # understandable.  
    # Step 4A: Here I will reapply the names to the smaller data set and in the process
    # change the label of the Activity Label column from v2 to Activity_Label


######################################################################################################
# Section 5: From the data set in step 4, creates a second, independent tidy data set with the average of 
#            each variable for each activity and each subject.
######################################################################################################

    # Step 5A: I find it easier to subset the data using a data table, so let's import the library

    # Step 5B: now turn the DF into a DT

    # Step 5C: get all the column names besides the subject, Activity_Label, and Activity_Num
 
    # Step 5D: now apply the mean function to the datatable to compute the average of each variable for each subject and activity
    # and product a Data Frame as a result
    
    # Step 5E: Now we have a new "almost" tidy data frame, but it is unsorted and the column names don't really represent
    # the true description of the values.  Let's fix that.
    # first get the current names
    
    # Step 5F: now add Avg to each name to indicate the represent and Average value
 
    # Step 5G: fix the subject and Activity_Label column names because they aren't averages

    # Step 5H: now apply the correct names to the tidy data frame


    # Step 5I: now sort the data frame by subject and activity and save as TidyDF


    # Step 5J: finally, write the tidy dataframe to a text file called Tidy.txt
