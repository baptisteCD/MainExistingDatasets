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
        },
        class = "cell-border stripe",
        rownames = FALSE,
        extensions = c("Scroller", "Buttons"),
        selection = "none",
        editable = "cell",
        filter = "top",
        options = list(
            dom = "Bfrtip",
            scrollY = 600, scrollX = 400, scroller = TRUE,
            buttons = list(
                "copy", 
                list(
                    extend = "collection",
                    buttons = c("csv", "excel"),
                    text = "Download"
                ),
                "colvis"
            )
        )
    )
}
