library(dplyr)
library(ggplot2)
library(lattice)
library(devtools)
library(statisticalModeling)
library(rpart)
library(grid)
library(gridExtra)

DIR<-paste(Sys.getenv("HOME"), "/datascience/springboard/project/", sep="")
setwd(DIR)
df<- read.table(paste(DIR, "MergeDataSet.csv", sep=""), sep=",", header=TRUE)
#ldf <- tbl_df(df)
caption<-labs(caption="Based on the-numbers.com")
train_data <- tbl_df(df)
genre<-train_data %>% group_by(Year, Genre) %>% summarise(n())
drama <- subset(genre, Genre=="Drama")
drama <- subset(drama, Year<2018)

model1 <- lm(drama$`n()`~Year, data=drama)
mean.num_of_movie=mean(genre$`n()`, na.rm=T)

temp_val <- predict(model1, interval="prediction")

ndrama<-cbind(drama, temp_val)
p<-ggplot(ndrama, aes(x=Year, y=`n()`)) + geom_point() +
  geom_line(aes(y=lwr), color = "red", linetype = "dashed")+
  geom_line(aes(y=upr), color = "red", linetype = "dashed")
print(p)

p<-ggplot(drama, aes(x=Year, y=`n()`)) + geom_point() + 
  geom_hline(yintercept=mean.num_of_movie, color="green") + 
  geom_abline(intercept=model1$coefficients[1],
              slope=model1$coefficients[2], color="red") +
  geom_line(aes(y=lwr), color="black", linetype="dashed") +
  geom_line(aes(y=upr), color="red", linetype="dashed") +
  geom_smooth(method=lm, se=TRUE) +
  stat_smooth(method="loess", formula = y ~ x, size=1) +
  labs(title="Genre=Drama") + labs(x="Year") +
  labs(y="Number of Movies(Drama)") + caption

#print(p)