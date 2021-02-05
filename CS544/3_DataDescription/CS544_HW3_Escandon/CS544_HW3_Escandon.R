## ----include=FALSE-------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(corrplot)
library(RColorBrewer)

setwd("~/BU/CS544/3_DataDescription/CS544_HW3_Escandon")


## ------------------------------------------------------------------------------------------------------------------------------------------
df <- read.csv("http://people.bu.edu/kalathur/datasets/myPrimes.csv")


## ------------------------------------------------------------------------------------------------------------------------------------------
dim(df)
colnames(df)
head(df)
tail(df)
summary(df)
dplyr::count(df,df$First)
dplyr::count(df,df$Last)


## ----1a------------------------------------------------------------------------------------------------------------------------------------
#barplot(table(df$LastDigit),col = 'green')
table(df$LastDigit) %>% barplot(col = 'green')



## ----1b------------------------------------------------------------------------------------------------------------------------------------
# data <- df$FirstDigit
# table(data)
# barplot( table(data),col = 'Blue')
table(df$FirstDigit) %>% barplot(col='blue')
#table(df$FirstDigit) %>% barplot(col = 'gold')
count(df,df$FirstDigit)%>%table()%>%barplot()


## ----2-------------------------------------------------------------------------------------------------------------------------------------
us_quarters <- read.csv("http://people.bu.edu/kalathur/datasets/us_quarters.csv")



## ----2Basic--------------------------------------------------------------------------------------------------------------------------------
dim(us_quarters)
colnames(us_quarters)
head(us_quarters)
tail(us_quarters)

#might be easier to view this 'wide' mint data as a single column
gQuarters<-gather(us_quarters,Mint,qrtCount,c(DenverMint,PhillyMint))

# Now filter:
pm<- filter(gQuarters,Mint=="PhillyMint")
dm<- filter(gQuarters,Mint=="DenverMint")
sum(gQuarters$qrtCount)/4



# ggplot(g,aes(x=State, y = qrtCount, color = Mint))+
#   geom_point( )+
#     theme(axis.text.x = element_text(angle = 80, hjust = 1))


## ----2a------------------------------------------------------------------------------------------------------------------------------------
# Highest
# Find the index of the max
c<- which(max(us_quarters$DenverMint) == us_quarters$DenverMint)
state<-us_quarters$State[c]
paste("Denver Mint: State with the most printed quarters: ", state)

d<- which(min(us_quarters$DenverMint) == us_quarters$DenverMint)
state<-us_quarters$State[d]
paste("Denver Mint: State with the least printed quarters: ", state)

e<- which(max(us_quarters$PhillyMint) == us_quarters$PhillyMint)
state<-us_quarters$State[e]
paste("Philly Mint: State with the most printed quarters: ", state)

f<- which(min(us_quarters$PhillyMint) == us_quarters$PhillyMint)
state<-us_quarters$State[f]
paste("Philly Mint: State with the least printed quarters: ", state)






## ----eval=FALSE, include=FALSE-------------------------------------------------------------------------------------------------------------
## ## finding the indices
## #out <- boxplot.stats(dat$hwy)$out
## #out_ind <- which(dat$hwy %in% c(out))
## 


## ----outliers, eval=FALSE, include=FALSE---------------------------------------------------------------------------------------------------
## dat <- ggplot2::mpg
## 
## out <- boxplot.stats(dat$hwy)$out
## out_ind <- which(dat$hwy %in% c(out))
## out_ind
## 
## 
## u<-boxplot(dat$hwy,
##   ylab = "hwy",
##   main = "Boxplot of highway miles per gallon"
## )
## 
## mtext(paste("Outliers: ", paste(out, collapse = ", ")))
## 
## 
## ggplot(dat) +
##   aes(x = "", y = hwy) +
##   geom_boxplot(fill = "#0c4c8a") +
##   theme_minimal()
## 


## ----2b------------------------------------------------------------------------------------------------------------------------------------
# the number of quarters is in THOUSANDS
totalQuarters <- sum(us_quarters$DenverMint, us_quarters$PhillyMint)
totalDollars <- totalQuarters / 4
paste("Dollar amount of all quarters printed from both mints is $",totalDollars," dollars")


## ----2c------------------------------------------------------------------------------------------------------------------------------------
# transpose but leave out states
# help from https://www.r-graph-gallery.com/210-custom-barplot-layout.html
usq_t<-t(us_quarters[-1])


