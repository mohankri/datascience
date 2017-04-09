library(readxl)
library(dplyr)
refine <- read_excel("~/datascience/springboard/datawrangling/refine.xls")

fix_company <- function(name) {
  print(name)
  data<-regexpr('^[pP].*[sS]$', name, TRUE)
  print(data)
}

# take it to local data frame
new_refine<-tbl_df(refine)

fix_company(new_refine$company)
