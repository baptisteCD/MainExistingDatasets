# Launch the ShinyApp
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options("golem.app.prod" = TRUE)
MainExistingDatasets::run_app()
