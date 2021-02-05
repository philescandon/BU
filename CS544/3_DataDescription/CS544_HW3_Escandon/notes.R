# Data Description Notes

1. Dimensions of the data:
  dim()
  nrow()
  ncol()
  dimnames()
  dim()
  head()
  summary()
  
  
# Ifelse for color!  
  col = ifelse(Melanoma$sex == "1", "blue", "red")
  
library(UsingR)  
ggplot(data = mpg, mapping = aes(x = displ, y= hwy)) + 
  geom_point(mapping = aes(color = class))+
  geom_smooth()




# use the lubridate package to fix the date column
df_date <- ymd(stocks$Date)
ggplot(stocks) + 
  geom_point(mapping = aes(x =df_date, y = Amazon) )

# The stock data is not quite in a good form.
# similar to the Mint data from #2
# So let's fix it up some using gather
gStocks<-gather(stocks, stockSym, value,c(Facebook,Apple,Amazon,Netflix,Google))
gQuarters<-gather(us_quarters,Mint,qrtCount,c(DenverMint,PhillyMint))
require(ggplot2)
require(reshape2)
df <- data.frame(time = 1:10,
                 a = cumsum(rnorm(10)),
                 b = cumsum(rnorm(10)),
                 c = cumsum(rnorm(10)))
df2 <- melt(df ,  id.vars = 'time', variable.name = 'series')
head(df2,2)


