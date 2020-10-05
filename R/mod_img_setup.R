#' img_setup UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_img_setup_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        #h4("Select Image for Segmentation"),
        fileInput(ns("file"), 'Select Image for Segmentation', multiple = FALSE),
        #mod_img_dir_ui("img_dir_ui_1"),
        actionButton("reset_input","Reset inputs"),
        h4("Choose Channel Inputs"),
        mod_select_ch_ui(ns("select_ch_ui_1"))
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Channel 1", mod_display_ch_ui(ns("display_ch_ui_1"))),
          tabPanel("Channel 2", mod_display_ch_ui(ns("display_ch_ui_2"))),
          tabPanel("Channel 3", mod_display_ch_ui(ns("display_ch_ui_3"))),
          tabPanel("Channel 4", mod_display_ch_ui(ns("display_ch_ui_4")))
        )
      )
      
  )
  )
}
    
#' img_setup Server Function
#'
#' @noRd 
mod_img_setup_server <- function(input, output, session, r){
  ns <- session$ns
  img1 = reactive({
    f = input$file
    if (is.null(f))
      return(NULL)
      img1<-readImage(f$datapath, all=T)
      colorMode(img1)<-"Grayscale"
      return(img1)    
  })
  
  
  callModule(mod_display_ch_server, "display_ch_ui_1", img=img1, n=reactive(1), r)
  callModule(mod_display_ch_server, "display_ch_ui_2", img=img1, n=reactive(2), r)
  callModule(mod_display_ch_server, "display_ch_ui_3", img=img1, n=reactive(3), r)
  callModule(mod_display_ch_server, "display_ch_ui_4", img=img1, n=reactive(4), r)
  callModule(mod_select_ch_server, "select_ch_ui_1", r)
  
  

  return(img1)
 
}
    
## To be copied in the UI
# mod_img_setup_ui("img_setup_ui_1")
    
## To be copied in the server
# callModule(mod_img_setup_server, "img_setup_ui_1")
 
## To be copied in the UI
# mod_img_setup_ui("img_setup_ui_1")
    
## To be copied in the server
# callModule(mod_img_setup_server, "img_setup_ui_1")
 
