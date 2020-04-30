shinyServer(function(input, output,session) {#Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable(
    
  {
    sum_type_bytime(input$time,df)
    
  }))
  output$violationCount <- renderPlot({
    
    # Render a barplot
    q<- df %>% filter(Violation %in% top_violations) %>% 
      ggplot() + geom_bar(aes(x=Violation, fill=clean_time(Violation.Time)), position= 'dodge')
    q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
    
    })
 
  
  
})
