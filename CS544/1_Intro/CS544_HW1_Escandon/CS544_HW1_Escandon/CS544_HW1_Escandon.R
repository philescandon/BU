#' ---
#' title: "CS 544 Module 1 Assignment"
#' author: "Phillip Escandon - escandon@bu.edu"
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output: 
#'   word_document:
#'     toc: FALSE
#'     reference_doc: "BUtemplate.docx"
#'   html_document:
#'     toc: true
#'     fig_caption: true
#' ---
#' 
#' <img src="BU_Small.png" width=200 height=100 style="position:absolute;top:0px;right:100px;" />
#' 
#' ## Part 1
#' <!---
#' 
#' To change the RMD file to straight R Code use purl()
#' knitr::purl("CS544_HW1_Escandon.Rmd")
#' 
#' --->
#' 
#' ### a. Vectors
#' How many students took the exam
## ----1a-----------------------------------------------------------------------------------------
scores <- c(59,46,76,60,49,65,82,68,99,52)
numberOfStudents <- length(scores)
numberOfStudents

#' 
#' Firt two items of the vector
## -----------------------------------------------------------------------------------------------
scores[c(1,2)]

#' 
#' 
#' 
## ----Notes1, eval=FALSE, include=FALSE----------------------------------------------------------
## # use paste() or use r inline
## paste("The length of the scores vector is",l)
## # or use r line
## # `r <your code> `   that is backtick, r, closing backtick`

#' 
#' 
#' 
#' First and last items in the scores vector
## ----First and Last-----------------------------------------------------------------------------
fl <- scores[c(1,length(scores))]
fl

#' 
#' 
#' Access the middle two items
## -----------------------------------------------------------------------------------------------
mid = length(scores)/2
scores[c(mid,mid+1)]


#' 
#' ### b. Median
#' Use median
## ----1b-----------------------------------------------------------------------------------------
median(scores)

#' 
#' Less than or equal to median
## ----1b1----------------------------------------------------------------------------------------
scores<=median(scores)

#' 
#' 
#' Greater than the median
## ----1b2----------------------------------------------------------------------------------------
scores>median(scores)

#' 
#' Using the sum function- find the number of elements LESS THAN the median
## ----1b3----------------------------------------------------------------------------------------
sum(scores<=median(scores))

#' 
#' 
#' Using the sum function to find the number of elements above the median
## ----1b4----------------------------------------------------------------------------------------
s = sum(scores>median(scores))
s

#' 
#' 
#' ### c. Using logical expressions
#' 
#' Using logical expressions find the values <= and > to the median
## ----1c-----------------------------------------------------------------------------------------

scores[scores<=median(scores)]
scores[scores>median(scores)]



#' 
#' 
#' 
#' 
#' ### d. Logical Indexing
#' Logical indexing with TRUE and FALSE to find odd and even **index** values in vector
#' 
## ----1d-----------------------------------------------------------------------------------------
scores[c(TRUE,FALSE)]
scores[c(FALSE,TRUE)]



#' 
## ----notes2, eval=FALSE, include=FALSE----------------------------------------------------------
## # odd and even values of a vector
## #scores[scores %% 2 == 0]
## #scores[scores %% 2 == 1]
## 

#' 
#' 
#' 
#' ### e. Numeric Expression
## ----1e-----------------------------------------------------------------------------------------
# need the ODD INDEX of the vector not the odd values!
od<- seq(1,length(scores),2)
ev<- seq(2,length(scores),2)
scores[od]
scores[ev]

#' 
#' 
#' 
#' ### f. Create a 2x5 matrix called scores.matrix
#' 
## ----1f-----------------------------------------------------------------------------------------
scores.matrix <- matrix(scores, nrow = 2, ncol = 5, byrow = TRUE)
scores.matrix

#' 
#' 
#' ### g. First and last column of the matrix
#' 
#' 
## ----1g-----------------------------------------------------------------------------------------
scores.matrix[ ,c(1,ncol(scores.matrix))]

#' 
#' ### h. Assign column names for the scores.matrix student 1-5, quiz 1-2
#' 
## ----1h-----------------------------------------------------------------------------------------
cnames <- paste("Student",1:ncol(scores.matrix),sep = "_")
rnames <- paste("Quiz",1:nrow(scores.matrix),sep = "_")
dimnames(scores.matrix) <- list(rnames,cnames)
scores.matrix


#' 
#' 
#' ### i. Show the first and last columns with names using code from g.
#' 
#' 
## ----1i-----------------------------------------------------------------------------------------
scores.matrix[ ,c(1,ncol(scores.matrix))]

#' 
#' \newpage
#' ## Part 2
#' 
#' ### a. Create a dataframe -dow
#' 
## -----------------------------------------------------------------------------------------------
month <- c("Jan","Feb","Mar","Apr","May")
open <- c(28639,28320,25591,21227,24121)
high <- c(29374,29569,27102,24765,24359)
low <- c(28170,24681,18214,20735,23361)
close <- c(28256,25409,21917,24346,24331)

#' 
#' 
## ----2a-----------------------------------------------------------------------------------------
dow <- data.frame(month,open,high,low,close)
dow

#' 
#' 
#' ### b. Show the summary() on the above data frame.
#' 
## ----2b-----------------------------------------------------------------------------------------
summary(dow[c(2:ncol(dow))])

#' 
#' 
#' ### c. Slice data frame columns with month, open and close
#' 
## ----2c-----------------------------------------------------------------------------------------
dow[c("month","open","close")]

#' 
#' 
#' ### d. Dataframe rows sliced, first and last row, any size dataframe
#' 
## ----2d-----------------------------------------------------------------------------------------
# data frame[ row , col]
lastRow <- nrow(dow)
dow[ c(1,lastRow), ]


#' 
#' 
#' ### e. Dataframe sliced by first and last row, columns MONTH, HIGH and LOW
#' Should work for any size dataframe
## ----2e-----------------------------------------------------------------------------------------
# data frame[ row , col ]
lastRow <-  nrow(dow)
dow[ c(1,lastRow), c("month","high","low")]


## ----Notes, include=FALSE-----------------------------------------------------------------------
#dow[c(1,lastRow), dow$high]
#attach(dow)


#' 
#' 
#' ### f. Show all rows of data frame whose LOW is greater than 22,000.  Any size dataframe.
#' Show logical indexing and one solution using the subset()
#' 
## ----2f-----------------------------------------------------------------------------------------
# dataframe [ row , col]
dow
# logical indexing
dow[ dow$low> 22000 , ]

# subset( df, rules)
subset(dow, dow$low > 22000)


#' 
#' ### g. Show all rows whose OPEN and LOW > 25,000. 
#' Show logical indexing and one solution using the subset()
#' 
## ----2g-----------------------------------------------------------------------------------------
# indexing
dow[c(dow$open>25000 & dow$low > 25000) , ]

# subset
subset(dow,c(dow$open>25000 & dow$low > 25000))


#' 
#' ### h. Add new column called VOLATILITY showing the difference between high and low
## ----2h-----------------------------------------------------------------------------------------
dow$volatility <- dow$high - dow$low
dow


#' 
#' ### i. Show the rows with max volatilty.  Use subset() and max()
## ----2i-----------------------------------------------------------------------------------------

max(dow$volatility)

subset(dow, dow$volatility == max(dow$volatility))


#' 
#' 
#' ### j. Show the rows with minimum volatility.  Use logical indexing and min() 
#' Do no use the subset function
## ----2j-----------------------------------------------------------------------------------------
#subset(x, subset, select, drop = FALSE, ...)
subset(dow,dow$volatility == min(dow$volatility))


#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
