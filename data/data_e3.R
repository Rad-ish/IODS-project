#Rekar Abdulhamed
#16.11.2021
#E3 of IODS

#Dataset in hand is a student performance data set made available by Pauolo Cortez; 
#retrieved from: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/
library(dplyr)

### Read data ####
setwd("C:/Users/rekar/Documents/Road to PhD/Kurssit/Open data science/IODS-project/data")
dmath=read.table("student-mat.csv",sep=";",header=TRUE)
dpor=read.table("student-por.csv",sep=";",header=TRUE)

### Check data ####

dplyr::glimpse(dmath) #33 variables, 395 observations
dplyr::glimpse(dpor) #33 variables, 649 observations

### Combine datasets ####

por_id <- dpor %>% mutate(id=1000+row_number()) 
math_id <- dmath %>% mutate(id=2000+row_number())

free_cols <- c("id", "failures", "paid", "absences", "G1", "G2", "G3")

join_cols <- setdiff(colnames(por_id), free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))
pormath <- por_id %>% 
  bind_rows(math_id) %>%
  group_by(.dots=join_cols) %>%
  summarise(
    n=n(), 
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     
    paid=first(paid),                   
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  filter(n==2, id.m-id.p>650) %>%
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

glimpse(pormath) #370 observations, 51 variables 


###Save dataset ####
write.csv(pormath, "pormath.csv", row.names = F)



