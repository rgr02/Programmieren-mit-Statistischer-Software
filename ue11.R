rm(list = ls())

# Aufgabe 1 ####################################################################

rpoisson <- function(n,lambda){
  
  stopifnot(!missing(n),
            !missing(lambda))
  
  return (mean(rpois(n,lambda)))
}

rpoisson(10,1)


n <- c(10,100,1000,10000)
lambda <- c(0.1,1,10,100)
results <- matrix(nrow = 5000, ncol = 4)
computational.time <- vector(length = 4)

for(i in 1:4){
  eval.time <- system.time(
    results[,i] <- replicate(5000,rpoisson(n = n[i], lambda = lambda[i]))
  )
  computational.time[i] <- eval.time
}


means <- apply(results,2,mean)
variances <- apply(results, 2, var)

summarization <- as.data.frame(rbind(means,variances,computational.time))
rownames(summarization) <- c("emp.Mittelwerte", "emp.Varianz", "Rechendauer")
colnames(summarization) <- c("Versuch 1", "Versuch 2", "Versuch 3", "Versuch 3")

# Lamda = E(x) & Var(x) bei Poisson

# Aufgabe 2 ####################################################################

sillyzv <- function(n, k, mean, sd) {
  
  mat <- matrix(nrow = n, ncol = k)
  
  for(i in 1:k){
    # Hier wäre eine Fehlerprüfung sehr ineffizient
          mat[,i] <- rnorm(n, mean = mean, sd = sd)
  }
  return(mat)
}

hist(sillyzv(10^4,100,1:100,1:100))
summary(sillyzv(10^4,100,1:100,1:100))

# Aufgabe 3 ####################################################################
smartzv <- function(n,k,mean = 0, sd = 1){
  
  stopifnot(!missing(n),
            !missing(k),
            k == length(mean),      # Gleich lange Vektoren
            k == length(sd),
            k %% length(mean) == 0, # Länge ein vielfaches?
            k %% length(sd) == 0)
  
  return(replicate(n = k ,rnorm(n,mean = mean, sd = sd), simplify = "matrix"))
}

hist(smartzv(10^4,100,1:100,1:100))

set.seed(0606)
t1 <- system.time(x1 <- sillyzv(10^4,100,1:100,1:100))

set.seed(0606)
t2 <- system.time(x2 <- smartzv(10^4,100,1:100,1:100))

t1/t2
all.equal(x1,x2)

# Aufgabe 4 ####################################################################


srcount <- function(n,b){
  
  stopifnot(!missing(n),
            !missing(b),
            is.numeric(n),
            is.numeric(b)
  )
  
  ziehungen <- replicate(b, sample(1:n,n,replace = T), simplify = "matrix")
  # table()
  # 
  # for(i in 1:b){
  #   buf <- sample(n,length(n), replace=TRUE)
  #   buf <- unique(buf)
  #   out[i]<- length(buf)/length(n)
  # }
  return(table(ziehungen))

}

begin <- proc.time()

# Kann man hier srcount parallel Ausführen?
srcount(6325,4000)

end <- proc.time()
time <- end - begin
time

# Aufgabe 5 ####################################################################
rm(list = ls())
library(dplyr)
library(MASS)
data("genotype", package = "MASS")

str(genotype)
head(genotype)

dim(genotype)
# 61 Beobachtungen und 3 Variablen

result.set <- select(genotype, Litter, Mother, Wt) %>%
  group_by(Litter, Mother) %>%
  summarise(beobachtung = n(),
            mean.wt = round(mean(Wt),2))

model <- lm(result.set$mean.wt ~ result.set$Litter + result.set$Mother, data = result.set)
summary(model)

png(filename = "weight.genotype.png")
par(mfrow = c(2,1))
boxplot(mean.wt ~ Mother, data = result.set, col = 1:4)
title(main = "Weight / Mother", xlab = "Genotype", ylab = "Weight")
boxplot(mean.wt ~ Litter, data = result.set, col = 1:4)
title(main = "Weight / Litter", xlab = "Genotype", ylab = "Weight")
dev.off()

# Mosaicplot
# mosaicplot(result.set$Mother ~ result.set$Litter, col = "red", margin = result.set$mean.wt)
