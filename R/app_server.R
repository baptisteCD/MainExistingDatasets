#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
app_server <- function(input, output, session) {
    data(human_datasets, envir = environment())
    path <- file.path("inst", "extdata")
    file <- "TableOfMainExistingDatasets.xlsx"

    vars <- reactiveValues(
        data = read.xlsx(file.path(path, file)),
        ncol = NCOL(human_datasets)
    )

    output$table_datasets <- DT::renderDataTable(
        {
            vars$data
        },
        class = "cell-border stripe",
        server = TRUE,
        rownames = FALSE,
        extensions = c("Scroller", "Buttons"),
        selection = "none",
        filter = "top",
        callback = JS('$("button.buttons-copy").css("background","#fff");
                    $("button.buttons-collection").css("background","#fff");
                    return table;'),
        options = list(
            initComplete = JS(
                "function(settings, json) {",
                "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                "}"
            ),
            dom = "Bfrtip",
            scrollY = 600, scrollX = 400, scroller = TRUE,
            buttons = list(
                "copy",
                list(
                    extend = "collection",
                    buttons = list(
                        list(extend = "csv", filename = file),
                        list(extend = "excel", filename = file)
                    ),
                    text = "Download"
                ),
                "colvis"
            )
        )
    )
}
