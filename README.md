# Malaria Prevalence Dashboard

This project contains an interactive **Shiny Dashboard** to visualize the malaria prevalence and associated statistics across the world. The dashboard allows users to generate insightful visualizations on malaria cases, deaths, and incidence rates based on provided datasets.

## Datasets

The dashboard uses three primary datasets:

1. **Estimated Numbers of Malaria Cases and Deaths** (`estimated_numbers.csv`)
    - Contains information about malaria cases, deaths, and associated statistics like median, min, and max values.

2. **Incidence per 1000 People at Risk** (`incidence_per_1000_pop_at_risk.csv`)
    - Provides data on the incidence of malaria per 1000 people at risk in different countries.

3. **Reported Numbers of Malaria Cases and Deaths** (`reported_numbers.csv`)
    - Contains the reported malaria cases and deaths by country and year.

## Features

- **Interactive Charts**: Visualize trends in malaria prevalence through bar charts, line graphs, scatter plots, and more.
- **Filter by Country**: Users can filter the data by country to get specific insights.
- **Visualize by Year**: Explore the malaria statistics over different years.
- **Incidence per 1000 People**: A detailed visualization of malaria incidence rates across the world.

## Getting Started

### Prerequisites

To run this dashboard locally, you will need to have the following installed:

- **R**: [Download R](https://cran.r-project.org/)
- **RStudio**: [Download RStudio](https://rstudio.com/products/rstudio/download/)
- **Shiny**: Install the `shiny` and `shinydashboard` R packages.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/Malaria_Prevalence_Dashboard.git
    ```

2. Open the project in **RStudio**.

3. Install the required R packages if you haven't already:

    ```r
    install.packages(c("shiny", "shinydashboard", "readr", "ggplot2"))
    ```

4. Run the Shiny app:

    ```r
    shiny::runApp("path/to/your/Malaria_Prevalence_Dashboard")
    ```

### Contributing

Feel free to fork this repository and submit pull requests for improvements. Contributions are always welcome!

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The datasets used in this project are sourced from global malaria data and health organizations.
- Thanks to the Shiny and R community for providing the tools to create this dashboard.
