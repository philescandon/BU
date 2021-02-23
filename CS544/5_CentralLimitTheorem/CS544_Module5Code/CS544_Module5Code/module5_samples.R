#### 2. Central Limit Theorem

#### 2.1. Introduction

# different ways to choose 2 numbers out of 5
choose(5,2)
# This answer is the number of combinations that you are able to create
# in this case you can have 10 combinations of 2 numbers out of the 5


library(prob)
options(digits=4)

x <- c(69,70,72,75,79)
samples <- urnsamples(x, 2)
samples
mean(x)
sd(x)



xbar <- (samples$X1 + samples$X2)/2
xbar

mean(xbar)
sd(xbar)


hist(xbar, prob = TRUE)

# Alternative approach (no need for prob library)

x <- c(69,70,72,75,79)
samples <- combn(x,2)
samples

xbar <- apply(samples, 2, FUN = mean) 
xbar

hist(xbar, prob = TRUE)

#### Reproducibility of Random Numbers

# Repeating the following will give different values

sample(1:6, 10, replace = TRUE)

# Start with a given seed for random number generator
# Repeating the following together will give the same values

set.seed(12345)
sample(1:6, 10, replace = TRUE)

# or

set.seed(12345); sample(1:6, 10, replace = TRUE)



#### 2.2. Data from Normal Distribution

set.seed(100)

# E.g., scores of 1000 students

x <- rnorm(1000, mean = 60, sd = 10)

hist(x, prob = TRUE, 
  xlim=c(30,90), ylim = c(0, 0.05))

curve(dnorm(x, mean = 60, sd = 10), 
      add = TRUE, col = "red")

options(digits=2)
mean(x)
sd(x)

# Examine 10000 samples of 5 scores

samples <- 10000
sample.size <- 5

xbar <- numeric(samples)

for (i in 1: samples) {
	xbar[i] <- mean(sample(x, sample.size, replace = FALSE))
}

hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(30,90), 
     ylim = c(0, 0.1))

mean(xbar)
sd(xbar)



# Examine different sample sizes

par(mfrow = c(3,2))

for (size in c(10, 20, 30, 40, 50, 60)) {
	for (i in 1:samples) {
	  xbar[i] <- mean(sample(x, size, replace = FALSE))
    }

   hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(50,70), ylim = c(0, 0.4),
     main = paste("Sample Size =", size))
     
   cat("Sample Size = ", size, " Mean = ", mean(xbar),
        " SD = ", sd(xbar), "\n")
}

par(mfrow = c(1,1))

10 / sqrt(c(10,20,30,40,50,60))

#### 2.3. Data from Exponential Distribution

set.seed(100)

curve(dexp(x, rate = 2), 0, 5, 
      col = "red")

# Input data from the distrubution

x <- rexp(1000, rate = 2)

hist(x, prob = TRUE, 
  breaks = 15, ylim = c(0,2), 
  xlim = c(0,5))

options(digits=2)
mean(x)
sd(x)

# Examine 10000 samples of 5 values from the distribution

samples <- 10000
sample.size <- 5

xbar <- numeric(samples)

for (i in 1:samples) {
	xbar[i] <- mean(rexp(sample.size, 
	                rate = 2))
}

hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(0,3), 
     ylim = c(0, 2),
     main = "Sample Size = 5")

mean(xbar)
sd(xbar)

par(mfrow = c(2,3))

 for (size in c(10, 20, 30, 40, 50, 60)) {
	for (i in 1:samples) {
	  xbar[i] <- mean(rexp(size, rate = 2))
    }

    hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(0,2), ylim = c(0, 6),
     main = paste("Sample Size =", size))
     
    cat("Sample Size = ", size, " Mean = ", mean(xbar),
        " SD = ", sd(xbar), "\n")
 }

 par(mfrow = c(1,1))

0.5 / sqrt(c(10,20,30,40,50,60))



## PROPORTION
#### 2.4. Data from Discrete Uniform Distribution

set.seed(150)

# 1000 values from rolling a 6-faced dice

x <- sample(1:6, size = 1000, replace = TRUE)

table(x)

prop.table(table(x)) * 100
options(scipen = 3)
barplot(prop.table(table(x)),
  xlab = "x", ylim = c(0, 0.2), ylab = "Proportion")
  

mean(x)
sd(x)

# Examine 10000 samples of size 5

samples <- 10000
sample.size <- 5

xbar <- numeric(samples)

for (i in 1:samples) {
	xbar[i] <- mean(sample(x, size = sample.size, replace = FALSE))
}

hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(0,6), 
     ylim = c(0, 0.6),
     main = "Sample Size = 5")

mean(xbar)
sd(xbar)

