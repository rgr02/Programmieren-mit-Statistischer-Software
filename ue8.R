# Momente einer Verteilung für Daten interessant
# Passen die Daten zu meiner Verteilung?

# Aufgabe 1 ####################################################################

X <- rnorm(10000, mean = 1, sd = sqrt(2))
U <- runif(10000, -1 + x, 1 + x)
Y <- X + U

# mean
emp.mean1 <- mean(Y)
emp.mean2 <- mean(X) + mean(Y)
print(c(emp.mean1, emp.mean2))

# var
var.y1 <- var(Y)
var.y2 <- var(X) + var(U)
print(c(var.y1, var.y2))


# Aufgabe 2 ####################################################################

# Poissonverteilung unendlich, positiver Bereich
# Binominal Münzwurf n-mal. Anzahl der Erfolge. Wertebereich 0 bis n
# Bernoulli 0,1

# Prüfen auf negative Wahrscheinlichkeiten
# 

esample <-
  function (value,
            prob = (rep(1 / (length(value)), length(value))),
            g = function(x)
              x) {
    
    if (length(value) != length(prob)){
      stop("Not every value can be matched to a probensity")
    }
    
    # istrue
    if (!(all.equal(sum(prob), 1))) {
      stop ("The distribution function must not be greater than 1")
    }
    expectation.value <- 0
    for (i in 1:length(value)) {
      expectation.value <-  expectation.value + prob[i] * g(value[i])
    # Vektorisieren prop * g aber kein Wissen ob g eine vektorisierte Funktion ist
    }
    return (expectation.value)
  }

n <- 10
esample(1:n)
esample(0:n, prob = dpois(0:n, 1))
esample(
  0:n,
  g = function(x)
    x ^ 2
)

# Aufgabe 3 ####################################################################

rtnorm <- function (n, mean, sd, lower, upper) {
  samp <- rnorm(n = 2 * n, sd = sd, mean = mean)
  samp <- samp[samp > lower & samp < upper]
  
  if (length(samp) < n) {
    stop("too less observations")
  }
  return(samp[1:n])
}

set.seed(1234)
test <- rtnorm(10000, 0, 1, 0, Inf)
mean(test)

# Aufgabe 4 #################################################################################
test.rtnorm <- function(m, n) {
  success <- 0
  for (i in 1:m) {
    try(rtnorm(n, 0, 1, 0, Inf), success <- success + 1)
  }
  return (success / m)
}

test.rtnorm(200, 10)
test.rtnorm(2000, 100)
test.rtnorm(20000, 100)
test.rtnorm(200000, 10)

