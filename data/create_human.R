#Rekar Abdulhamed
#Data wranling for IODS E5
#http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

library(dplyr)

human <- read.delim("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep = ",", header =T)

class(human$GNI)
head(human&GNI)
#GNI human has commas as a separator for thousands. 
#That is probably why it was coded as a character in the first place. 

human$GNI <- as.numeric(gsub(",", "",human$GNI)) #removing the commas; shorter solution compared to the one presented in datacamp

#str_replace(human$GNI, pattern=",", replace="") %>% as.numeric solution from strignr package



keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))

human <- filter(human, complete.cases(human)) #remove NA's rowwise

data.frame(human[-1], comp=complete.cases(human)) #making sure it worked

tail(human, 10) #last seven are regions, not countries. Removing these

regions <- nrow(human) - 7
human <- human[1:regions,]

rownames(human) <- human$Country #adding countries as rownames
human <- select(human, -Country) #remove Country column

str(human) #155 observations of 8 variables 


write.csv(human, "human.csv", row.names = T)


