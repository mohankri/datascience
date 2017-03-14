
if (!require(XML)) install.packages('XML')
if (!require(plyr)) install.packages('plyr')

library(XML)
library(plyr)
DIR <- "~/datascience/rday/csv_files/"
setwd(dir=DIR)

#
# Extract data for each individual year
#
data_url <- function(year, source) {
	url <- paste(source)
        # get the data frame
	yrtbl <- readHTMLTable(url, which=1)
	
	finalData <- subset(yrtbl, !(is.na(yrtbl$Movie) & is.na(yrtbl$ProductionBudget) &
	                      is.na(yrtbl$DomesticBox)))
	file_name<-paste("movie_year_", year, ".csv", sep="")
	print(file_name)
	write.table(finalData, file_name, sep=",", row.names=F)
}

#
# For each year found to call check_url to tranverse movie released in that 
# particular year.
#

check_url <- function(year) {
	yearurl <- paste("http://www.the-numbers.com/movies/year/", year, sep="")
	print(paste("Dump data for year", yearurl))
	data_url(year, yearurl)
}

#
# Read the table and create a sorted order set of data for each year
#
MovieYearCrawler <- function(source) {
	url <- paste(source)
        # get the data frame
	tables <- readHTMLTable(url, which=1)
	#select the year column of dataframe
	yeardata<-tables$Year
	position<-order(yeardata)
	lapply(yeardata[position], check_url)
}

# Call to parse the main HTML Page.
MovieYearCrawler("http://www.the-numbers.com/movies/#tab=year")
