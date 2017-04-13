library(dplyr)
DIR<-paste(Sys.getenv("HOME"), "/datascience/springboard/project/", sep="")
setwd(DIR)

df<- read.table(paste(DIR, "MergeDataSet.csv", sep=""), sep=",", header=TRUE)
#print(head(df))

number_of_movies <- function(yrsum) {
  print(paste("Number of Movies made in ", yrsum))
}

# Convert data to tbl class. tbl are easier to examine then dataframes.
ldf <- tbl_df(df)

#ldf %>% group_by(Year) %>% tally(sort=TRUE) %>% table() %>% head()
yrsum<-ldf %>% group_by(Year) %>% summarise(n())
number_of_movies(yrsum)

