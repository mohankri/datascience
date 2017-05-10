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

model<-lm(Year ~ Genre, data = ldf)

# bwplot or boxplot

model1 <- lm(Year ~ Genre, data=ldf)
#fmodel(model1)

model2 <- lm(Year ~ ProductionBudget, data=ldf)
#fmodel(model2)

model3 <- lm(Year ~ Genre + ProductionBudget, data=ldf)
fmodel(model3)
