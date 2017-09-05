rm(list = ls())
setwd("C:/Users/Rudi/_Studium/_SS2017/Programmieren R/ue5")

# Aufgabe 1 ###################################################################
data <- read.csv("data/Wholesale customers data.csv")
attach(data)
head(data)
str(data)

# 8 Variablen
# 440 Obs.
dim(data)

Channel <- factor(Channel, levels = c(1,2) , labels = c("Horeca", "Retail") )
Region <- factor(Region, levels = c(1,2,3), labels = c("Lisnon", "Oporto", "Other"))

LisbonRegion <- subset(data, Region == 1 & (Grocery > median(Grocery)))
dim(LisbonRegion)

detach(data)

# Aufgabe 2 ###################################################################
data <- NA
data <- read.table("data/labor.txt", sep = ",", dec= ".",na.string ="?", 
                   header = FALSE, stringsAsFactors = TRUE,
                   col.names = c("duration",
                                 "wage_increase_first_year",
                                 "wage_increase_second_year",
                                 "wage_increase_third_year",
                                 "cost_of_living_adjustment",
                                 "working_hours",
                                 "pension",
                                 "standby_pay",
                                 "shift_differential",
                                 "education_allowance",
                                 "statutory_holidays",
                                 "vacation",
                                 "longterm_disability_assistance",
                                 "contribution_to_dental_plan",
                                 "bereavement_assistance",
                                 "contribution_to_health_plan",
                                 "settlement"
                                 ) )
attach(data)

# Ordinal
vacation <- factor(vacation, levels = c(1,2,3), 
                   labels = c("average", "below average", "generous"), 
                   ordered = TRUE,
                   exclude = NA)

contribution_to_dental_plan <- factor(contribution_to_dental_plan,
                                      levels = c(3,2,1),
                                      labels = c("full", "half", "none"),
                                      ordered = TRUE,
                                      exclude = NA)

contribution_to_health_plan <- factor(contribution_to_health_plan,
                                      levels = c(3,2,1),
                                      labels = c("full", "half", "none"),
                                      ordered = TRUE,
                                      exclude = NA)

# Factors
# cost_of_living_adjustment <- factor(cost_of_living_adjustment)
# pension <- factor(pension)
# education_allowance <- factor(education_allowance)
# longterm_disability_assistance <- factor(longterm_disability_assistance)
# bereavement_assistance <- factor(bereavement_assistance)
# settlement <- factor(settlement)


# Aufgabe 3 ##################################################################

good <- subset(data, settlement == "good")
bad <- subset(data, settlement == "bad")
dim(good)
dim(bad)

good.na <- c()
for(i in good){
  good.na <- c(good.na,sum(is.na(i)))
}
#names(good.na) <- names(good)


bad.na <- c()
for(i in bad){
  bad.na <- c(bad.na,sum(is.na(i)))
}
#names(bad.na) <- names(bad)

rel.good.na <- good.na/26
rel.bad.na <- bad.na/14

barplot(rel.good.na)
barplot(rel.bad.na)

# weniger als 50% missing
good[rel.bad.na < 0.5]
bad[rel.bad.na < 0.5]

# Factor ?
good.factor <- sapply(good,is.factor)
bad.factor <- sapply(bad,is.factor)

good.factor
bad.factor

# metric
good <- good[which(!good.factor)]
bad <- bad[which(!bad.factor)]

colMeans(good, na.rm = TRUE)
colMeans(bad, na.rm = TRUE)


# Aufgabe 4 ###################################################################
library(XLConnect)

data <- NA
file <- file.choose() 

# Stichtag Volkszaehlung
stichtag.volkszaehlung <- readWorksheetFromFile(file, sheet = 1, header = FALSE, startRow = 6,
                              endRow = 18)
names(stichtag.volkszaehlung) <- c("Jahr",	"Insgesamt",	"Männer",	"Frauen",
                                   "Kinder 0 bis 14 Jahre",
                                   "Jugendliche 0 bis 19 Jahre",
                                   "Erwerb 15 bis 59 Jahre",
                                   "Erwerb 15 bis 64 Jahre",
                                   "Erwerb 20 bis 64 Jahre",
                                   "Altere 60 < ",
                                   "Altere 65 < ",
                                   "Altere 75 < ")

