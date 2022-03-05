#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
app_server <- function(input, output, session) {
    data(human_datasets, envir = environment())

    vars <- reactiveValues(
        data = human_datasets,
        ncol = NCOL(human_datasets)
    )

    proxy <- dataTableProxy("table_datasets")

    observeEvent(
        input$add,
        {
            req(proxy)
            proxy %>% addRow(
                data.frame(t(rep("", vars$ncol))),
                resetPaging = FALSE
            )
        }
    )

    output$table_datasets <- DT::renderDataTable(
        {
            vars$data
        },
        class = "cell-border stripe",
        server = FALSE,
        rownames = FALSE,
        extensions = c("Scroller", "Buttons"),
        selection = "none",
        editable = "cell",
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
                        list(extend = "csv", filename = "human_datasets"),
                        list(extend = "excel", filename = "human_datasets")
                    ),
                    text = "Download"
                ),
                "colvis"
            )
        )
    )
}
