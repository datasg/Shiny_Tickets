library(shiny)
library(ggplot2)
library(scales)
library(dplyr)


violations=read.csv('ncfinal.csv')
sum_type_bytime  <- function(cut_time,df){
  df %>% filter(time_cut == cut_time) %>%
    group_by(Violation) %>%
    summarize(Value_Count=n()) %>% 
    arrange(desc(Value_Count))
  
}

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

time_ranges= c('0-3','3-6','6-9','9-12','12-15','15-18','18-21','21-24')

sum_type_bytime('0-3',violations)
