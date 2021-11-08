#Rekar Abdulhamed
#8.11.2021
#E2 of IODS
library(tidyverse)

JYTOPKYS <- read.delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt")
str(JYTOPKYS)
#Data is in long format, including 183 observations of 60 variables


### Sum items needed for "Deep" ####


#sum d_sm
lrn <- 
  (JYTOPKYS %>%
     rowwise() %>%
     mutate(
       d_sm = sum(c(D03, D11, D19, D27))
     )
  )

#sum d_ri

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       d_ri = sum(c(D07, D14, D22, D30))
     )
  )


#sum d_ue

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       d_ue = sum(c(D06, D15, D23, D31))
     )
  )

#create deep

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       deep = sum(c(d_sm, d_ri, d_ue))
     )
  )

#Rescale to original

lrn <-
  lrn %>%
  rowwise() %>%
  mutate(
    deep=c(deep/12)
  )







### Sum items needed for "Surf"####

#Sum su_lp
lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       su_lp = sum(c(SU02, SU10, SU18, SU26))
     )
  )

#Sum su_um

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       su_um = sum(c(SU05, SU13, SU21, SU29))
     )
  )


#Sum, su_sb

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       su_sb = sum(c(SU08, SU16, SU24, SU32))
     )
  )



#Aggregate all


lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       surf = sum(c(su_lp+su_um+su_sb))
     )
  )

lrn <-
  lrn %>%
  rowwise() %>%
  mutate(
    surf=c(surf/12)
  )
)


##

###Sum items needed for "Stra"####

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       st_os = sum(c(ST01, ST09, ST17, ST25))
     )
  )

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       st_tm = sum(c(ST04, ST12, ST20, ST28))
     )
  )

lrn <- 
  (lrn %>%
     rowwise() %>%
     mutate(
       stra = sum(c(st_os, st_tm))
     )
  )



#Rescale to original
lrn <-
  lrn %>%
  rowwise() %>%
  mutate(
    stra=c(stra/8)
  )
)





###rescale attitude-variable####
lrn <-
  lrn %>%
  rowwise() %>%
  mutate(
    Attitude=c(Attitude/10)
  )


### Remove 0's from point-variable####
lrn <- subset(lrn, Points!="0")
###

### Select the variables wanted for a new df ####
lrn <- lrn %>%
  select(gender, Age, Attitude, deep, stra, surf, Points)


###Set WD, save df and read df ####

setwd("C:/Users/rekar/Documents/Road to PhD/Kurssit/Open data science/IODS-project/data")

write.csv(lrn, "lrn.csv", row.names = F)

lrn <- read.csv("lrn.csv")

str(lrn)
head(lrn)

