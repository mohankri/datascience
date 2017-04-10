library(dplyr)

testdf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/test/X_test.txt")
traindf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/train/X_train.txt")

access_y_file <- function(param) {
  return(param)
}

get_merge_data_set <- function(set1, set2) {
  return(rbind(set1, set2)) 
}

#xdb<-mutate(xdb, y_param=mapply(access_y_file, ydb$V1))

merge_df<-get_merge_data_set(testdf, traindf)
rm(testdf)
rm(traindf)

get_refine_dataset <- function(merge_df) {
  # Get Column Name
  col_name<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/features.txt")[,2]
  # Assign Column Name to the Merge DataSet
  colnames(merge_df) <- col_name
  # Find the Column Name based regular Expression
  mean_std = grepl("-(mean|std)\\()", col_name)
  # Get Subset of column start with mean and std dev
  merge_df<-subset(merge_df, select=mean_std)
  rm(col_name)
  
  return(merge_df)
}

merge_df<-get_refine_dataset(merge_df)


bind_column_with_activity<-function(merge_df) {
  testdf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/test/y_test.txt")
  traindf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/train/y_train.txt")
  mdf<-rbind(testdf, traindf)[,1]
  rm(testdf, traindf)
  activity_label<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/activity_labels.txt")[,2]
  mdf<-activity_label[mdf]
  return(cbind(Activities=mdf, merge_df))
}

merge_df<-bind_column_with_activity(merge_df)

append_subject<-function(merge_df) {
  testdf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/test/subject_test.txt")
  traindf<-read.table("~/datascience/springboard/datawrangling/exercise3/UCI/train/subject_train.txt")
  subject<-rbind(testdf, traindf)[,1]
  rm(testdf, traindf)
  return(cbind(Subject=subject, merge_df))
}

merge_df<-append_subject(merge_df)

rename_column_name <- function(merge_df) {
  colnames(merge_df) <- gsub("mean", "Mean", colnames(merge_df))
  return(merge_df)
}

merge_df<-rename_column_name(merge_df)

result<-merge_df %>% group_by(Subject, Activities) %>% summarise_each(funs(mean))

write.csv(result, file="~/datascience/springboard/datawrangling/exercise3/final_result.csv", row.names = FALSE)
write.csv(merge_df, file="~/datascience/springboard/datawrangling/exercise3/merge_test.csv", row.names = FALSE)

rm(result, merge_df)
