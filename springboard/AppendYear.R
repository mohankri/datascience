library(plyr)
DIR <- "~/datascience/springboard/project/"
setwd(DIR)

f<-list.files(paste(DIR, "./csv_files", sep=""))


read_each<-function(fname) {
  my_data<-read.csv(paste(DIR, "./csv_files/",fname, sep=""))
  curr_year<-substr(fname, nchar(fname)-7, nchar(fname)-4)
  #my_data<-tbl_df(my_data)
  my_data<-my_data %>% mutate(Year=curr_year)
  #my_data[my_data==""] <-NA
  print(my_data)
  write.csv(my_data, file=paste(DIR, "./csv_files/", fname, sep=""), row.names = FALSE)
  rm(my_data)
}

lapply(f, read_each)