par(mfrow = c(2,2))

 for (size in c(10, 20, 30, 40)) {
	
   for (i in 1:samples) {
	  xbar[i] <- mean(sample(x, size = size, replace = FALSE))
   }

  hist(xbar, prob = TRUE, 
     breaks = 15, xlim=c(0,6), ylim = c(0, 1.5),
     main = paste("Sample Size =", size))
     
  cat("Sample Size = ", size, " Mean = ", mean(xbar),
        " SD = ", sd(xbar), "\n")
 }

par(mfrow = c(1,1))

1.7 / sqrt(c(10,20,30,40))

####################################

#### 3. Sampling Methods

#### 3.2. Simple Random Sampling

library(sampling)

# SRSWR
# Equal Probability

set.seed(123)

s <- srswr(10, 26)
s

LETTERS[s != 0]

s[s != 0]

rep(LETTERS[s != 0], s[s != 0])

# SRSWOR
# Unequal Probability

s <- srswor(10, 26)
s

LETTERS[s != 0]

s[s != 0]

#### 3.3. Example – Simple Random Sampling

data(swissmunicipalities)
names(swissmunicipalities)

head(swissmunicipalities[c(2,4,14,17,22)])

table(swissmunicipalities$REG)

# srswr
set.seed(153)

s <- srswr(70, nrow(swissmunicipalities))
s[s != 0]

rows <- (1:nrow(swissmunicipalities))[s!=0]
rows <- rep(rows, s[s != 0])
rows

sample.1 <- swissmunicipalities[rows, ]
head(sample.1[c(2,4,14,17,22)])

table(sample.1$REG)

set.seed(153)
# srswor

s <- srswor(70, nrow(swissmunicipalities))

sample.2 <- swissmunicipalities[s != 0, ]
head(sample.2[c(2,4,14,17,22)])

table(sample.2$REG)



#------------------------------------------
#### 3.4. Systematic Sampling

set.seed(113)
#
N <- 1000
n <- 50

# items in each group
k <- ceiling(N / n)
k

# random item from first group
r <- sample(k, 1)
r

# select every kth item

seq(r, by = k, length = n)

#### 3.5. Example – Systematic Sampling

set.seed(113)
#

N <- nrow(swissmunicipalities)
n <- 70

k <- ceiling(N / n)
k

r <- sample(k, 1)
r

# select every kth item

s <- seq(r, by = k, length = n)

sample.3 <- swissmunicipalities[s, ]
head(sample.3[c(2,4,14,17,22)])

table(sample.3$REG)


#--------------------------------------------------
#### 3.6. Unequal Probabilities

set.seed(113)
# UPsystematic

pik <- inclusionprobabilities(
  swissmunicipalities$POPTOT, 70)
length(pik)

sum(pik)

s <- UPsystematic(pik)

sample.4 <- swissmunicipalities[s != 0, ]
head(sample.4[c(2,4,14,17,22)])

table(sample.4$REG)


#------------------------------------
#### 3.7. Stratified Sampling

set.seed(123)
# Stratified, equal sized strata

section.ids <- rep(LETTERS[1:4], each = 25)

section.scores <- round(runif(100, 60, 80))

data <- data.frame(
  Section = section.ids, 
  Score = section.scores)

head(data)

table(data$Section)

st.1 <- strata(data, stratanames = c("Section"),
               size = rep(3, 5), method = "srswor",
               description = TRUE)

st.1

st.sample1 <- getdata(data, st.1)

st.sample1


#### 3.8. Example – Unequal Strata

set.seed(123)
# Stratified, unequal sized strata

section.ids <- rep(LETTERS[1:4], c(10, 20, 30, 40))

section.scores <- round(runif(100, 60, 80))

data <- data.frame(
  Section = section.ids, 
  Score = section.scores)

head(data)

freq <- table(data$Section)
freq

st.sizes <- 20 * freq / sum(freq)
st.sizes

st.2 <- strata(data, stratanames = c("Section"),
               size = st.sizes, method = "srswor",
               description = TRUE)

st.2

st.sample2 <- getdata(data, st.2)

st.sample2

strata(data, stratanames = c("Section"),
       size = rep(5, 4), method = "srswor",
       description = TRUE)

#### 3.9. Example – Strata with Two Variables

# two variables

set.seed(123)
# Stratified, unequal sized strata

section.ids <- rep(LETTERS[1:4], c(10, 20, 30, 40))
section.genders <- 
  rep(rep(c("F", "M"), 4), 
      c(10, 0, 5, 15, 20, 10, 15, 25))
section.scores <- round(runif(100, 60, 80))

data <- data.frame(
  Section = section.ids, 
  Gender = section.genders,
  Score = section.scores)

head(data)

data <- data[order(data$Section, data$Gender), ]

freq <- table(data$Section, data$Gender)
freq

st.sizes <- 20 * freq / sum(freq)
st.sizes

as.vector(st.sizes)

