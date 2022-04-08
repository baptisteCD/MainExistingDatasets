#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @noRd
app_ui <- function(request) {
    tagList(
        golem_add_external_resources(),
        fluidPage(
            title = "Main existing datasets",
            h1(toupper("Main existing datasets")),
            h4("Shiny for Open Science to visualize, share, and inventory the main existing human datasets for researchers."),
            br(),
            tmapOutput("map", width = 400, height = 300),
            tags$p(
                br(),
                strong("Tips:"),
                br(),
                "- To add new data please contact",
                tags$a(
                    href = "baptiste.couvy@icm-institute.org",
                    "Baptiste Couvy-Duchesne"
                ),
                "or make a PR on our",
                tags$a(
                    href = "https://github.com/baptisteCD/MainExistingDatasets",
                    "Github."
                ),
                br(),
                "- Use the filters under each column for a better navigation through the data."
            ),
            br(),
            DT::dataTableOutput("table_datasets")
        )
    )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @noRd
golem_add_external_resources <- function() {
    add_resource_path(
        "www", app_sys("app/www")
    )

    tags$head(
        favicon(),
        bundle_resources(
            path = app_sys("app/www"),
            app_title = "MainExistingDatasets"
        )
    )
}
