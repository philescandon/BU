## ----eval=FALSE, include=FALSE---------------------------------------------------------------------------------------------
## library(prob)


## ----1a--------------------------------------------------------------------------------------------------------------------

# Probability of success
p <- .40
# number of attempts / trials
attempts <-5
# number of successes
successes <- 5

bi<-dbinom(successes,attempts,p)

# Probability Mass Function - shows the distribution of successes
x <- 0:attempts
paste('Probability of 5 perfect scores is',bi)
plot(x,dbinom(x,attempts,p),main = "PMF for bin(5,.40)")
plot(x,pbinom(x,attempts,p),main = "CDF for bin(5,.40)")



## ----1b--------------------------------------------------------------------------------------------------------------------
# Probability of success
p<- .40
# number of attempts / trials
attempts<-5
# number of successes
successes <- 2
bi2 <- dbinom(successes,attempts,p)

# Calculation by formula
# Equation: f(x) = {n x} p^x(1-p)^(n-x)
paste('Probability of exactly two perfect scores is ', bi2 )



## ----1bRed-----------------------------------------------------------------------------------------------------------------
# n = attempts 
n <- 5
# p = Probability
p<- .4
# number of attempts / trials
x<- 2

# Binomial manual Calculation
fx <- choose(n,x)* (p**x) * ((1-p)**(n-x))

paste("f(2) is ",fx)



## ----1c--------------------------------------------------------------------------------------------------------------------

# P(X > 1)  at least 2 successes
# Same as  1 - P(X <= 1)
# 1 - pbinom(1, size = n, prob = p)
# or
# sum(dbinom(2:n, size = n, prob = p))


# Probability of success
p<- .40
# number of attempts / trial
attempts<- 5

# number of successes
successes <- 1


cdf<-1- pbinom(successes,attempts,p)
# check
# sum(dbinom(2:n, size = n, prob = p))

paste("Probability of at least 2 perfect scores is ",cdf)
x<- 0:attempts
# CDF Plot
plot(x,pbinom(x,attempts,p),type = "s",main = "CDF for Bin(2,.4)")


## ----1d--------------------------------------------------------------------------------------------------------------------
# Probability of success
p<- .40
n<- 5
successes<- 5
# draw 1000 students
draws <- rbinom(1000,size = n, prob = p)
barplot(table(draws),main = "Random perfect scores for 1000 students")

br<- (0:(n+1)) - .5
hist(draws,br,main = "Random perfect scores for 1000 students")



## --------------------------------------------------------------------------------------------------------------------------




## ----2a--------------------------------------------------------------------------------------------------------------------
# Need 3 perfect scores - will max 10 fails before quitting.
# Probability
p<- .60
# Number of success as 'r'
successes<- 3
# number of failures
fails <- 10
# this is the negative binomial distribution. failures before a success.

# args are usually (success, attempts, prob) this time..fails 
(dnbinom(fails,successes,p))

x <- 0:fails
plot(dnbinom(x,successes,p),main = "PDF - r=3,f=10 Negative Binomial Distribution")

plot(pnbinom(x,successes,p),main = "CDF r=3,f=10, Negative Binomial Distribution")



## ----2b--------------------------------------------------------------------------------------------------------------------
successes <- 3
fails <- 4
p <- .6

dnb <- dnbinom(fails,successes,p)
paste('Probability of three perfect scores with 4 failures is',dnb)


## ----2ba-------------------------------------------------------------------------------------------------------------------
# cannot get the example neg binomial by hand using matrix mult 
# Left the args as r,x,p for a simplified choose equation

r <- 3 # successes
x <- 4 # fails
p <- .6
# f(4)
choose(6,2) * (.6**3) * ((1-.6)**4)
choose((r+x)-1,r-1) * (p**r)* ((1-p)**x)

#Check
#dnbinom(4,3,.6) == choose(6,2) * (.6**3) * ((1-p)**4)




## ----2c--------------------------------------------------------------------------------------------------------------------
# Apply the CDF here
# P(X <= 4)   at most 4 failures
r <- 3
fails <- 4
p <- .6
cd <- pnbinom(fails,r,p)
paste('Probability of 3 Perfect scores with at most 4 failures:',cd)


## ----2d--------------------------------------------------------------------------------------------------------------------
r <- 3
fails <- 4
p <- .6
x <- rnbinom(1000, size = r, prob = p)
barplot(table(x))



## ----3---------------------------------------------------------------------------------------------------------------------
M <- 60    # Of interest
N <- 40    # Not of interest
K <- 20    # Sample Size




## ----3a--------------------------------------------------------------------------------------------------------------------
M <- 60    # Of interest
N <- 40    # Not of interest
K <- 20    # Sample Size
dhyper(20, m = M, n = N, k = K)
pmf <-  dhyper(0:K,m=M,n=N,k=K)
pmf
plot(pmf)




## ----3b--------------------------------------------------------------------------------------------------------------------
# Review this portion - I don't know
M <- 60    # Of interest
N <- 40    # Not of interest
K <- 20    # Sample Size
phyper(10,m=M,n=N,k=K)
cdf <-  phyper(0:K,m=M,n=N,k=K)
cdf
plot(cdf)







