###################################################
### R als Taschenrechner
###################################################

## Grundlegende arithmetische Operatoren und Funkionen
1 + 1
3 - 5
3 * 4
3 * 4 - 10 # Ein Kommentar.

2^2
2**2

8 %/% 5
10 %/% 5
8 %% 5
10 %% 5

max(1, 3, 4)
min(1, 3, 4)
abs(-4)
sqrt(2)
round(3.4)
round(3.5)
round(2.5)
floor(2.5)
ceiling(2.5)
sum(1, 2, 3)
prod(1, 2, 3)
log(1)
log10(1)
log2(1)
exp(1)
log(exp(1))
sin(pi / 2); cos(pi / 2); tan(pi / 2)
asin(0); acos(0); atan(0)


## Konstante
pi # Die Kreiszahl
1/0; -1/0 # Unendlich

exp(-1/0)

0/0        # Not a Number
NA         # Not Available - fehlende Werte
NULL       # Leere Menge


## Zuweisungen
x <- 10
x
x * x
y = 23
y <- 23
y


log(x = y)
x
log(x <- y)
x

log(y)
log(base = 10, y)
log(b = 10, y)


## Objekte
x <- 10
X <- 29
x12334546 <- 88


## Hilfe
?log
help("log")
help.search("logarithm", package = "base")

example(log)

?Syntax
help("Syntax")


## Workspace
ls()
rm(list = ls())
ls()


## Vektoren
c(1, 4, 7)
w <- c(3, 19, 7)
w
u <- 2:3
u
1:10

w + 2
w * 2
w + w
w * 1:6
w + u

exp(1:5)

max(1, 3, 5)
max(c(1, 3, 5))
max(c(1, 3, 5), 2)
pmax(c(1, 3, 5), 2)

## Folgen
?seq
1:6
seq(-5, 5, by = 2)
seq(from = 1, length.out = 10)
seq(from = 1, length.out = 10, by = 0.5)


## Wiederholung
?rep
rep(1:3, 2)
rep(1:3, each = 3)


