#Quiz 2
#1 Project teams of size 2 are to be formed from a class of 14 students. 
#How many different ways you can form the teams?  (91)


#2 	Project teams of size 3 with separate roles are to be formed from a class of 10 students. 
# How many different ways you can form the teams? Each member of the team can only have one role. (720)

#12 When two six-faced dice are rolled, what is the probability that the sum of the rolls is less than or equal to 3?, given that the sum of X1 X2 is an odd number?
S <- rolldie(2,makespace = TRUE)
A <- subset(S,(X1+X2)<=3)
B <- subset(S,(X1+X2) %% 2 == 1)
Prob(A,given = B) == 2/18
# ans is 2/18
# Look at B.  Out of the 18, there are only two that have a sum of 3



#13
A <- subset(S,(X1+X2) >= 3)
Prob(A,given = B) == 18/18

# The parens around x1 and x2 are important!!
# Look at B.  How many satisfy the X1+X2>=3 requirement

# 14 In the incoming class, 90% students know Python, and 9% students know both Python and R. 
# What is the probability that a student who knows Python also knows R? (.1)
Ppython <- .9   # Know Python
PpythonR <- .09  # Know Python AND R
#P(A|B) = B/A
PpythonR / Ppython


isPali<-function(x){
  ifelse(identical(x,x[length(x):1]),TRUE,FALSE) 
}
