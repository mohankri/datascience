library(XML)
library(plyr)
DIR <- "./"
setwd(DIR)


check_url <- function(year) {
	yearurl <- paste("http://www.the-numbers.com/movies/year/", year, sep="")
	print(yearurl)
}

MovieYearCrawler <- function(source) {
	url <- paste("http://www.the-numbers.com/movies/#tab=year")
        # get the data frame
	tables <- readHTMLTable(url, which=1)
	#select the year column of dataframe
	yeardata<-tables$Year
	position<-order(yeardata)
	lapply(yeardata[position], check_url)
}

MovieYearCrawler("movielist")