as.vector(t(st.sizes))

st.sizes <- as.vector(t(st.sizes))
st.sizes <- st.sizes[st.sizes != 0]

st.sizes

st.3 <- strata(data, 
               stratanames = c("Section", "Gender"),
               size = st.sizes, method = "srswor",
               description = TRUE)

st.3

st.sample3 <- getdata(data, st.3)

st.sample3

#### 3.10. Ordering Data   

set.seed(113)
#
order.index <- order(swissmunicipalities$REG)
data <- swissmunicipalities[order.index, ]

head(data[c(2,4,14,17,22)])

st <- strata(data, stratanames = c("REG"),
             size = c(14,22,8,4,11,5,6) , 
             method = "srswor")

sample.5 <- getdata(data, st)
table(sample.5$REG)

# Proportion

freq <- table(swissmunicipalities$REG)
freq

sizes <- round(70 * freq / sum(freq))
sizes
sum(sizes)

st <- strata(data, stratanames = c("REG"),
             size = sizes, method = "srswor")

head(st)

sample <- getdata(data, st)
head(sample[1:5])

####

# Cluster

set.seed(123)

section.ids <- rep(LETTERS[1:4], c(10, 20, 30, 40))

section.scores <- round(runif(100, 60, 80))

data <- data.frame(
  Section = section.ids, 
  Score = section.scores)

table(data$Section)

cl <- cluster(data, c("Section"), size = 2, 
              method="srswor")

cl.sample <- getdata(data, cl)

table(cl.sample$Section)

#
set.seed(113)

table(swissmunicipalities$REG)

cl <- cluster(swissmunicipalities, c("REG"), 
              size = 4, method="srswr")

sample.6 <- getdata(swissmunicipalities, cl)

table(sample.6$REG)




## Resampling Methods

## 4.2. The replicate Function

set.seed(100)

x <- 1:5
sample(x, replace = TRUE)
sample(x, replace = TRUE)

# Replicate as a matrix

set.seed(100)
y <- replicate(10, sample(x, replace = TRUE))
y

apply(y, 2, mean)

# or, Replicate as a list

set.seed(100)
y <- replicate(10, sample(x, replace = TRUE),
               simplify = FALSE)
y

sapply(y, mean, simplify = TRUE)


####

## 4.3. Bootstrap Distribution—Standard Error of the Mean

set.seed(120)

pop.mean <- 60
pop.sd <- 10

sample.size <- 30

x <- rnorm(sample.size, mean = pop.mean, sd = pop.sd)
x <- as.integer(x)
x

# 1000 samples of size 30 each

set.seed(120)

resamples.1 <- replicate(1000, 
                         sample(x, replace = TRUE),
                         simplify = FALSE)

head(resamples.1, n = 2)

xbar.star <- sapply(resamples.1, mean, simplify = TRUE)

length(xbar.star)

head(xbar.star, n = 6)

hist(xbar.star, breaks=40, prob = TRUE, 
     xlim=c(50,70), ylim=c(0, 0.3))

sd.sample.means <- pop.sd/sqrt(sample.size)
sd.sample.means

curve(dnorm(x, mean = pop.mean, sd = sd.sample.means), 
      from = 50, to = 70, add = TRUE)

mean(xbar.star)

mean(x)

mean(xbar.star) - mean(x)

sd(xbar.star)

sd.sample.means

#

library(boot)

set.seed(120)

samplemean <- function(x, indices) { 
  return (mean(x[indices]))
}

boot.data <- boot(data = x, statistic = samplemean, R = 1000)
boot.data

# Middle 95% confidence interval

quantile(xbar.star, c(0.025, 0.975))

boot.ci(boot.data, conf = 0.95, type="perc")


#

## 4.4. Bootstrap Distribution—Standard Error of the Median

set.seed(120)

length(rivers)

hist(rivers, breaks = 20)

mean(rivers)

median(rivers)


resamples.2 <- replicate(1000, 
                         sample(rivers, replace = TRUE),
                         simplify = FALSE)

medians.star <- sapply(resamples.2, median, 
                       simplify = TRUE)

length(medians.star)

hist(medians.star, breaks=30, prob = TRUE)

median(rivers)

mean(medians.star)

mean(medians.star) - median(rivers)

sd(medians.star)

set.seed(120)

samplemedian <- function(x, indices) { 
  return (median(x[indices]))
}

boot(data = rivers, 
     statistic = samplemedian, R = 1000)


## 4.5. Bootstrap Confidence Intervals


quantile(medians.star, c(0.025, 0.975))

set.seed(120)

samplemedian <- function(x, indices) { 
  return (median(x[indices]))
}

boot.data <- boot(data = rivers, 
                  statistic = samplemedian, R = 1000)

boot.ci(boot.data, conf = 0.95, type="perc")


##
