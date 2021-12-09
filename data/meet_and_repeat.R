#Rekar Abdulhamed
#7.12.2021
#Data wrangling for IODS E6

library(dplyr)
library(tidyr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep= "", header=T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep="", header=T)


#BPRS
names(BPRS)
str(BPRS) #40 obs of 11 variables; wide-format
summary(BPRS)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)
glimpse(BPRS)

BPRS$id <- seq.int(nrow(BPRS)) #Adding an ID column, since the required analysis would not be sensible without it
BPRSL <- BPRS %>% gather(key=weeks, value=bprs, -treatment, -subject, -id) #converting to long format; 
str(BPRSL)
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))
glimpse(BPRSL) #360 observations of 5 variables, long-format

write.csv(BPRSL, "BPRSL.csv", row.names = F)
testi <- read.csv("BPRSL.csv", header=T, sep=",")




#RATS
names(RATS)
str(RATS) #16 observations of 13 variables, long-format
summary(RATS)

RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)
RATSL <- RATS %>% gather(key=WD, value=Weight, -Group, -ID) %>%
mutate(time = as.integer(substr(WD, 3,4)))
glimpse(RATSL) #176 observations of 5 variables 

write.csv(RATSL, "RATSL.csv", row.names = F)
testi2 <- read.csv("BPRSL.csv", header = T, sep=",") 


#In wide-format, each measure was recorder to individual column. 
#Hereby, all measures of each individual are on an individual row
#In long format, each row represents a measuring point. Therefore there are 
#several rows for each individual, as each row represents a measuring point

