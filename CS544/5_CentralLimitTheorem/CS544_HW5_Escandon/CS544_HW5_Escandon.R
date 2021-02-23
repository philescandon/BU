## ----Setup, include=FALSE--------------------------------------------------------------------------------------------------------
library(tidyverse)
library(prob)
library(plotly)
library(RColorBrewer) # color
library(scales)  # for dollar format
library(sampling) # for question 3
set.seed(5121)
options(digits=4)


## ----getData---------------------------------------------------------------------------------------------------------------------
boston <- read.csv("http://people.bu.edu/kalathur/datasets/bostonCityEarnings.csv",colClasses = c("character","character","character","integer","character"))




## ----1a--------------------------------------------------------------------------------------------------------------------------

# Cannot get the xlim to work correctly
s <- seq(40000,400000,20000)
ee <- hist(boston$Earnings, breaks = s,xlim = c(40000,400000),prob = TRUE,las = 1 )
mean0 <-  dollar(mean(boston$Earnings))
sd0 <- dollar(sd(boston$Earnings))

paste("Mean of the Boston Earnings dataset is  $", mean0)

paste("Standard Deviation from the mean is ", sd0)

paste("I can infer that the earnings for Boston City public employees is skewed left and with < $100,000 salaries. The high salaries for some jobs are surprising to my high school kids.")




## ----notes 1, eval=FALSE, include=FALSE------------------------------------------------------------------------------------------
## # Testing for the xlim / xaxis
## #sum(ee$density * 20000) == 1
## 
## #ggplot(boston, aes(x=Earnings)) + geom_histogram(color="darkblue", fill="lightblue",binwidth = 20000) +  scale_x_continuous(limits = c(40000, 400000))
## 
## 
## 


## ----1b--------------------------------------------------------------------------------------------------------------------------
samples <- 5000
sample.size <- 10

xbar <- numeric(samples)

for (i in 1: samples) {
	xbar[i] <- mean(sample(boston$Earnings, sample.size, replace = FALSE))
}

hist(xbar, prob = TRUE, 
     breaks = s, xlim=c(40000,400000))

# Computing the mean and standard deviation
mean10 <- dollar(mean(xbar))
sd10 <- dollar(sd(xbar))




## ----1c--------------------------------------------------------------------------------------------------------------------------
samples <- 5000
sample.size <- 40

xbar <- numeric(samples)

for (i in 1: samples) {
	xbar[i] <- mean(sample(boston$Earnings, sample.size, replace = FALSE))
}
options(digits = 4)
hist(xbar, prob = TRUE, 
     breaks = s, xlim=c(40000,400000))

mean40 <- dollar(mean(xbar))
sd40 <- dollar(sd(xbar))




## ----1d--------------------------------------------------------------------------------------------------------------------------
paste(" The mean and SD of the original dataset are ", mean0," and ", sd0)
paste(" The mean and SD of the 10 sample sized dataset are ", mean10," and ",sd10)
paste(" The mean and SD of the 40 sample sized  dataset are ", mean40," and ", sd40)

paste(" The mean became clear quickly with a small data set and the standard deviation changed quite a bit from the orgiinal.  To me this would point to outliers and could be investigated wtih a boxplot.")


#boxplot(boston$Earnings,horizontal = TRUE ))




## ----2a--------------------------------------------------------------------------------------------------------------------------
# Probability
p <-  .5
# size
s <- 3

# Test plot 
#x <- 0:30
#plot(dnbinom(x, size = s, prob = p))


x <- rnbinom(5000, size = s, prob = p)
barplot(table(x))
title("Random Negative Binomial Distribution, r=3, p=.5")
mean(x)
sd(x)



## --------------------------------------------------------------------------------------------------------------------------------
par(mfrow = c(2,2))
p <-  .5
nbiSample <- 5000
# size
s <- 3
x <- rnbinom(nbiSample, size = s, prob = p)
xbar <-  numeric(nbiSample)

# x has been setup in previous code segment
for (size in c(10, 20, 30, 40)) {
	for (i in 1:nbiSample) {
	  xbar[i] <- mean(sample(x, size, replace = FALSE))
    }

# Create a hist for each, arbitrarily kept the breaks at 15
   hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(0,10),
     main = paste("Sample Size =", size))
     
   cat("Sample Size = ", size, " Mean = ", mean(xbar),
        " SD = ", sd(xbar), "\n")
}


par(mfrow = c(1,1))

#10 / sqrt(c(10,20,30,40))




## --------------------------------------------------------------------------------------------------------------------------------
paste("With the four sample sizes changing, the mean was very accurate and the standard deviation was increasingly less as the sample size grew. Changing the nbiSample var from 5000 to 500 still resulted in values very close when the same sample size of 40 was used. ")




## ----3 TopDepartments------------------------------------------------------------------------------------------------------------
# Trying the %>% operator
# Created a sorted var, send it to table for a count, sort it by decreasing values and get the names
sortedDept <- boston$Department  %>% table() %>% sort(decreasing = TRUE) %>% names()

# Get the top 5 names
top5DepartmentNames <- sortedDept[1:5]

# Get a subset of the top 5 departments in a dataframe using the %in% operator
topDepartments <- subset(boston,boston$Department %in% top5DepartmentNames)




## ----3a--------------------------------------------------------------------------------------------------------------------------
# seed from BU id
set.seed(5121)
s <- srswor(50, nrow(topDepartments))