barplot(usq_t,names=us_quarters$State,las = 3,beside= TRUE,col = c("red","blue"))




## ----2c2-----------------------------------------------------------------------------------------------------------------------------------

#us_quarters %>% gather()

# ggplot(data = SprintTotalHours %>% gather(Variable, Hours, -Sprint), 
#        aes(x = Sprint, y = Hours, fill = Variable)) + 
#     geom_bar(stat = 'identity', position = 'dodge')





## ----2d------------------------------------------------------------------------------------------------------------------------------------
options(scipen = 1)
#plot(us_quarters$DenverMint)
#plot(xus_quarters$PhillyMint)


ggplot(data = us_quarters) + 
  geom_point(mapping = aes(x = State, y= DenverMint,col='red')) +
  geom_point(mapping = aes(x = State, y= PhillyMint,col='blue'))+
  theme(axis.text.x = element_text(angle = 80, hjust = 1))






## ----2e------------------------------------------------------------------------------------------------------------------------------------
par( mfrow=c(1,2))
boxplot(us_quarters$DenverMint,horizontal = TRUE,xaxt = "n", xlab = "Denver Mint", col = "blue")
axis(side = 1, at = fivenum(us_quarters$DenverMint), labels = TRUE)

boxplot(us_quarters$PhillyMint, horizontal = TRUE,xaxt = "n", xlab = "Philly Mint", col = "green")
axis(side = 1, at = fivenum(us_quarters$PhillyMint), labels = TRUE)



## ----2f Outliers---------------------------------------------------------------------------------------------------------------------------

f<- fivenum(us_quarters$DenverMint)
lower <- f[2] - 1.5*(f[4] - f[2])
upper <-  f[4] + 1.5*(f[4] - f[2])
outlier_ind <- which(us_quarters$DenverMint < lower | us_quarters$DenverMint > upper) 
us_quarters$State[outlier_ind]
paste("The outlier states from the Denver Mint are ",us_quarters$State[outlier_ind])  
  
f<- fivenum(us_quarters$PhillyMint)
outlier_ind2 <- which(us_quarters$PhillyMint < lower | us_quarters$PhillyMint > upper) 
us_quarters$State[outlier_ind2]
paste("The outlier states from the Philly mint are ", us_quarters$State[outlier_ind2])



## ----3 Setup-------------------------------------------------------------------------------------------------------------------------------
stocks <- read.csv("http://people.bu.edu/kalathur/datasets/faang.csv")
head(stocks,2)
tail(stocks,2)
summary(stocks[-1])





## ----5Stocks-------------------------------------------------------------------------------------------------------------------------------
# Like with the mint data - it would be easier to reformat the data
# putting all of the stock symbols in one column and all of the values in one column.
# This does mean that there will be repeating date values, but this works well for plotting.

# Use gather(data, <newVar>,<newVar>,c(<column names>))
gStocks<-gather(stocks, stockSym, value,c(Facebook,Apple,Amazon,Netflix,Google))
# Change the date vector using lubridate...
gStocks$Date <- ymd(stocks$Date)
# now pipe it all together
gStocks %>% ggplot(aes(x=Date,y=value,color = stockSym))+ geom_line()+ geom_point()

#         theme(axis.text.x = element_text(angle = 80, hjust = 1))


## ----3b------------------------------------------------------------------------------------------------------------------------------------
# use the pairs - but dont include the date!
pairs(stocks[-1],pch=16, col = 'Blue')
(c<-cor(stocks[-1]))


## ----3b corrPlot---------------------------------------------------------------------------------------------------------------------------
corrplot(c,type = "upper",order = "hclust",col = brewer.pal(n=10,name = "Paired"))



## ----4 Setup-------------------------------------------------------------------------------------------------------------------------------
scores <- read.csv("http://people.bu.edu/kalathur/datasets/scores.csv")

head(scores)
summary(scores$Score)


## ----4a------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
studentHist<-hist(scores$Score)

for (i in seq(1,length(studentHist$count)) ) {
    j<-sprintf("%d students in range (,%d,%d ] ", studentHist$counts[i],studentHist$breaks[i],studentHist$breaks[i+1])
    print(j)
  }




## ----4b------------------------------------------------------------------------------------------------------------------------------------
newHist<-hist(scores$Score,breaks = seq(30,90,20))

for (i in seq(1,length(newHist$count)) ) {
    j<-sprintf("%d students in range (,%d,%d ] ", newHist$counts[i],newHist$breaks[i],newHist$breaks[i+1])
    print(j)
}


