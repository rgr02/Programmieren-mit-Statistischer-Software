# Aufgabe 1 ################################################

strrev <- function(x = vector()){
  
  # Parameter übergeben und er ist ein vector
  stopifnot(!missing(x),
            is.vector(x),
            is.character(x))
  
  splitted <<- strsplit(x,"") # "" Split in einzelne chars
  
  # Alle chars Buchstaben?
  stopifnot(all(splitted[[1]] %in% c(letters, LETTERS, " ")))
  
  # result <- vector(length = length(splitted[[1]]))
  # j <- 1
  # for(i in length(splitted[[1]]):1){
  #   result[j] <- splitted[i]
  #   j <- j+1
  # }
  
  return(rev(splitted[[1]]))
}
strrev("Rudi")
strrev("Rudi!§$%&")
strrev("H@ll#")
strrev("Programmieren mit statistischer Software")

# Aufgabe 2 ################################################
# install.packages("tm", dependencies = T)

library(tm)
data("crude", package = "tm")
?crude
crude
crude <- sapply(crude, as.character)

crude <- gsub("\n"," ", crude) # Zeilenumbruch durch Leerzeichen
crude <- gsub(" {2}"," ", crude) # Reduziert Leerzeichen sobald sie öfter als 1x hintereinander auftreten.

split1 <- strsplit(crude, split ="[.|!|?]")
split2 <- strsplit(crude, split ="[.|!|?] [A-Z]")

sapply(split1, length)
sapply(split2, length)

# Aufgabe 3 ################################################
#install.packages("bayesm", dependencies = T)
library("bayesm")
library(tidyr)
data("cheese", package = "bayesm")
?cheese
cheese
str(cheese)
View(cheese)

cheese <- separate(cheese,RETAILER, into = c("Location", "Chain"), sep = "-")
# cheese$Location <- gsub("[([[:alnum:]])|,|/]","",cheese$Location) 

cheese$Location <- gsub("\\(.*\\)","",cheese$Location) # Eliminiert Klammerausdrücke
cheese$Location <- gsub("/+.*","",cheese$Location)     # Schrägstrich und alles dahinter
cheese$Location <- gsub(",+.*","",cheese$Location)     # Beistrich und alles dahinter

# Subset wo FOOD im Namen ist
food <- cheese[grep("FOOD", cheese$Chain),] 
food <- select(food,Location,Chain,PRICE) %>%
  group_by(Location) %>%
  summarise(avg.price = mean(PRICE))

food[which(food$avg.price == min(food$avg.price)),] # Orlando
food[which(food$avg.price == max(food$avg.price)),] # Baltimore


# Aufgabe 4 ################################################
# install.packages("SportsAnalytics", dependencies = T)
library("SportsAnalytics")
library(tidyr)
data("EURO4PlayerSkillsSep11", package = "SportsAnalytics")
?EURO4PlayerSkillsSep11
str(EURO4PlayerSkillsSep11)
head(EURO4PlayerSkillsSep11)
View(EURO4PlayerSkillsSep11)

levels(EURO4PlayerSkillsSep11$Position) # 4 Positions
# "Goalkeeper" "Defender"   "Midfielder" "Forward"  


# Default = Nie
EURO4PlayerSkillsSep11$Goalkeeper <- factor(0,levels = 0:2, labels = c( "Nie","Primär", "Sekundär"))
EURO4PlayerSkillsSep11$Defender <- factor(0,levels = 0:2, labels = c( "Nie","Primär", "Sekundär"))
EURO4PlayerSkillsSep11$Midfielder <- factor(0,levels = 0:2, labels = c( "Nie","Primär", "Sekundär"))
EURO4PlayerSkillsSep11$Forward <- factor(0,levels = 0:2, labels = c( "Nie","Primär", "Sekundär"))

# https://www.gamefaqs.com/boards/959290-pro-evolution-soccer-2010/51979102
# CB - Centre Back
# SB - Fullback/Sideback - LB and RB denotes left or right sided
# DMF - Defensive Midfielder
# CMF - Central Midfielder
# WB - Wingback - A more attacking based SB
# SMF - Side Midfielder, same with LMF and RMF
# AMF - Attacking Midfielder
# WF - Wing Forward, LWF and RWF the same
# SS - Second Striker at a guess, plays more as a link up player than a goalpoacher.
# CF - Centre Forward
# 
# Should be them all.

# "Goalkeeper" GK
# "Defender" SB LB RB CB WB
# "Midfielder" DMF CMF  SMF AMF
# "Forward" ss wf CF

EURO4PlayerSkillsSep11[grep("GK", EURO4PlayerSkillsSep11$Positions),]$Goalkeeper <- "Sekundär"
EURO4PlayerSkillsSep11[grep("GK!", EURO4PlayerSkillsSep11$Positions),]$Goalkeeper <- "Primär"

EURO4PlayerSkillsSep11[grep("[SB|LB|RB|CB|WB]", EURO4PlayerSkillsSep11$Positions),]$Defender <- "Sekundär"
EURO4PlayerSkillsSep11[grep("[SB!|LB!|RB!|CB!|WB!]", EURO4PlayerSkillsSep11$Positions),]$Defender <- "Primär"

EURO4PlayerSkillsSep11[grep("[DMF|CMF|SMF|AMF]", EURO4PlayerSkillsSep11$Positions),]$Midfielder <- "Sekundär"
EURO4PlayerSkillsSep11[grep("[DMF!|CMF!|SMF!|AMF!]", EURO4PlayerSkillsSep11$Positions),]$Midfielder <- "Primär"

EURO4PlayerSkillsSep11[grep("[SS|WF|CF]", EURO4PlayerSkillsSep11$Positions),]$Forward <- "Sekundär"
EURO4PlayerSkillsSep11[grep("[SS!|WF!|CF!]", EURO4PlayerSkillsSep11$Positions),]$Forward <- "Primär"


# Aufgabe 5 ################################################

# Cleaning
EURO4PlayerSkillsSep11$Birthday <- gsub("[(|)]","",EURO4PlayerSkillsSep11$Birthday)

# Splitten von Geburtstag
EURO4PlayerSkillsSep11 <- separate(data = EURO4PlayerSkillsSep11,
                                  col = Birthday,
                                  into = c("Tag", "Monat", "Jahr"),
                                  sep = "/")

# Erstellen von Geburtstag ISODate
EURO4PlayerSkillsSep11$Birthday <- ISOdate(EURO4PlayerSkillsSep11$Jahr,
                                             EURO4PlayerSkillsSep11$Monat,
                                             EURO4PlayerSkillsSep11$Tag)


# Referenz
ref.date <- ISOdate(2011,11,17)

EURO4PlayerSkillsSep11$Age2 <- round(difftime(time1 = ref.date,
                                         time2 = EURO4PlayerSkillsSep11$Birthday,
                                         tz = "GMT",
                                         units = "days") / 365, 0)

EURO4PlayerSkillsSep11$diff.in.age <- EURO4PlayerSkillsSep11$Age2 - EURO4PlayerSkillsSep11$Age
EURO4PlayerSkillsSep11$diff.in.age
