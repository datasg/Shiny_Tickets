library(readr)
library(tidyr)
library(ggplot2)
library(scales)
library(dplyr)

r <- read.csv("nc.csv") 
colnames(r)
r$Violation.Time[1:100]

x=r$Violation.Time
PorA = substr(x,6,6) #nchar(x)-n+1, nchar(x))
hour = as.numeric(substr(x,1,2))
a= hour==12
b= PorA=='A'
AdjHour=ifelse(a&b,hour-12,hour)
minute = as.numeric(substr(x,4,5))
Offset=ifelse(PorA == 'A', 0,12)
RevTime=(Offset+AdjHour)*60+minute
RevTimeA= ifelse(RevTime > 1440, RevTime-720,RevTime)
labels=c('0-3','3-6','6-9','9-12','12-15','15-18','18-21','21-24')
DataCut=cut(RevTimeA, breaks=c(0,180,360,540,720,900,1080,1260, 1440), labels=labels, include.lowest=TRUE)

clean_time <- function(x){
  PorA = substr(x,6,6) #nchar(x)-n+1, nchar(x))
  hour = as.numeric(substr(x,1,2))
  a= hour==12
  b= PorA=='A'
  AdjHour=ifelse(a&b,hour-12,hour)
  
  minute = as.numeric(substr(x,4,5))
  Offset=ifelse(PorA == 'A', 0,12)
  RevTime=(Offset+AdjHour)*60+minute
  RevTimeA= ifelse(RevTime > 1440, RevTime-720,RevTime)
  labels=c('0-3','3-6','6-9','9-12','12-15','15-18','18-21','21-24')
  
  DataCut=cut(RevTimeA, breaks=c(0,180,360,540,720,900,1080,1260, 1440), labels=labels, include.lowest=TRUE)
  return (DataCut)
}
ggplot(data=r) + geom_bar(aes(x=clean_time(Violation.Time))) + scale_y_continuous(labels = comma)

#clean_time(q$Violation.Time)
#df_cuts=r %>% mutate(time_cut=clean_time(Violation.Time))

finaldf=read.csv('nc.csv')
finaldf = finaldf %>% mutate(time_cut=clean_time(Violation.Time)) %>% mutate(remain_amt=Fine.Amount+Penalty.Amount+Interest.Amount-Reduction.Amount-Payment.Amount,pct_remain_amt=(Amount.Due)/(Fine.Amount+Penalty.Amount+Interest.Amount-Reduction.Amount))
write.csv(finaldf,'ncfinal.csv')

colnames(finaldf)

