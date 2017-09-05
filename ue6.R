# Aufgabe 1 - Quantile #######################################################


# x(k) <- 
# wenn N · α keine ganze Zahl ist 
# k ist dann die auf N · α folgende ganze Zahl

# 1/2 * sum(x(k) + x(k+1)) <-
# wenn N · α eine ganze Zahl ist
# dann ist k = N · α

# Alpha Quantile def nicht ganz eindeutig...
# P(x > a) >= 1-a
# P(x < a) >= a

# P streng monoton steigend... egal

quantile <- function(x, alpha){
  if(TRUE %in% is.na(x) | !alpha %in% seq(0,1,0.01)){
    print("X enthält Missings bzw. alpha hat keinen Wert zwischen [0,1]")
    return(-1)
  }
  
  if((length(x)*alpha)%%1!=0){
    k<-ceiling(length(x)*alpha)
    return(sort(x)[k])
  }else{
    k <- length(x)*alpha
    return(sum(sort(x)[k], sort(x)[k+1])/2)
  }
}
quantile(1:100,0.3)
quantile(1:100, -0.1)

stats::quantile(1:100,0.3)

# 2 Aufgabe Lottoschein ####################################################


# 3 Aufgabe Binominalkoeffizient ###########################################

binominalkoeffizient <- function(n,m){
  return(factorial(n)/(factorial(m)*factorial(n-m)))
}

binominalkoeffizient(4,2)
binominalkoeffizient(50,20)
binominalkoeffizient(500,200)

choose(500,200)
paste()

# 4 Aufgabe Verbesserter Binominalkoeffizient ##############################
binominalkoeffizient2 <- function(n,m){
  return (exp(sum(log(1:n))- sum(log(1:m))- sum(log(1:(n-m)))))
}

binominalkoeffizient2(4,2)
binominalkoeffizient2(50,20)
binominalkoeffizient2(500,200)


# 5 Aufgabe Spearman Korrelation ###########################################

# besser:
# dataframe übergeben
# zeilen mit na löschen

spearman <- function(x,y, na.rm = TRUE){
  
  # NA
  if(na.rm){
    x <- x[!is.na(x)]
    y <- y[!is.na(y)]
  }else if (any(is.na(x))|any(is.na(y))){
    return(NA)
  }
  
  # length
  if(length(x)!= length(y)){
    if(length(x)>length(y)){
      x <- x[1:(length(y))]
    }else{
      y<- y[1:(length(x))]
    }    
  }
  
  # Ties
  if(length(x)>length(unique(x))|length(y)> length(unique(y))){
    return(NA)
  }
  
  # Formel funktioniert nur ohne Bindungen. Ansonst andere Formel
  spearman <- 1-((6*sum((rank(x)-rank(y)^2))/ (length(x)*(length(x)^2-1))))
  return(spearman)
  
}

spearman(swiss$Fertility, swiss$Agriculture)
x <- subset(swiss, Fertility > 70)
spearman(x$Fertility, x$Agriculture)
spearman(x$Fertility, x$Agriculture[1:20])

.Machine
