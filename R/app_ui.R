#' @import shiny
#' @import EBImage
app_ui <- function() {
  tagList(
    # List the first level UI elements here 
    fluidPage(
      h1("AI-PS...SVM..."),
      tabsetPanel(
        tabPanel("Image Setup",
                 mod_img_setup_ui("img_setup_ui_1")
        ),
        tabPanel("Segmentation",
                 tabsetPanel(
                   tabPanel("Nucleus Segmentation",
                            column(4, mod_nuc_params_ui("nuc_params_ui_1")),
                            column(8, mod_n_segment_ui("n_segment_ui_1"))),
                   tabPanel("Cell Segmentation",
                            sidebarLayout(
                              sidebarPanel(
                                mod_ph_params_ui("ph_params_ui_1")              
                              ),
                              mainPanel(
                                mod_ph_segment_ui("ph_segment_ui_1")
                              )
                            )), 
                   tabPanel("Save Image Parameters",
                            mod_dl_params_ui("dl_params_ui_1")
                   ))
        ),
        tabPanel("Image Classification",
                 shinyWidgets::dropdownButton(
                   checkboxInput("up_par", label = "Upload Segmentation Parameters?", value=FALSE),
                   uiOutput("params_ui"), size = "sm", 
                   circle = TRUE, status = "danger", icon = icon("exclamation-triangle"), width = "200px",
                   inline = TRUE, tooltip = TRUE, label = "Parameter Settings"
                 ),
                 tabsetPanel(
                   tabPanel("Positive", 
                            sidebarLayout(
                              sidebarPanel(
                                mod_img_dir_ui("img_dir_ui_1"),
                                actionButton(("button"), label="Load Image"),
                                br(),
                                br(),
                                downloadButton(("dl_training_P"),label="Save (+) Classification File"),
                              ),
                              mainPanel(
                                h4("Select Positive Cells"),
                                mod_classify_loop_ui("mod_classify_loop_ui_1")
                              )
                            )
                   ),
                   tabPanel("Negative", 
                            sidebarLayout(
                              sidebarPanel(
                                mod_img_dir_ui("img_dir_ui_2"),
                                actionButton(("button_n"), label="Load Image"),
                                downloadButton(("dl_training_N"),label="Save (-) Classification File"),
                              ),
                              mainPanel(
                                h4("Select Negative Cells"),
                                mod_classify_loop_ui("mod_classify_loop_ui_2")
                              )
                            )
        )
      )
    ),
    tabPanel("Create Model",
             mod_create_model_ui("create_model_ui_1")
    ),
    tabPanel("Test Model", 
             mod_test_model_ui("test_model_ui_1"))
  )
  )
)
}

#' @import shiny
# golem_add_external_resources <- function(){
#   
#   addResourcePath(
#     'www', system.file('app/www', package = 'SVMshiny')
#   )
#   
#   tags$head(
#     golem::activate_js(),
#     #golem::favicon()
#     # Add here all the external resources
#     # If you have a custom.css in the inst/app/www
#     # Or for example, you can add shinyalert::useShinyalert() here
#     #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
#   )
# }
