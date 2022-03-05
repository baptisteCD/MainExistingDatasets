#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
app_server <- function(input, output, session) {
    data(human_datasets, envir = environment())

    vars <- reactiveValues(
        data = human_datasets
    )

    output$table_datasets <- DT::renderDataTable(
        {
            vars$data
        }
    )
}
