library(readxl)
library(xlsx)
library(dplyr)


refine <- read_excel("~/datascience/springboard/datawrangling/exercise1/refine.xls")

fix_company <- function(df) {
  df$company <- tolower(sub("*.*.PS", "PHILLIPS", df$company, ignore.case = TRUE))
  df$company <- tolower(sub("^AK*.*", "AKZO", df$company, ignore.case = TRUE))
  df$company <- tolower(sub("^VAN*.*", "VAN HOUTEN", df$company, ignore.case = TRUE))
  df$company <- tolower(sub("*.*.VER", "UNILEVER", df$company, ignore.case = TRUE))
  return(df)
}


# take it to local data frame
new_refine<-tbl_df(refine)

new_refine$company <- toupper(new_refine$company)

new_refine<-fix_company(new_refine)
View(new_refine)

fix_product_number <- function(df) {
  df <- mutate(df, ProductCode = substr(df$`Product code / number`,1,1))
  df <- mutate(df, ProductNumber = substr(df$`Product code / number`, 3, 5))
  return(df)
}

new_refine<-fix_product_number(new_refine)

fix_product_category <- function(code) {
  if (code == "p") {
    return ("Smartphone")
  }
  if (code == "v") {
    return ("TV")
  }
  if (code == "x") {
    return ("Laptop")
  }
  if (code == "q") {
    return("Tablet")
  }
  return ("N/A")
}

new_refine$ProductCode = sapply(new_refine$ProductCode, fix_product_category)

fix_full_address<-function(addr, city, country) {
  return (paste(addr, city, country, sep=","))
}

add_product_column <- function(df) {
  df <- mutate(df, product_smartphone=(df$ProductCode=="Smartphone"))
  df <- mutate(df, product_laptop=(df$ProductCode=="Laptop"))
  df <- mutate(df, product_tv=(df$ProductCode=="TV"))
  df <- mutate(df, product_tablet=(df$ProductCode=="Tablet")) 
  return (df)
}

new_refine <- mutate(new_refine, full_address=mapply(fix_full_address, new_refine$address, new_refine$city, new_refine$country))

new_refine <- add_product_column(new_refine)

add_company_column <- function(df) {
  df <- mutate(df, company_phillipse=(df$company=="phillips"))
  df <- mutate(df, company_akzo=(df$company=="van houten"))
  df <- mutate(df, company_vanhouten=(df$company=="unilever"))
  df <- mutate(df, company_unilever=(df$company=="akzo")) 
  return (df)
}

new_refine <- add_company_column(new_refine)

write.csv(new_refine, file="~/datascience/springboard/datawrangling/exercise1/refine_original.csv", row.names = FALSE)

