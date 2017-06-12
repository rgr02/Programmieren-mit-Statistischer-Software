###################################################
### Mehr zu Funktionen
###################################################

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


## Fehlermeldungen, Warnungen, Messages
median <- function(x, na.rm = TRUE) {
  if (missing(x)) 
    stop("x muss angegeben werden.")
  if (!na.rm && any(is.na(x))) {
    warning("x enthaelt NAs.")
    return(NA)
  }
  message("Calling median() from package stats.")
  stats::median(x, na.rm)
}

median(1:10)
median()
median(c(1:10, NA), na.rm = FALSE)

options("warn")
median(c(1:10, NA), na.rm = FALSE)

options(warn = -1)
median(c(1:10, NA), na.rm = FALSE)

options(warn = 2)
median(c(1:10, NA), na.rm = FALSE)

options(warn = 0)
suppressWarnings(median(c(1:10, NA), na.rm = FALSE))

## Spezifikation von Argumenten
median <- function(x, na.rm = TRUE) {
  if (missing(x)) 
    stop("x muss angegeben werden.")
  stopifnot(is.numeric(x))
  stopifnot(is.logical(na.rm) && length(na.rm) == 1)
  if (!na.rm && any(is.na(x))) {
    warning("x enthaelt NAs.")
    return(NA)
  }
  stats::median(x, na.rm)
}

location <- function(x, method = c("mean", "median")) {
  method <- match.arg(method)
  if (method == "mean")
    mean(x)
  else median(x)
}

location(rnorm(10), "m")
location(rnorm(10), 33)
location(rnorm(10), "med")
match.arg("med", c("mean", "median"))

## on.exit()
rsqrtnorm <- function(n, ...) {
  x <- rnorm(n, ...)
  ifelse(x > 0, sqrt(x), 0)
}
rsqrtnorm(10)

rsqrtnorm <- function(n, ...) {
  x <- rnorm(n, ...)
  suppressWarnings(ifelse(x > 0, sqrt(x), 0))
}
rsqrtnorm(10)

rsqrtnorm <- function(n, ...) {
  x <- rnorm(n, ...)
  old.opts <- options(warn = -1)
  on.exit(options(old.opts))
  ifelse(x > 0, sqrt(x), 0)
}
rsqrtnorm(10)
options("warn")


## Debugging
foo <- function() {
  cat("am anfang\n")
  x <- mean(1:5)
  cat("x =", x, "\n")
  x  
}
foo()

foo <- function() {
  cat("am anfang\n")
  bar(2)
}
bar <- function(x)
  x <- existiert.nicht

foo()
traceback()
debug(bar)
foo()
undebug(bar)

foo <- function(x) {
  for (i in 2:length(x)) {
    cat("i =", i, "\n")
    x[i] <- x[i-1] + x[i]
  }
  browser()
  x + existiert.nicht
}
foo(1:10)

x <- vector("list", 2)
x[[3]]
u <- vector("numeric", 3)
u
x <- list(rnorm(100), rnorm(100))
for (i in 1:3) {
  t <- try(x[[i]], silent = TRUE)
  if (is(t, "try-error"))
    is.na(u[i]) <- TRUE
  else u[i] <- mean(t)
}
u

u <- vector("numeric", 3)
u
x <- list(rnorm(100), rnorm(100))
for (i in 1:3) {
  u[i] <- tryCatch(mean(x[[i]]), silent = TRUE,
                   error = function(e) NA)
}
u


