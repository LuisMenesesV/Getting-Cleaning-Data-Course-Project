Getting Cleaning Data Project
Coursera Data Science Specialization Course 
Course Project

Project Description
This project is an exercise in acquiring and cleaning data.One of the most exciting areas in all of data science right now is portable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked in this project represents data collected from the accelerometers of the Samsung Galaxy S smartphone.

Project Files
Data Processing Script: run_analysis.R
The R script run_analysis.R reads the data files and combines them into one full data file. Important variable values are renamed from numbers to meaningful names. The full set of variables is reduced to a subset that involve means and standard deviations. Variable names are changed to conform with R's legal variable names and to be descriptive.

Tidy Data Output: tidy.txt
The data is then grouped by subject and activity, and summarized by each variable's mean. The end result is a tidy data set, conforming to Hadley Wickham's tidy data principles Tidy Data. The tidy data set is written to the file tidyDataset.txt.

Data Processing Description and Variable Names: CodeBook.md
The file CodeBook.md describes the processing steps and variables used in run_analysis.R and supplements the README.txt included in the original downloaded archive