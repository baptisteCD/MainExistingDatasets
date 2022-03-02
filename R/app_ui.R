#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @noRd
app_ui <- function(request) {
    tagList(
        golem_add_external_resources(),
        fluidPage(
            h1("MainExistingDatasets")
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
