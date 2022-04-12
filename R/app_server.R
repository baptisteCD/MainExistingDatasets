#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
app_server <- function(input, output, session) {
    data(human_datasets, envir = environment())
    data(world, package = "spData", envir = environment())
    path <- file.path("inst", "extdata")
    file <- "TableOfMainExistingDatasets.xlsx"

    vars <- reactiveValues(
        data = read.xlsx(file.path(path, file))
    )

    output$map <- renderTmap({
        human_dataset <- get_table_countries(vars$data)
        tm_shape(world, bbox = bb(matrix(c(50, 75, -20, -50), 2, 2))) +
            tm_borders(col = "gray", alpha = 0.5) +
            tm_shape(human_dataset) +
            tm_fill(col = "N", id = "name_long", style = "cat") +
            tm_layout(title = "Datasets around the world")
    })

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