bevoelkerung.jahresbegin <- readWorksheetFromFile(file, sheet = 1, header = FALSE, startRow = 20,
                                                  endRow = 34)
names(bevoelkerung.jahresbegin) <- c("Jahr",	"Insgesamt",	"Männer",	"Frauen",
                                   "Kinder 0 bis 14 Jahre",
                                   "Jugendliche 0 bis 19 Jahre",
                                   "Erwerb 15 bis 59 Jahre",
                                   "Erwerb 15 bis 64 Jahre",
                                   "Erwerb 20 bis 64 Jahre",
                                   "Altere 60 < ",
                                   "Altere 65 < ",
                                   "Altere 75 < ")




bevoelkerung.jahresbegin$Anteil14 <- bevoelkerung.jahresbegin[,5]/bevoelkerung.jahresbegin[,2]*100
bevoelkerung.jahresbegin$Anteil65 <- bevoelkerung.jahresbegin[,10]/bevoelkerung.jahresbegin[,2]*100

# Aufgabe 5 ###################################################################

stichtage <- read.csv("data/stichtage.csv", header = TRUE, sep = ";")
stichtage <- stichtage[-4]
stichtage$stichtag <- ISOdate(stichtage$Jahr, stichtage$Monat, stichtage$Tag)

merged.zaehlung <- merge(stichtag.volkszaehlung, stichtage, by = "Jahr")


# absolute Änderung
merged.zaehlung$aenderung.absolut <- NA
for(i in 1:12){
  merged.zaehlung[i+1,]$aenderung.absolut <- merged.zaehlung[i+1,]$Insgesamt - merged.zaehlung[i,]$Insgesamt
}

# prozentuelle Änderung
merged.zaehlung$aenderung.relativ <- NA
for(i in 1:12){
  merged.zaehlung[i+1,]$aenderung.relativ <- ((merged.zaehlung[i+1,]$Insgesamt - merged.zaehlung[i,]$Insgesamt) / merged.zaehlung[i,]$Insgesamt)*100
}


# Differenz in Tagen
merged.zaehlung$diff.tage <- NA
for(i in 1:12){
  merged.zaehlung[i+1,]$diff.tage <- difftime(merged.zaehlung[i+1,]$stichtag, merged.zaehlung[i,]$stichtag, units = "days")
}

# Tägliche Änderung
merged.zaehlung$aenderung.taeglich <- merged.zaehlung$aenderung.relativ / merged.zaehlung$diff.tage

# Differenz in Jahren
merged.zaehlung$diff.jahre <- merged.zaehlung$diff.tage / 365

# Änderung pro Jahr
merged.zaehlung$aenderung.jaehrlich <- merged.zaehlung$aenderung.relativ / merged.zaehlung$diff.jahre

# Differenz in 10 Jahre
merged.zaehlung$diff.jahre10 <- merged.zaehlung$diff.jahre / 10

# Änderung in 10 Jahre
merged.zaehlung$aenderung.jaehrlich10 <- merged.zaehlung$aenderung.relativ / merged.zaehlung$diff.jahre10

plot(merged.zaehlung$aenderung.relativ, type = "l")
lines(merged.zaehlung$aenderung.jaehrlich10, type = "l", col = "red")

plot(merged.zaehlung$aenderung.jaehrlich, type = "l", col = "blue")
plot(merged.zaehlung$aenderung.taeglich, type = "l")

min(merged.zaehlung$aenderung.absolut, na.rm = TRUE)
max(merged.zaehlung$aenderung.absolut, na.rm = TRUE)

# größte / geringste Wachstum
merged.zaehlung[merged.zaehlung$aenderung.absolut == 63812,]$Jahr # 1971 - 1981 min
merged.zaehlung[merged.zaehlung$aenderung.absolut == 644465,]$Jahr # 1900 - 1910 max
