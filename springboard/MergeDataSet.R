library(plyr)
DIR <- "~/datascience/springboard/project/"
setwd(DIR)
csv_path <- paste(DIR, "./csv_files/", sep="")

merge_dataset <- function() {
  f<-list.files(csv_path)
  result<-""
  for (fname in f) {
    print(paste("read ", fname))
    if (!exists("fdataset")) {
      fdataset<-read.csv(paste(csv_path,fname, sep=""), header=TRUE)
    } else if (exists("fdataset")) {
      temp_dataset<-read.csv(paste(csv_path, fname, sep=""), header=TRUE)
      fdataset<-rbind(fdataset, temp_dataset)
      rm(temp_dataset)
    }
    result<-fdataset
  }
  return(result)
}

final<-merge_dataset()
write.csv(final, file=paste(DIR, "MergeDataSet.csv", sep=""), row.names = FALSE)
rm(final)
