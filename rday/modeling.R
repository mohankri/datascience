library(dplyr)
library(ggplot2)
library(lattice)
library(devtools)
library(statisticalModeling)
library(rpart)

DIR<-paste(Sys.getenv("HOME"), "/datascience/springboard/project/", sep="")
setwd(DIR)
df<- read.table(paste(DIR, "MergeDataSet.csv", sep=""), sep=",", header=TRUE)
ldf <- tbl_df(df)

pbudget<-ldf %>% group_by(Year, ProductionBudget) %>% summarise(n())
pbudget <- subset(pbudget, Year < 2017)

pbudget$ProductionBudget <- as.numeric(gsub('[$,]', '', pbudget$ProductionBudget))
aggr<-aggregate(pbudget$ProductionBudget, by=list(Year=pbudget$Year), FUN=sum, na.rm=T)

p<-ggplot(aggr, aes(x=aggr$Year, y=aggr$x)) + 
  geom_bar(stat="identity", width = 0.5, fill="steelblue") + theme_minimal() +
  labs(title="Total Production Budget By Year") + labs(x="Year") + labs(y="Total Production Budget")

mean.pbudget<-mean(aggr$x, na.rm=T)
model1 <- lm(aggr$x~Year, data=aggr)
mpi <- cbind(aggr, predict(model1, interval = "prediction"))

p<-ggplot(aggr, aes(x=aggr$Year, y=aggr$x)) + geom_point() + 
  geom_hline(yintercept=mean.pbudget, color="green") +
  geom_abline(intercept=model1$coefficients[1], slope=model1$coefficients[2], color="red") +
  stat_smooth(method="loess", formula = y ~ x, size=1)
 
p<-ggplot(mpi, aes(x = aggr$Year)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr),
              fill = "blue", alpha = 0.2) +
  geom_point(aes(y = aggr$x)) +
  geom_line(aes(y = fit), colour = "blue", size = 1)  


train_data <- tbl_df(df)
genre<-train_data %>% group_by(Year, Genre) %>% summarise(n())
drama <- subset(genre, Genre=="Drama")
drama <- subset(drama, Year<2018)

mean.num_of_movie=mean(genre$`n()`, na.rm=T)
caption<-labs(caption="Based on the-numbers.com")

model2 <- lm(drama$`n()`~Year, data=drama)
drama.df=data.frame(drama)

mp2 <- cbind(drama.df, predict(model2, interval = "predict"))

p4<-ggplot(mp2, aes(x = drama$Year, y=drama$`n()`)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), fill = "blue", alpha = 0.2) +
  geom_point(aes(y = drama$`n()`)) +
  geom_hline(yintercept=mean.num_of_movie, color="green") +
  #geom_abline(intercept=model2$coefficients[1], slope=model2$coefficients[2], color="red") + 
  stat_smooth(method="loess", formula = y ~ x, size=1) +
  geom_line(aes(y = fit), colour = "red", size = 1) +
  labs(title="Genre=Drama") + labs(x="Year") +
  labs(y="Number of Movies(Drama)") + caption
