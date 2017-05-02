library(dplyr)
library(ggplot2)
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
#p<-ggplot(yrsum, aes(x=Year, y=`n()`, col=`n()`)) + geom_point()
p<-ggplot(yrsum, aes(x=Year, y=`n()`)) + geom_bar(stat="identity", width = 1, fill="steelblue") + theme_minimal()
print(p)

category<-ldf %>% group_by(Genre) %>% summarise(n())

#p<-ggplot(category, aes(x=Genre, y=`n()`)) + geom_point(alpha=0.5)
#print(p)



train_data <- subset(ldf, Year < 2017)
yrsum<-train_data %>% group_by(Year) %>% summarise(n())
mean.num_of_movie=mean(yrsum$`n()`, na.rm=T)
model1 <- lm(yrsum$`n()`~Year, data=yrsum)
p<-ggplot(yrsum, aes(x=Year, y=`n()`)) + geom_point() +  
  geom_hline(yintercept=mean.num_of_movie) + 
  geom_abline(intercept=model1$coefficients[1], slope=model1$coefficients[2], color="red")

print(p)


