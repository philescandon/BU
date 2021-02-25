## ----Setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(prob)
library(plotly)
library(RColorBrewer) # color
library(scales)  # for dollar format
library(sampling) # 
set.seed(5121)
options(digits=4)


setwd("~/BU/CS544/6_Strings_DataWrangling/CS544_HW6_Escandon")


## ----1 setup---------------------------------------------------------------------------------------------------------------------------------------------------
# Read in the lincoln text and place into the words variable.
file <- "http://people.bu.edu/kalathur/datasets/lincoln.txt"
 words <- scan(file, what=character())




## ----1a--------------------------------------------------------------------------------------------------------------------------------------------------------
# Words with punctuation
punctWords <- words[str_detect(words, "[:punct:]")]
punctWords



## ----1b--------------------------------------------------------------------------------------------------------------------------------------------------------
# replace punctuation with space

new_words<- str_remove_all(str_replace_all(punctWords,"[:punct:]","")," ")
# Could not get rid of "" and had difficulty with '--'
new_words <- new_words[new_words!='']
new_words <- str_to_lower(new_words)
new_words




## ----1c--------------------------------------------------------------------------------------------------------------------------------------------------------
# Find the top 5 frequently used words.
top5 <- sort(table(new_words),decreasing = TRUE)[1:5]
top5



## ----1d--------------------------------------------------------------------------------------------------------------------------------------------------------
# Should sort the barplot
# Barplot seems more applicable  
barplot(table(str_length(new_words)),horiz = FALSE,las = 1,xlab = 'Word Length',ylab = 'Word Count')
#hist(table(str_length(new_words)))




## ----1e--------------------------------------------------------------------------------------------------------------------------------------------------------
lenlongestWord <- str_length(new_words) %>% max()

longestWord <- new_words[str_length(new_words) == lenlongestWord]

glue::glue("The longest word is ", longestWord)



## ----1f--------------------------------------------------------------------------------------------------------------------------------------------------------
pWords <- new_words[str_detect(new_words,"^[pP]")]
pWords



## ----1g--------------------------------------------------------------------------------------------------------------------------------------------------------
rWords <- new_words[str_detect(new_words,"[rR]$")]
rWords



## ----Bonus Setup-----------------------------------------------------------------------------------------------------------------------------------------------

stopfile <- "http://people.bu.edu/kalathur/datasets/stopwords.txt"
stopwords <- scan(stopfile, what=character())


## ----Bonus c---------------------------------------------------------------------------------------------------------------------------------------------------
#new_words[stopwords %in% new_words]

# this is the one we want
#new_words
new_words_wo_stops <- new_words[!new_words %in% stopwords]

# Top 5 most frequent words
top5Main <- sort(table(new_words_wo_stops),decreasing = TRUE)[1:5]
barplot(top5Main,xlab = 'Word',ylab = "Count",main = "Top 5 Words in Lincoln Address")
# Frequency of the word lengths
barplot(table(str_length(new_words_wo_stops)),horiz = FALSE,las = 1,xlab = 'Word Length',ylab = 'Word Count')



## ----2 setup---------------------------------------------------------------------------------------------------------------------------------------------------
dailyTemps <- read_csv("usa_daily_avg_temps.csv")



## ----2a--------------------------------------------------------------------------------------------------------------------------------------------------------
usaDailyTemps <- as_tibble(dailyTemps)



## ----2b--------------------------------------------------------------------------------------------------------------------------------------------------------
usaDailyTemps %>% 
  group_by(year) %>%
  summarize(tmp = max(avgtemp))%>%
  plot_ly(x=~year,y=~tmp,type = "scatter",mode = 'lines+markers')%>%
    layout(title = "Max Temperatures recorded every year",
         xaxis = list(title = "Year"),
         yaxis = list (title = "Temperature (degrees F)"))




## ----2c--------------------------------------------------------------------------------------------------------------------------------------------------------
usaDailyTemps %>% 
  group_by(state) %>%
  summarize(tmp = max(avgtemp)) %>%
  arrange(desc(tmp)) %>%  # This portion doesn't quite work- I'd like the barplot to be ordered by temp.
  plot_ly(x = ~state)%>%
  add_trace(y=~tmp,name = 'Temp', type = 'bar')%>%
    layout(title = "High Temperatures for every State",
         xaxis = list(title = "State"),
         yaxis = list (title = "Temperature (degrees F)"))




## ----2d--------------------------------------------------------------------------------------------------------------------------------------------------------
bostonDailyTemps <- usaDailyTemps %>% 
  filter(city=="Boston")



## ----2e--------------------------------------------------------------------------------------------------------------------------------------------------------
bostonDailyTemps %>%
  group_by(month) %>%
  summarize(avg = mean(avgtemp)) %>%
  plot_ly(x = ~month, y = ~avg,type = 'scatter', mode = 'lines+markers')%>%
  layout(title = "Average Temperatures in Boston",
         xaxis = list(title = "Month"),
         yaxis = list (title = "Temperature (degrees F)"))
  
  



