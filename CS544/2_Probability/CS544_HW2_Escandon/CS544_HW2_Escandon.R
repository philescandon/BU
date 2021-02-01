## ----include=FALSE--------------------------------------------------------------------
library(prob)
library(tidyverse)
library(glue)


## ----1a-------------------------------------------------------------------------------
# Get my population figures
totalPop <- 10000
ageGroupPop <- c(4250,2850,1640,1260)
byPercent <- ageGroupPop/totalPop 

# Get my BMI figures

bmiGT30 <- c(1062,1710,656,189)
bmiGT30Percent <- bmiGT30 / ageGroupPop

df <- data.frame(byPercent,bmiGT30Percent)
df




## ----1a2------------------------------------------------------------------------------
# P(B) = P(B|A1)*P(A1)   +  P(B|A2)*P(A2)  + P(B|A3)*P(A3)
pb <- sum(byPercent*bmiGT30Percent)
glue("Probability of randomly chosen person having a BMI > 30 is ",pb)


## ----1b-------------------------------------------------------------------------------
# P(A1|B) = P(B|A1)* P(A1)/P(B)

PA1B=(byPercent * bmiGT30Percent)[1] / pb
glue("Probability of randomly chosen person having a BMI>30 being in the 18-34 
     age group is ", round(PA1B,digits=4))




## ----1c-------------------------------------------------------------------------------
PA2B=(byPercent * bmiGT30Percent)[2] / pb
glue("Probability of randomly chosen person having a BMI>30 being in the 35-49 
     age group is ",round(PA2B,digits= 4))



## ----1d-------------------------------------------------------------------------------
PA3B=(byPercent * bmiGT30Percent)[3] / pb
glue("Probability of randomly chosen person having a BMI>30 being in the 50-64 
     age group is ", round(PA3B,digits = 4))



## ----1e-------------------------------------------------------------------------------
PA4B=(byPercent * bmiGT30Percent)[4] / pb
glue("Probability of randomly chosen person having a BMI>30 being in the 50-64 
     age group is ", round(PA4B,digits = 4))



## ----2Setup, include=FALSE------------------------------------------------------------
library(prob)


## ----2a-------------------------------------------------------------------------------
## Roll 3 dice and see all of the outcomes
S<- rolldie(3, makespace = TRUE)
dieSum <- subset(S,(X1+X2+X3>10) )
Prob(dieSum)

#check
# dieSum <- sum(dieSum$probs)
# head(dieSum,n=3)



## ----2b-------------------------------------------------------------------------------
## Roll 3 dice and see all of the outcomes
S<- rolldie(3, makespace = TRUE)
A<-subset(S,(X1==X2) & (X1==X3) & (X2 == X3))
Prob(A)

# check
# sum(A$probs)
# head(A,n=3)


## ----2c-------------------------------------------------------------------------------
S<- rolldie(3, makespace = TRUE)
# create 3 subsets and take the union

# X1==X2, X3 not included
t<- subset(S,X1==X2 & X1 != X3)

# X1==X3, X2 not included
u<- subset(S,X1==X3 & X1 != X2)

# X2==X3, X1 not included
v<- subset(S,X2==X3 & X1 != X2)

Prob(union(t,u,v))

#check
# union(t,u,v)



## ----2d-------------------------------------------------------------------------------
S<- rolldie(3, makespace = TRUE)
#S
dieNotEqual <- subset(S, (X1 != X2) & (X1 != X3) & (X2 != X3) )
Prob(dieNotEqual)

# sum(dieNotEqual$probs)
# head(dieNotEqual,n=3)


## ----2e-------------------------------------------------------------------------------
S<- rolldie(3, makespace = TRUE)

# X1==X2 or X1==X3 or X2==X3
A <- subset(S, (X1 == X2) | (X1 == X3) | X2 == X3  )
B <- subset(S,(X1 + X2 + X3 > 10))
Prob(intersect(A,B))

#check
# u<- intersect(A,B)
# head(u,n=3)


## ----notes, eval=FALSE, include=FALSE-------------------------------------------------
## # In order to use the debugger you must first create an R file from your
## # markdown and run the debugger from the R file.
## # use knitr::purl( <markdown> )
## #


## ----3Sum-----------------------------------------------------------------------------
#' sum_of_first_N_odd_squares
#'
#' @param x Int that defines the first X odd numbers to be operated on
#'
#' @return Sum of the squares of the odd values
#' @export
#'
#' @examples  sum_of_first_N_odd_squares - returns 1^2 + 3^2 + 5^2 + 7^2 + 9^2 = 165
sum_of_first_N_odd_squares <- function(x){
#create a seq for x - but DOUBLE the size since we are taking every other one
  x<-seq(1:(x*2))

  #create an empty vector for our output
  k<- c() 
  for(n in x){
    if (n %% 2 == 1){  # n %% 2 == 1 searches for the odd number
      k <- c(k,n)      # and stores them in k
    }
  }
  return (sum(k^2))
}


## -------------------------------------------------------------------------------------
sum_of_first_N_odd_squares(2)
sum_of_first_N_odd_squares(5)
sum_of_first_N_odd_squares(10)



## ----3sumV2---------------------------------------------------------------------------
#' sum_of_first_N_odd_squaresV2
#'
#' @param x Int that defines the first X odd numbers to be operated on
#'
#' @return Sum of the squares of the odd values
#' @export
#'
#' @examples  sum_of_first_N_odd_squares - returns 1^2 + 3^2 + 5^2 + 7^2 + 9^2 = 165
sum_of_first_N_odd_squaresV2 <- function(x){
#create a seq for x double the size since we are taking every other one
  x<-seq(1,(x*2),2)
  return (sum(x^2))
}


## -------------------------------------------------------------------------------------
sum_of_first_N_odd_squaresV2(2)
sum_of_first_N_odd_squaresV2(5)
sum_of_first_N_odd_squaresV2(10)



## ----4 Read In Data-------------------------------------------------------------------
dow <- read_csv("http://people.bu.edu/kalathur/datasets/DJI_2020.csv",col_types = list(col_character(),col_double()))
head(dow)



## ----4a-------------------------------------------------------------------------------
sm <- summary(dow$Close)
names(sm)<-c("Min","Q1","Q2","Mean","Q3","Max")
sm  


## ----4a2------------------------------------------------------------------------------

paste("First Quartile variation is ",sm[2]-sm[1])
paste("Second Quartile variation is ",sm[3]-sm[2])
paste("Third Quartile variation is ",sm[5]-sm[3])
paste("Fourth Quartile variation is ",sm[6]-sm[5])




## ----4b-------------------------------------------------------------------------------
minDowClose <-min(dow$Close)
row_minDowClose <-which(dow$Close == min(dow$Close) )
date_minDowClose<- dow$Date[row_minDowClose]

paste("The minimum Dow value of ",minDowClose," is at row ",row_minDowClose," on ",date_minDowClose)



## ----4c-------------------------------------------------------------------------------
# Use the min values from above
# minDowClose
# date_minDowClose
# row_minDowClose

#end of the vector in use
e <- dim(dow)[1]

#slice the vector to only get a subset
w <- slice(dow, row_minDowClose: e)
maxDowClose <- max(w$Close)
# from the subset - select the max $Close value
hiRow <- which(w$Close==max(w$Close))
w[hiRow,1]

gain <-  (maxDowClose / minDowClose) - 1

paste("I would sell on ",w[hiRow,1]," when DOW is at",max(w$Close)," for a gain of ",round(gain,digits = 4)*100,"%")


## ----4d-------------------------------------------------------------------------------
# Create my new vector
cl<-diff(dow$Close)
# comparing lengths.. one is smaller than the other
length(cl)
length(dow$Close)

# Prepend a zero
cl<-prepend(cl,0)
length(cl)

# Add the diff column to the dow dataframe
dow$DIFFS<-cl
head(dow,n=6)



## ----4e-------------------------------------------------------------------------------

# Close higher

paste(length(dow$DIFFS[(dow$DIFFS>0)])," days DOW close higher than previous day")

# Close lower



paste(length(dow$DIFFS[(dow$DIFFS<0)])," days DOW closed lower than previous day")


## ----4f-------------------------------------------------------------------------------
dow[(dow$DIFFS>1000),]

