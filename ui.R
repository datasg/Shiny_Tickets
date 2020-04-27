fluidPage(
    titlePanel("NYC Tickets"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
        column(4,
               selectInput("time",
                           "Time Range:",
                           time_ranges)
        ),
        
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table"),
    plotOutput("violationCount")

    
)

    