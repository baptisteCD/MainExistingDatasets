#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts.
#' See `?golem::get_golem_options` for more details.
#' @return An object that represents the app.
#' @inheritParams shiny::shinyApp
#' @inherit shiny::runApp description
#' @details For more information about this function, please take a look at 
#' \url{https://CRAN.R-project.org/package=golem/vignettes/c_deploy.html}.
#' @examples
#' \dontrun{
#' # Start app in the current working directory
#' run_app()
#'
#' # Start app in a subdirectory called myapp
#' run_app("myapp")
#' }
#' @export
run_app <- function(
    onStart = NULL,
    options = list(),
    enableBookmarking = NULL,
    uiPattern = "/",
    ...) {
    with_golem_options(
        app = shinyApp(
            ui = app_ui,
            server = app_server,
            onStart = onStart,
            options = options,
            enableBookmarking = enableBookmarking,
            uiPattern = uiPattern
        ),
        golem_opts = list(...)
    )
}
