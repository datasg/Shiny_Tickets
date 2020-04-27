function(input, output) {
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        sum_type_bytime(input$time,violations)
            
    }))
    output$violationCount <- renderPlot({
        
        # Render a barplot
        ggplot(data=violations) + geom_bar(aes(x=clean_time(pct_remain_amt))) + scale_y_continuous(labels = comma)
            })

        
}


