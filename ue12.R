rm(list = ls())


# Aufgabe 1 ################################################
?occupationalStatus
str(occupationalStatus)
plot(occupationalStatus)
occup <- as.data.frame(occupationalStatus)

# summary(occupationalStatus)
chi.square <- chisq.test(occupationalStatus)$statistic
chi.square
# 7 = min(8,8)-1
cramerV <- sqrt(chi.square / (sum(occup$Freq)*7))
cramerV #0.24 schwacher Zusammenhang ??

str(occup)
occup$origin <- as.numeric(occup$origin)
occup$destination <- as.numeric(occup$destination)

# Ohne Bindung
cor(occup$origin, occup$destination, method = "spearman")
# 0 würde kein Zusammenhang heißen ?!?

# mit Bindung -> Status des Sohnes in Abhängikeit von Status des Vaters
spearman.binding <- sum((occup$origin - mean(occup$origin)) *
                          (occup$destination - mean(occup$destination)), na.rm = T) /
  sqrt(sum(occup$origin - mean(occup$origin), na.rm = T)^2 *
         sum(occup$destination - mean(occup$destination), na.rm = T)^2)

spearman.binding
# Nan -> Division durch 0 


# Aufgabe 2 ################################################
#install.packages("ISwR", dependencies = T)
library(ISwR)

data("alkfos", package = "ISwR")
?alkfos

str(alkfos)
head(alkfos)
length(alkfos)

par(mfrow = c(3,1))

boxplot(alkfos[which(alkfos$grp == 1),-1],
        col = 1:length(alkfos-1),
        horizontal = T)
title(main = "Placebo", xlab = "Dosis", ylab = "Alkaline Phosphatase")


boxplot(alkfos[which(alkfos$grp == 2),-1],
        col = 1:length(alkfos-1),
        horizontal = T)
title("Tamoxifen", xlab = "Dosis", ylab = "Alkaline Phosphatase")

boxplot(alkfos[,-1],
        col = 1:length(alkfos-1),
        horizontal = T)
title(main = "Overall", xlab = "Dosis", ylab = "Alkaline Phosphatase")

# T-Test für unabhängige Stichproben

# sapply(alkfos[,-1], function(alkfos){
#   t.test(alkfos[which(alkfos$grp == 1),], alkfos[which(alkfos$grp == 2),])
# })

significance <- vector(length = length(alkfos))
for(i in 2:length(alkfos)){
 significance[i] <- t.test(alkfos[which(alkfos$grp == 1),i], alkfos[which(alkfos$grp == 2),i])$p.value
}
significance

summary(lm(alkfos$c0 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c3 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c6 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c9 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c12 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c18 ~ alkfos$grp, data = alkfos))
summary(lm(alkfos$c24 ~ alkfos$grp, data = alkfos))


# Aufgabe 3 ################################################

rbinorm <- function(n, mean=rep(0,2), sd=rep(1,2), rho = 0){
  
  stopifnot(!missing(n))
  
  # Matrix
  m <- matrix(nrow=n, ncol = 2)
  
  # rnorm(2*n, mean = mean, sd = sd),
  
  # Data
  m[,1] <- rnorm(n, mean = mean[1], sd = sd[1])
  m[,2] <- rnorm(n, mean = mean[2], sd = sd[2])
  
  # Transformation
  m[,2] <- rho*m[,1]+sqrt(1-rho^2)*m[,2] # 
  #m[,2] <- sd*m[,1]+sqrt(1-sd^2)*m[,2] # 
  #m[,2] <- mean*m[,1]+sqrt(1-mean^2)*m[,2] # 
  
  
  # Perfekte Korrelation ??
  
  # m[,1] <- sd*m[,2]+sqrt(1-sd^2)*m[,1]
  # m[,2] <- sd*m[,1]+sqrt(1-sd^2)*m[,2]
  # 
  # m[,1] <- mean*m[,2]+sqrt(1-mean^2)*m[,1]
  # m[,2] <- mean*m[,1]+sqrt(1-mean^2)*m[,2]
  
  return(m)
}

m <- rbinorm(1000)
plot(m) # perfekte Korrelation?

sd(m[,1])
mean(m[,1])
sd(m[,2])
mean(m[,2])

cor(m)
cov(m)

# Keine Ahnung, wie weiter zu transformieren ist.

# Aufgabe 4 ################################################

weighted.sd <- function(x, weight,na.rm = T){
  
  stopifnot(!missing(x),
            !missing(weight),
            is.numeric(x),
            is.numeric(weight))
  
  if (!na.rm && any(is.na(x))) {
    warning("x enthaelt NAs.")
    return(NA)
  } else {
    return(sd(x*weight, na.rm = na.rm)) 
  }
}# weighted.sd

x <- sample(1:100, 10, replace = T)
weight <- c(1)

weighted.sd(x, weight)
sd(x)                          # Ergibt die selben Werte

weight <- sample(1:100, 10)
weighted.sd(x,weight = weight) # Schaut an dieser Stelle gut aus

# Aufgabe 5 ################################################

# install.packages("laeken", dependencies = T)
library(laeken)
library(dplyr)

data("eusilc", package = "laeken")
head(eusilc)

# Variablenbeschreibung
# http://www.forschungsdatenzentrum.de/bestand/eu-silc/fdz_eu-silc_eurostat_engl_nutzerdatensatz_2007-01.pdf

# Gewichte
pers.gew <- eusilc$rb050
haushalt.gew <- eusilc$db090

pers.gew
haushalt.gew

# Haushaltsgröße
mean(eusilc$hsize) # 3.3 Personen / HH
sd(eusilc$hsize)   # Schwankung +- 1.5 Personen
hist(eusilc$hsize)

weighted.mean(eusilc$hsize, haushalt.gew) # 3.12 pers / HH
weighted.sd(eusilc$hsize, haushalt.gew)


# Bevölkerungsanzahl
select(eusilc, db040, hsize) %>%
  group_by(db040) %>%
  summarise(sum(hsize))

select(eusilc,
       db040, # Bundesland
       db090, # Haushaltsgewicht
       hsize) %>%
  group_by(db040) %>%
  summarise(sum(hsize*db090))

# Geschlechtsverteilung
table(eusilc$rb090)
pie(table(eusilc$rb090), col = c("blue","red"))

