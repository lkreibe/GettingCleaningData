The following files represent the final project associated with the course
Getting and Cleaning Data:
1. readme.md :: This file which describes the analysis and files
2. codebook.md :: Indicates all variables and summaries calculated and other
   relevant information
3. run_analysis.R :: Run script to download, clean, and consolidate data
4. allTheData.txt :: Clean dataset created to average each 'mean' and 'std'
   variable

The run_analysis.R script does the following:
1. Accesses previously downloaded and unzipped data
2. Labels the data
3. Converts Activity type to a factor
4. Binds the Subject, Activity, and Data sets for Training and Test data
5. Merges the Training and the Test sets to create one data set
6. Extracts all measurements on the mean and standard deviation for each
   measurement.
7. From the data set created, creates a second, independent tidy data set with
   the average of each variable for each activity and each subject.

