mydata<-read.csv("~/datascience/springboard/project/kmeans_data.csv")

head(mydata)
str(mydata)
summary(mydata)

plot(mydata[c("Sepal.Length", "Sepal.Width")], main="Raw Data")

#standardising the data
mydata <- scale(mydata)

wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))

for(i in 1:25){wss[i] <- sum(kmeans(mydata, centers=i)$withinss)}

plot(1:25, wss, type="b", xlab="No. of Clusters", ylab="wss")

wss



clus4 <- kmeans(mydata, centers=4, nstart=30)

clus4

aggregate(mydata ,by=list(clus4$cluster), FUN=mean)

mydata <- data.frame(mydata, clus4$cluster)

groups <- data.frame(clus4$cluster)
table(groups)

plot(mydata[c("Sepal.Length", "Sepal.Width")], col=clus4$cluster)
points(clus4$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3, pch=8, cex=2)


clus3 <- kmeans(mydata, centers=3, nstart=20)
clus3

aggregate(mydata ,by=list(clus3$cluster), FUN=mean)

mydata <- data.frame(mydata, clus3$cluster)

groups <- data.frame(clus3$cluster)
table(groups)

plot(mydata[c("Sepal.Length", "Sepal.Width")], col=clus3$cluster)
points(clus3$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3, pch=8, cex=2)