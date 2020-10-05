# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
setwd("~/Desktop/Gil_LabWork/Gil_packages/GK_shiny_app")
pkgload::load_all(export_all = F,helpers = F,attach_testthat = F)
options( "golem.app.prod" = TRUE)
SVMshiny::run_app() # add parameters here (if any)
# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()