## ----3ba-------------------------------------------------------------------------------------------------------------------
# P(X = 10)   10 questions of interest out of 20

a <- choose(M,10) * choose(N,10) / choose(M+N, 20)
paste("The probability that a student will have exactly 10 multiple choice quesions out of 20 is ",a)


## ----3c--------------------------------------------------------------------------------------------------------------------
# P(X > 2)   at least 3 faulty chips

1 - phyper(2, m = M, n = N, k = K)
# or
phyper(2, m = M, n = N, k = K, lower.tail = FALSE)



## ----3d--------------------------------------------------------------------------------------------------------------------
x <- rhyper(1000, m = M, n = N, k = K )
barplot(table(x),main = 'Hypergeometric')



## --------------------------------------------------------------------------------------------------------------------------
# On average 10 questions per day for prof
lmda <- 10


## ----4a--------------------------------------------------------------------------------------------------------------------
dp <- dpois(8,lambda = lmda)
paste("Probability of exactly 8 questions per day : ",dp)


## ----4b--------------------------------------------------------------------------------------------------------------------
pp <- ppois(8,lambda = lmda)
paste("Probability of at most 8 questions per day : ",pp)


## ----4c--------------------------------------------------------------------------------------------------------------------
pinc <- ppois(12,lambda = lmda) - ppois(5,lambda = lmda)
paste("Probability of 6-12 questions inclusive is : ",pinc)



## ----4d--------------------------------------------------------------------------------------------------------------------
pmf <-  dpois(0:20,lambda = lmda)
plot(0:20,pmf)


## ----4e--------------------------------------------------------------------------------------------------------------------
rpois(50, lambda = lmda)

x <- rpois(1000, lambda = lmda)                         
plot(table(x))
barplot(table(x))
boxplot(x)
paste("From looking at the box and bar plots you can infer that there are three high outliers, the average number of questions would be about 11 questions per day")



## --------------------------------------------------------------------------------------------------------------------------
# Ave day $100, standard dev. = $10
# Remember 68,95,99
mu <- 100
sigma <- 10



## ----5a--------------------------------------------------------------------------------------------------------------------
# Ave day $100, standard dev. = $10
# Remember 68,95,99
#x <- seq(0,200,1)
mu <- 100
sigma <- 10
x <- seq(mu-3*sigma,mu+3*sigma,.1)


pdf.1 <- dnorm(x,mu,sigma)
plot(x,pdf.1,type = "l",col="red")
     axis(side = 1, at = c(mu-3*sigma,mu-2*sigma,mu-sigma,mu,mu+sigma,mu+2*sigma,mu+3*sigma), 
      labels = TRUE) 



## ----5b--------------------------------------------------------------------------------------------------------------------
mu <- 100
sigma <- 10

# Chance of spending more than $120  so this should be 100 + 2 sigma
# upper bound
ub <- 1- pnorm(mu + 2*sigma, mu ,sigma)

paste("Chance of someone spending more than $120 is ", ub)


## ----5c--------------------------------------------------------------------------------------------------------------------
mu <- 100
sigma <- 10
# Spending between 80 and 90 dollars
b <- pnorm(90,mu,sigma) - pnorm(80,mu,sigma)
paste("Probability of someone spending between $80 and 90$ is ",b)


## ----5d--------------------------------------------------------------------------------------------------------------------
mu <- 100
sigma <- 10

# Spending between 1 STD, 2 STD and 3 STD
# should be roughly 68, 95 and 99
std3 <- pnorm(mu + 3*sigma, mean = mu, sd = sigma) -
 pnorm(mu - 3*sigma, mean = mu, sd = sigma)
paste("Chance of spending with 3 STD: ",std3)
 
std2 <- pnorm(mu + 2*sigma, mean = mu, sd = sigma) -
 pnorm(mu - 2*sigma, mean = mu, sd = sigma)
paste("Chance of spending with 2 STD: ",std2)

std1 <- pnorm(mu + sigma, mean = mu, sd = sigma) -
 pnorm(mu - sigma, mean = mu, sd = sigma)
paste("Chance of spending with 1 STD: ",std1)


#100* (pnorm(c(1,2,3)) - pnorm(c(-1,-2,-3)))



## ----5e--------------------------------------------------------------------------------------------------------------------
# ? took a while to figure this .
#todo format for $
upperLimit <- qnorm(.90,100,10)
lowerLimit <- qnorm(.10,100,10)
paste("The middle 90% of the money will be spent between $",lowerLimit," and $",upperLimit)



## ----5f--------------------------------------------------------------------------------------------------------------------
sp <- qnorm(.95,mean=100,sd=10)
# todo: format for $
paste("The minimum you must spend to get a shirt is $",sp)


## ----5g--------------------------------------------------------------------------------------------------------------------
y <- rnorm(10000, mean = 100, sd = 10)
y <- round(y)
#table(y)
plot(table(y), type="h")

