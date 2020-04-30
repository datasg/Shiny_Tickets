library(shiny)
library(shinydashboard)
library(ggplot2)
library(scales)
library(dplyr)
library(DT)

# Read CSV & Sort Violations Descending
df=read.csv('ncfinal.csv')
sum_type_bytime  <- function(cut_time,df){
  df %>% filter(time_cut == cut_time) %>%
    group_by(Violation) %>%
    summarize(Value_Count=dplyr::n()) %>% 
    arrange(desc(Value_Count))

}

# Convert Times from AM,PM format To Minutes

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

# Test Sum_By_Type
sum_type_bytime('0-3',df)

# Time Ranges: 0-3 (12 AM- 3 AM) to 21-24 (9 PM- 12 AM)
time_ranges= c('0-3','3-6','6-9','9-12','12-15','15-18','18-21','21-24')


# graph Of Top 10 Tickets By Time 
max_violation=df %>% group_by(Violation)%>% summarize(Value_Count=dplyr::n()) %>% arrange(desc(Value_Count))
max_violation$Violation[1:10]
top_violations=max_violation$Violation[1:10]
q<- df %>% filter(Violation %in% top_violations) %>% 
ggplot() + geom_bar(aes(x=Violation, fill=clean_time(Violation.Time)), position= 'dodge')
q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
