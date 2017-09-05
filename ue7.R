rm(list = ls())

# Aufgabe 1 ################################################

lokation <- function(x, na.rm = T, type = c("mean", "median"),...){
  
  if (missing(x) || missing(type)) {
    stop("x bzw. type müssen angegeben werden.")
  } 
  
  # if any expression is false, an error is produced
  stopifnot(type %in% c("mean", "median"), is.numeric(x), is.logical(na.rm))
    
  type = match.arg(type)
  
  
  if(type == "mean"){
    mean(x,na.rm,...)
  } else {
    median(x,na.rm,...)
  }
} # lokation

# Testing
lokation(faithful$waiting)
lokation(faithful$waiting, type = "median")
is.na(faithful$waiting[3]) <- T
lokation(faithful$waiting, na.rm = F, type = "median")
# warum hier nicht default trim = 0
lokation(faithful$waiting, type = "mean")
lokation(faithful$waiting, type = "mean", trim = 0.1)

# Aufgabe 2 #####################################################

# Streuungsmaße
# Spannweite, Varianz, Variationskoeffizient, Standardabweichung
# Excel-SPSS Duller 3.Auflage S.103

streuung <- function(x = vector(mode = "numeric"), type = 1,  na.rm = F, ...){

  stopifnot(!missing(x),
            #!missing(type),
            type %in% c(1:4)) # Arguments complete?
  
  if(any(is.na(x))){
    warning("Der Datensatz beinhaltet NA Werte!")
    return(NA)
  }
  
  
  switch(type,
         return(max(x, na.rm) - min(x, na.rm)),      # Spannweite
         return(var(x, na.rm)),                      # Varianz
         # var benötigt numerischen Vektor, Matrix oder DataFrame
         # Keine Ahnung, warum der Fehler inkompatible Dimension auftritt
         # Ein Test des Parameter auf is.vector wertet auf True aus...
         # Ein Aufruf von var außerhalb der Funktion funktioniert
         
         return(abs(sd(x, na.rm))/mean(x,na.rm,...)),# Variationskoeffizient
         # Fehlermeldung bei trim. 
         # Überschreibt das Punktargument den default Eintrag für trim = 0 ??
         return (sd(x, na.rm)))                      # Standardabweichung
  
}#streuung

str(cars$speed)
is.vector(cars$speed) # True
dim(cars$speed)


streuung(cars$speed)
streuung(cars$speed, type=1)
streuung(cars$speed, type=2) # inkompatible Dimension

dim(cars$speed) # Null
var(cars$speed, na.rm = T) # funktioniert

streuung(cars$speed, type=3, trim = 0)
streuung(cars$speed, type=4)

streuung(cars$speed, type=5) # Fehler hier OK!

# Aufgabe 3 #####################################################

# Duller S.109
# Ist k für N+ definiert oder beschränkt auf 1-4

moment <- function (x, k=1, shift = FALSE, a = mean(x)){
  
  stopifnot(!missing(x))
  
  if(any(is.na(x))){
    warning("\nDaten enthalten NA Werte!\nNA's wurden für weitere Berechnungen entfernt")
    x <- na.omit(x)
  }
  
  if(!shift){
    a <- 0 # Überschreibt a und berechnet gewöhnliche Momente
  }        # a != 0 -> zentrales Moment
  
  return((sum((x-a)^k))/length(x))
  
}# moment

moment(faithful$waiting,3, shift = T)
moment(faithful$waiting,3, shift = F)

# Aufgabe 4 #####################################################

heron <- function(a=numeric(),n=integer()){
  
  # a eine reelle Zahl
  # x0 aus N, jedoch !0
  # n aus N
  
  stopifnot(!missing(a) && is.numeric(a),                  # Abbruch, wenn nicht alle
            !missing(n) && is.numeric(n) && n >= 0)        # Parameter übergeben werden
                         # is.integer(n) gibt einen Fehler # bzw. Datentypen nicht stimmen
                        

  # Wäre die Fehlerbehandlung für negative Zahlen
  # Kommentiert, weil Fehlerbehandlung in stopifnot aufgenommen wurde 
  
  # if (n < 0){
  #   warning("\nn muss positiv definiert sein\nFür weitere Berechnungen wird der Absolutwert verwendet")
  #   n <- abs(n)
  # }
  
  xn <- sample(1:a,1)
  
  for(i in 1:n){
    xn <- (xn + (a/xn))/2
  }
  return(xn)
}# heron

heron(37,10)
heron(9,4)
heron(37,10^6)

?cut
?ecdf
# Aufgabe 5 #####################################################

emp.dist.func <- function(x, na.rm = T, type = c("stetig", "diskret"), 
              breaks = quantile(x, seq(0,1,length = min(sqrt(length(x)),10)))){
  
  stopifnot(!missing(x),
            !missing(type),
            is.vector(x),
            type %in% c("stetig", "diskret"))
  
  type <- match.arg(type)
  
  if(type == "stetig"){
    x <- cut(x, breaks = breaks, include.lowest = T) # Parameter laut Angabe
  }
  return( function(x){
    stopifnot(is.vector(x), # wurde eigentlich schon geprüft
              is.numeric(x),
              length(x) != 1)
    return(ecdf(x))
  })
}# emp.dist.func

set.seed(1234)
x <- rnorm(200)
emp.dist.func(x, type = "stetig")
