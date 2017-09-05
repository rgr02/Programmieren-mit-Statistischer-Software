rm(list = ls())
setwd("C:/Users/Rudi/_Studium/_SS2017/Programmieren R/ue4")

# Aufgabe 1 FIBONACCI #########################################################
fibonacci <- function(x)
  ifelse(x <= 1, 1, fibonacci(x - 1) + fibonacci(x - 2)) #Definition von Wikipedia

fib <- c()
for (i in 1:30) {
  if (length(fib) <= 30) {
    fib <- c(fib, fibonacci(i))
  }
  else {
    break
  }
}
fib


# Aufgabe 2 SWISS #############################################################
data(swiss)

trim <- c()
for (i in 1:length(names(swiss)))
  trim <- c(trim, mean(swiss[, i], trim = 0.1))
trim

#for(i in 1:length(names(swiss))) swiss[which(swiss[,i] %in%  boxplot.stats(swiss[,i])$out),] <- NA

for (i in 1:length(names(swiss))) {
  if (i == 1) {
    if (length(boxplot.stats(swiss$Fertility)$out) != 0)
      swiss[which(swiss$Fertility %in%  boxplot.stats(swiss$Fertility)$out),]$Fertility <-
        NA
  } else if (i == 2) {
    if (length(boxplot.stats(swiss$Agriculture)$out) != 0)
      swiss[which(swiss$Agriculture %in%  boxplot.stats(swiss$Agriculture)$out),]$Agriculture <-
        NA
  } else if (i == 3) {
    if (length(boxplot.stats(swiss$Examination)$out) != 0)
      swiss[which(swiss$Examination %in%  boxplot.stats(swiss$Examination)$out),]$Examination <-
        NA
  } else if (i == 4) {
    if (length(boxplot.stats(swiss$Education)$out) != 0)
      swiss[which(swiss$Education %in%  boxplot.stats(swiss$Education)$out),]$Education <-
        NA
  } else if (i == 5) {
    if (length(boxplot.stats(swiss$Catholic)$out) != 0)
      swiss[which(swiss$Catholic %in%  boxplot.stats(swiss$Catholic)$out),]$Catholic <-
        NA
  } else {
    if (length(boxplot.stats(swiss$Infant.Mortality)$out) != 0)
      swiss[which(swiss$Infant.Mortality %in%  boxplot.stats(swiss$Infant.Mortality)$out),]$Infant.Mortality <-
        NA
  }
}

colMeans(swiss, na.rm = TRUE)
trim

# Aufgabe 3 PRIMZAHLEN ########################################################
n <- 200
sieve <- c(2:n)

nr <- 2
prim <- c()

for (i in sieve) {
  prim <- c(prim, sieve[1])
  sieve <- sieve[-which(sieve %% nr == 0)] # delete multiples
  nr <- sieve[1] # next entry in sieve = new nr
}

prim <- prim[-which(is.na(prim))] # deleting NA's
prim

# Aufgabe 4 PRIMZAHLPAARE #####################################################
primPairs <- c()

for (i in 1:(length(prim) - 1)) {
  if (prim[i + 1] - prim[i] == 2)
    primPairs <- c(primPairs, c(prim[i], prim[i + 1]))
}
primPairs

# Aufgabe 5 Pseudozufallszahlen ###############################################
n <- 10000
y1 <- 10
y2 <- 100

primes <- c(2, 3, 5, 7, 11, 13, 19, 23, 29, 31)
prim <- prod(primes) + 1

y <- c(y1, y2)

for (i in 3:n) {
  y <- c(y, (y1 + y2) %% prim)
  y1 <- y2
  y2 <- y[i]
}

x <- y / (prim - 1)
range(x)

# Test
plot(density(x))
ks.test(x = x, y = "punif")
plot(ecdf(x = x))

# Test iid. Kein linearer Zusammenhang. Sagt nichts über nichtlinearen Zshg aus. 
cor(x[-1],x[-length(x)])
