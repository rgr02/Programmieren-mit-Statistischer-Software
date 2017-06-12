###################################################
### Funktionen
###################################################

## Funktionsaufruf
##
## funktionsname(Argument1 = Wert1, Argument2 = Wert2)#

x <- c(1, 10, NA)
median(x)
median(x, TRUE)
median(na.rm = TRUE, x = x)
median(na.rm = TRUE, x)
median(n = TRUE, x)

## Eigene Funktionen definieren
##
## MeineFunktion <- function(Argumente) {
##   # Befehlsfolge
## }

new.median <- function(x, na.rm = TRUE) {
  median(x, na.rm)
}
new.median
new.median(x)
new.median(x, FALSE)

new.median <- function(x, na.rm = TRUE) {
  if (!na.rm) {
    if (any(is.na(x)))
      return(NA)
  }
  invisible(median(x, na.rm))
}
new.median(x, FALSE)
new.median(x)
y <- new.median(x)
y

## Das "Dreipunkte"-Argument
punkte <- function(x, ...) {
  matrix(x, ...)
}
a <- c(3, 5, 7, 2)
punkte(a)
punkte(a, ncol = 2, byrow = TRUE)

## Lazy evaluation
faul <- function(x, rechnen = TRUE) {
  if (rechnen) x <- x + 1
  print(a)
}
rm(a)
faul((a <- 3), rechnen = FALSE)
faul(a <- 3)

aufruf <- function(x) {
  return(list(Aufruf = substitute(x), Wert = x))
}
aufruf(1 + 2)

## Umgebungen und deren Regeln
search()

einfach <- function(x) {
  med <- median(x)
  return(list(x = x, median = med))
}
einfach(1:3)

x <- 5
scope <- function(do.it = TRUE) {
  if (do.it) x <- 3
  innen <- function()
    print(x)
  innen()
}
scope()
scope(FALSE)

l.scope <- function() {
  nur.hier <- "Ich bin nur hier definiert!"
  innen <- function() {
    print(nur.hier)
  }
  return(innen)
}
Ausgabe <- l.scope()
ls()
Ausgabe
testen <- function() {
  print(nur.hier)
}
testen
testen()
Ausgabe()
ls(environment(Ausgabe))

## Namespaces
beispiel <- function(x) {
  sin(2 * pi * x)
}
beispiel(1:5)
sin <- sum
pi <- 0.5
beispiel(1:5)

rm(sin, pi)
beispiel <- function(x) {
  base::sin(2 * base::pi * x)
}
beispiel(1:5)
sin <- sum
pi <- 0.5
beispiel(1:5)

## Zuweisungen
rm(list = ls())
zuweisen <- function() {
  a <- 1 # lokale Zuweisung
  b <<- 2 # Zuweisung ins .GlobalEnv
  assign("d", 3, pos = ".GlobalEnv")
  return(c(a, b, d)) # a lokal; b und d aus dem Workspace
}
zuweisen()
ls()

rm(list = ls())
for (i in 1:3) {
  assign(paste("Buchstabe", i, sep = ""), LETTERS[i])
}
ls()
Buchstabe1
for(i in 3:1) {
  print(get(paste("Buchstabe", i, sep = "")))
}


