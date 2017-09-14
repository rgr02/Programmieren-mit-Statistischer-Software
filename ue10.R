rm(list = ls())

# Aufgabe 1 #########################################################################

png("boxplot.png") # Device öffnen
boxplot(iris)      # Plotten
dev.off()          # Device schließen

# Aufgabe 2 #########################################################################

data("trees", package = "datasets")
str(trees)
head(trees)

pairs(trees) # Paarweise Streudiagramm

# Untermengen geteilt nach Height
small.trees <- trees[which(trees$Height <= mean(trees$Height)),]
big.trees <- trees[which(trees$Height > mean(trees$Height)),]

pdf(file = "VU-Grid.pdf")

par(mfrow =c(1,2))

plot (small.trees$Girth~small.trees$Volume, 
      xlim = c(0,70), ylim= c(0,20), 
      xlab = "Volumen", 
      ylab = "Umfang", 
      main = "Volumen / Umfang\nkleine Bäumen")

plot (big.trees$Girth~big.trees$Volume,
      xlim = c(0,70),
      ylim= c(0,20),
      xlab= "Volumen",
      ylab ="Umfang",
      main = "Volumen / Umfang\ngroße Bäumen")

dev.off()

# Aufgabe 3 #########################################################################

str(UCBAdmissions)
mosaicplot(UCBAdmissions)

prop.table(UCBAdmissions)
admissions <- as.data.frame(UCBAdmissions)

library(dplyr)
rel.freq.gender.dept <- select(admissions, Admit, Gender, Dept, Freq) %>%
  group_by(Dept, Gender) %>%
  summarise(relative.H = sum(Freq)/sum(admissions$Freq)*100)

rel.freq.gender.dept

rel.freq.gender <- select(admissions, Admit, Gender, Dept, Freq) %>%
  group_by( Gender) %>%
  summarise(relative.H = sum(Freq)/sum(admissions$Freq)*100)

rel.freq.gender

plot(admissions$Gender ~ admissions$Admit, data = admissions)


# Aufgabe 4 #########################################################################

visualize_dist <- function(name, dist_par, x, discrete = FALSE, ...) {
  
}





# Aufgabe 5 #########################################################################

rtrnorm <- function(n, mean = 0, sigma = 1, lower = -Inf, upper = Inf) {
  
  # Gleichverteilte Zufallsvariable
  u <- runif(n,min=0,max=1)
  
  # https://en.wikipedia.org/wiki/Truncated_normal_distribution
  e <- (u - mean(u))/sd(u)
  a <- (min(u)-mean(u))/sd(u)
  b <- (max(u)-mean(u))/sd(u)
  z <- pnorm(b) - pnorm(a)
  
  x <-  (pnorm(e) - pnorm(a)) / z
  
  # Quantilsfunktion = inverse CDF
  # https://en.wikipedia.org/wiki/Quantile_function
  x <- qnorm(x, mean = mean, sd = sigma) 
  
  return(x)
}

x <- rtrnorm(1000,3,1,-5,4)
hist(x)
plot(density(x))


