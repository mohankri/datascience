library(dplyr)
library(ggplot2)
DIR<-paste(Sys.getenv("HOME"), "/datascience/springboard/project/", sep="")
setwd(DIR)

df<- read.table(paste(DIR, "MergeDataSet.csv", sep=""), sep=",", header=TRUE)

number_of_movies <- function(yrsum) {
  print(paste("Number of Movies made in ", yrsum))
}

# Convert data to tbl class. tbl are easier to examine then dataframes.
ldf <- tbl_df(df)

yrsum<-ldf %>% group_by(Year) %>% summarise(n())
p<-ggplot(yrsum, aes(x=Year, y=`n()`)) + 
  geom_bar(stat="identity", width = 1, fill="steelblue") + theme_minimal() +
  labs(title="Number of Movies by Year") + labs(x="Year") + labs(y="Total Number of Movies")
  
print(p)

p<-ggplot(category, aes(x=Genre, y=`n()`)) + 
  geom_bar(stat="identity", width = 1, fill="steelblue") +   
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  labs(title="Number of Movies by Genre") + labs(y="Total Number of Movies") +
  labs(caption="Based on the-numbers.com")

print(p)
category<-ldf %>% group_by(Genre) %>% summarise(n())

#p<-ggplot(category, aes(x=Genre, y=`n()`)) + geom_point(alpha=0.5)
#print(p)



train_data <- subset(ldf, Year < 2010)
yrsum<-train_data %>% group_by(Year) %>% summarise(n())
mean.num_of_movie=mean(yrsum$`n()`, na.rm=T)
model1 <- lm(yrsum$`n()`~Year, data=yrsum)
p<-ggplot(yrsum, aes(x=Year, y=`n()`)) + geom_point() +  
  geom_hline(yintercept=mean.num_of_movie) + 
  geom_abline(intercept=model1$coefficients[1], slope=model1$coefficients[2], color="red")

#print(p)

# Genre Drama
train_data <- ldf
train_data <- subset(ldf, Year < 2010)

#train_data <- train_data %>% filter(train_data$Genre == "Drama")
yrsum<-train_data %>% group_by(Year, Genre) %>% summarise(n())
mean.num_of_movie=mean(yrsum$`n()`, na.rm=T)
#model1 <- lm(yrsum$`n()`~Year, data=yrsum)
model1 <- lm(yrsum$`n()` ~ Year, data=yrsum)

#p<-ggplot(yrsum, aes(x=Year, y=yrsum$`n()`)) + geom_point() +
p<-ggplot(yrsum, aes(y=yrsum$`n()`, x=Year)) + geom_point() +
  geom_hline(yintercept=mean.num_of_movie) +
  geom_abline(intercept=model1$coefficients[1], slope=model1$coefficients[2], color="red")
#print(p)
