setwd("~/datascience/kaggle/titanic")
titanic.train = read.csv(file="train.csv", stringsAsFactors = FALSE, header = TRUE)
titanic.test = read.csv(file = "test.csv", stringsAsFactors = FALSE, header = TRUE)

titanic.train$IsTrainSet <- TRUE
titanic.test$IsTrainSet <-FALSE
titanic.test$Survived <- NA

titanic.full <- rbind(titanic.train, titanic.test)

titanic.full[titanic.full$Embarked=='', "Embarked"] <- 'S'

age.median <- median(titanic.full$Age, na.rm = TRUE)
titanic.full[is.na(titanic.full$Age), "Age"] <- age.median

fare.median <- median(titanic.full$Fare, na.rm = TRUE)
titanic.full[is.na(titanic.full$Fare), "Fare"] <- fare.median


# categorial factor
titanic.full$Pclass <- as.factor(titanic.full$Pclass)
titanic.full$Sex <- as.factor(titanic.full$Sex)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)

titanic.test <- titanic.full[titanic.full$IsTrainSet == FALSE,]
titanic.train <- titanic.full[titanic.full$IsTrainSet == TRUE, ]

titanic.train$Survived <- as.factor(titanic.train$Survived)

# Predict Survided based on category class, sex, age...
survived.equation <- "Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
survived.formula <- as.formula(survived.equation)

install.packages("randomForest")
library(randomForest)

titanic.model<-randomForest(formula = survived.formula, data = titanic.train, ntree = 500, mtry = 3, nodesize = 0.01 * nrow(titanic.test))

feature.equation <- "Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"

Survived <- predict(titanic.model, newdata = titanic.test)

PassengerId <- titanic.test$PassengerId

output.df<-as.data.frame(PassengerId)

output.df$Survived <- Survived

write.csv(output.df, file="titanic_submission.csv", row.names = FALSE)