sample.2 <- topDepartments[s != 0, ]
#head(sample.2)

# Frequency table
t1 <- table(sample.2$Department)
#todo: Change naming convention on xaxis
barplot(t1, main =  "Top Depts by Frequency- Simple Random Sampling", ylab = "Counts",
          ylim=range(pretty(c(0, t1))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#69b3a2")

# Proportion Table
t2<- prop.table(table(sample.2$Department)) * 100
#todo: Change naming convention on xaxis
# Renaming the prop table using the t var from above.  
barplot(t2, main =  "Top Depts by Percentage- Simple Random Sampling", ylab = "Percent Proportion",
          ylim=range(pretty(c(0, t2))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#69b3a2")




## ----3b--------------------------------------------------------------------------------------------------------------------------
set.seed(5121)
# sample size 50
N <- nrow(topDepartments)
n <- 50

k <- ceiling(N / n)
#k

r <- sample(k, 1)
#r

# select every kth item

s <- seq(r, by = k, length = n)

sample.3 <- topDepartments[s, ]
#head(sample.3)


# Cut and paste code from above.  dangerous..
# Frequency table
t3 <- table(sample.3$Department)
#todo: Change naming convention on xaxis
barplot(t3, main =  "Top Depts by Frequency - Systematic Sampling", ylab = "Counts",
          ylim=range(pretty(c(0, t3))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#69b3a2")

# Proportion Table
t4<- prop.table(table(sample.3$Department)) * 100
#todo: Change naming convention on xaxis
# Renaming the prop table using the t var from above.  
barplot(t4, main =  "Top Depts by Percentage - Systematic Sampling", ylab = "Percent Proportion",
          ylim=range(pretty(c(0, t4))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#69b3a2")








## ----3c--------------------------------------------------------------------------------------------------------------------------
# min i
#### 3.6. Unequal Probabilities
#inclusionprobabilities()

set.seed(5121)
# UPsystematic

pik <- inclusionprobabilities(
  topDepartments$Earnings, 50)
#length(pik)

#sum(pik)

s <- UPsystematic(pik)

sample.4 <- topDepartments[s != 0, ]
#head(sample.4)




# Cut and paste code from above.  dangerous..
# Frequency table
t5 <- table(sample.4$Department)
#todo: Change naming convention on xaxis
barplot(t5, main =  "Top Depts by Frequency - Inclusion", ylab = "Counts",
          ylim=range(pretty(c(0, t5))),
        las = 2,
        names.arg=c("Fire","Police","Library","Spec. Ed"), 
        col="#69b3a2")

# Proportion Table
t6<- prop.table(table(sample.4$Department)) * 100

#todo: Change naming convention on xaxis
# Renaming the prop table using the t var from above.  
barplot(t6, main =  "Top Depts by Percentage - Inclusion", ylab = "Percent Proportion",
          ylim=range(pretty(c(0, t6))),
        las = 2,
        names.arg=c("Fire","Police","Library","Spec. Ed"), 
        col="#70b3a2")




## ----3d--------------------------------------------------------------------------------------------------------------------------
sortedDepts <- sort(table(topDepartments$Department),decreasing = TRUE)
set.seed(5121)
# Then do the stratified sampling
# order and include all columns
orderedDepts<- topDepartments[order(topDepartments$Department),]

freq <- table(orderedDepts$Department)
# Samples = 50
st.sizes <- 50 * freq / sum(freq)
#st.sizes

#as.vector(st.sizes)

#as.vector(t(st.sizes))

st.sizes <- as.vector(t(st.sizes))
st.sizes <- st.sizes[st.sizes != 0]

#st.sizes

st.3 <- strata(orderedDepts, 
               stratanames = c("Department"),
               size = st.sizes, method = "srswor",
               description = TRUE)

#st.3

st.sample3 <- getdata(orderedDepts, st.3)

#st.sample3

freq2 <- table(st.sample3$Department)


# Frequency Plot
t7 <- table(st.sample3$Department)
#todo: Change naming convention on xaxis
barplot(t7, main =  "Top Depts by Frequency - Stratified", ylab = "Counts",
          ylim=range(pretty(c(0, t7))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#69b3a2")
# Proportion Plot
t8<- prop.table(table(st.sample3$Department)) * 100
barplot(t8, main =  "Top Depts by Percentage - Stratified", ylab = "Percent Proportion",
          ylim=range(pretty(c(0, t8))),
        las = 2,
        names.arg=c("Fire","Police","Library","Facilities","Spec. Ed"), 
        col="#70b3a2")




## ----3e--------------------------------------------------------------------------------------------------------------------------
# Original Dataset
paste("The mean for Earning variable in the original dataset is", dollar( mean(boston$Earnings)))

# Simple Random Sampling
paste("The mean for Earning variable in the Simple Random dataset is", dollar( mean(sample.2$Earnings)))

# Systematic Sampling
paste("The mean for Earning variable in the Systematic Random dataset is", dollar( mean(sample.3$Earnings,na.rm=TRUE)))

# Inclusive Sampling
paste("The mean for Earning variable in the Inclusive Random dataset is", dollar( mean(sample.4$Earnings)))

# Stratified Sampling
paste("The mean for Earning variable in the Stratified Random dataset is", dollar( mean(st.sample3$Earnings)))


"It appears that a simple random sample works best for this particular problem, but am questioning why the mean is not closer to the original dataset mean as it worked in out example data sets."




