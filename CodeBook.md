Code Book
Coursera Data Science Specialization 
Course Getting and Cleanng Data
Course Project


Processing
Step 1: Merge training and test sets to create one data set
Data was downloaded from the source files and read in with names corresponding to the source files. Test set data were combined together by columns. Train set data were combined in the same manner. Test and train set data were combined to created the full data set (fullSet).

Step 2: Extract only measurements on mean and standard deviation
A names variable (allNames) that included the subject, activity and all feature names was created. This variable was subsetted to include only the subject, activity, and variables that included mean and standard deviation (std). This subsetted names variable was then used to extract the corresponding columns in the full data set. The result was saved as the reducedSet.

Step 3: Use descriptive activities names for activity measurements
The coded values for activity were changed to the activity name. This change was accomplished by indexing the activity_labels variable.

Step 4: Appropriately Label the Dataset with Descriptive Variable Names
The allNames variable was subsetted in the same manner as the data. The resulting reducedNames variable was processed in a number of steps: capital letters were applied where appropriate, punctuation was removed, abbreviations "t" and "f" were changed to time and frequency. Finally, theses modified names were applied to the reducedSet.

Step 5: Create tidy data set with average of each variable, by activity, by subject
The reducedSet from the end of Step 4 was grouped by subject, then by activity, and summarized so that the observations in each row were the means of the variable columns, for that subject/activity. This was accomplished by applying the dply package verbs "group_by" and "summarise_each". The resulting tidy data set was written to a file called "tidyDataset.txt".

Variables
Variables: Environment and data source
today = today's date, later coerced to data and time
mySystem = description of computer hardware and software used in this analysis
dataDescription = source project description from UCI Machine Learning Repository
fileUrl = URL for zip archive of source data

Variables: Imported files named according to sources file names
activitylabels = six activity codes and corresponding activity names
featureNames = feature names for X_test, X_train

subjectTest = test set subject number, 1-30
featuresTest = test set feature measurements
activityTest = test set activity, coded 1-6

SubjectTrain = train set subject number, 1-30
featuresTrain = train set feature measurements
activityTrain = train set activity, coded 1-6

Variables: Combined data sets
subject = (subjectTrain, subjectTest), combined by columns
activity = (activityTrain, activityTest) combined by columns
features =  (featuresTrain, featuresTest)

Variables: Column names
Colnames = Columns in feature dataset can be named from metadata in featureNames
CompleteData = The data in features, activity and subject are merged in completeData
columnsWithMeanSTD = column indexes that have mean or std in them.
requiredColumns = Add activity and topic columns to the list.
extractedData = We create extractedDatacon with the selected columns in requiredColumns format.




Variables: Tidy data set
tidy = data set with average of each variable, by activity, by subject