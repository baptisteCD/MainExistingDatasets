#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @noRd
app_server <- function(input, output, session) {
    data(human_datasets, package = "MainExistingDatasets", envir = environment())
    data(world, package = "spData", envir = environment())
    file <- "TableOfMainExistingDatasets.xlsx"
    cols <- colnames(human_datasets)[7:12]

    vars <- reactiveValues(
        data = human_datasets
    )

    updateSelectizeInput(
        inputId = "na_col",
        choices = sort(cols),
        server = TRUE,
        selected = NULL,
        options = list(
            maxItems = length(cols),
            maxOptions = length(cols),
            placeholder = "Select a column",
            mode = "multi"
        )
    )

    output$map <- renderTmap({
        pdf(file = NULL)
        human_dataset <- get_table_countries(human_datasets, world)
        tm_shape(world, bbox = bb(matrix(c(50, 75, -20, -50), 2, 2))) +
            tm_borders(col = "gray", alpha = 0.5) +
            tm_shape(human_dataset) +
            tm_fill(col = "Nb. of samples", id = "name_long", style = "cat") +
            tm_layout(title = "Datasets around the world")
    })

    observe({
        if (!is.null(input$na_col) && input$na_col != "") {
            vars$data <- drop_na(human_datasets, all_of(input$na_col))
        } else {
            vars$data <- human_datasets
        }
    })

    output$table_datasets <- DT::renderDataTable(
        {
            refresh <- input$na_col
            vars$data
        },
        class = "cell-border stripe",
        rownames = FALSE,
        extensions = c("Scroller", "Buttons"),
        selection = "none",
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
            columnDefs = list(
                list(
                    targets = "_all",
                    render = JS(
                        "function(data, type, row, meta) {",
                        "return type === 'display' && data != null && data.length > 50 ?",
                        "'<span title=\"' + data + '\">' + data.substr(0, 50) + '...</span>' : data;",
                        "}"
                    )
                )
            ),
            scrollY = 600, scrollX = 400, scroller = TRUE,
            searchHighlight = TRUE,
            search = list(regex = TRUE),
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
