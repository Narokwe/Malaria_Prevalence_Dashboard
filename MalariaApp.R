---
title: "Malaria Prevalence Dashboard"
author: "Augustine Narokwe"
output: 
  shinydashboard::dashboardPage
runtime: shiny
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# 1. Installing the required Libraries

```{r}
install.packages("shiny")
install.packages("shinydashboard")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("plotly")
install.packages("readr")
install.packages("tidyr")
```

# 2. Loading the packages

```{r}
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(readr)
library(tidyr)
```

# 3. Loading the Datasets

```{r}
estimated_numbers <- read_csv("C:\\Users\\DELL\\Downloads\\estimated_numbers.csv")
incidence_per_1000_pop_at_risk <- read_csv("C:\\Users\\DELL\\Downloads\\incidence_per_1000_pop_at_risk.csv")
reported_numbers <- read_csv("C:\\Users\\DELL\\Downloads\\reported_numbers.csv")
```

# 4. Checking if the datasets have been loaded successfully

## 4.1 Verify the structures of the datasets

```{r}
str(estimated_numbers)
str(incidence_per_1000_pop_at_risk)
str(reported_numbers)
```

## 4.2 Print the first few rows of the datasets

```{r}
head(estimated_numbers)
head(incidence_per_1000_pop_at_risk)
head(reported_numbers)
```

# 5. Data Wrangling

## 5.1 Clean and Wrangle the datasets

```{r}
estimated_numbers_clean <- estimated_numbers %>%
  select(Country, Year, `No. of cases`, `No. of deaths`, `WHO Region`) %>%
  filter(!is.na(`No. of cases`))

incidence_clean <- incidence_per_1000_pop_at_risk %>%
  select(Country, Year, `No. of cases`, `WHO Region`) %>%
  filter(!is.na(`No. of cases`))

reported_clean <- reported_numbers %>%
  select(Country, Year, `No. of cases`, `No. of deaths`, `WHO Region`) %>%
  filter(!is.na(`No. of cases`))
```

# 5.2 Combining datasets base on Country and Year for easier Comporison

```{r}
combined_data <- full_join(estimated_numbers_clean, incidence_clean, by = c("Country", "Year"))
combined_data <- full_join(combined_data, reported_clean, by = c("Country", "Year"))
```

# 6. Building the Shiny Dashboard

## 6.1 User Interface (UI)

```{r}
ui <- dashboardPage(
  dashboardHeader(title = "Malaria Data Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualizations", tabName = "visualizations", icon = icon("chart-line")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    ),
    textInput("country", "Enter Country", value = "Kenya"),
    numericInput("year", "Enter Year", value = 2020, min = 2000, max = 2025),
    actionButton("generate", "Generate Visualization")
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "visualizations",
              fluidRow(
                box(title = "Bar Chart of Malaria Cases", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("bar_chart"), width = 6),
                box(title = "Line Graph of Malaria Cases Over Time", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("line_graph"), width = 6),
                box(title = "Scatter Plot of Cases vs Deaths", status = "primary", solidHeader = TRUE, 
                    plotlyOutput("scatter_plot"), width = 6)
              )),
      
      tabItem(tabName = "about",
              h3("About the Dashboard"),
              p("This dashboard visualizes global malaria data to help decision-makers in tackling malaria issues.")
      )
    )
  )
)
```

## 6.2 Server Logic

```{r}
server <- function(input, output) {
  
  # Filter data based on user inputs
  filtered_data <- reactive({
    combined_data %>%
      filter(Country == input$country, Year == input$year)
  })
  
  # Generate bar chart
  output$bar_chart <- renderPlotly({
    data <- filtered_data()
    gg <- ggplot(data, aes(x = Country, y = `No. of cases`, fill = `WHO Region`)) +
      geom_bar(stat = "identity") +
      labs(title = "Malaria Cases by Country") +
      theme_minimal()
    ggplotly(gg)
  })
  
  # Generate line graph
  output$line_graph <- renderPlotly({
    data <- filtered_data()
    gg <- ggplot(data, aes(x = Year, y = `No. of cases`, color = Country)) +
      geom_line() +
      labs(title = "Malaria Cases Over Time") +
      theme_minimal()
    ggplotly(gg)
  })
  
  # Generate scatter plot
  output$scatter_plot <- renderPlotly({
    data <- filtered_data()
    gg <- ggplot(data, aes(x = `No. of cases`, y = `No. of deaths`, color = Country)) +
      geom_point() +
      labs(title = "Malaria Cases vs Deaths") +
      theme_minimal()
    ggplotly(gg)
  })
  
}
```

## 6.3 Running Shiny Dashboard Locally

```{r}
shinyApp(ui = ui, server = server)
```
