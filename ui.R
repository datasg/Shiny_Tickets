dashboardPage(
    dashboardHeader(title = 'NYC Tickets'),
    dashboardSidebar(
        sidebarUserPanel(tags$p(style="color:navy")), 
        sidebarMenu(menuItem("Ticket Time",tabName = "Time"), 
                    menuItem("Ticket Time Plot",tabName = "Plot")),
        selectInput("time",
                    "Time Range:",
                    time_ranges)
    ),
    
    dashboardBody(
        tabItems(
            tabItem(tabName = "Time", 
                    tags$h3("Ticket Time"),
                    tags$p("Tickets"),
                    DT::dataTableOutput("table"),
                    
                    br()),
            tabItem(tabName = "Plot", 
                    tags$h3("Ticket Time"),
                    tags$p("Tickets"),
                    plotOutput("violationCount"),
                    br())
)
    ))
