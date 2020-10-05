# Module UI
  
#' @title   mod_display_ch_ui and mod_display_ch_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_display_ch
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_display_ch_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("ch")),
    br(),
    sliderInput(ns("int"), "Image Intensity:", 1,500,100, step=5)
  )
}
    
# Module Server
    
#' @rdname mod_display_ch
#' @export
#' @keywords internal
    
mod_display_ch_server <- function(input, output, session, img, n, r){
  ns <- session$ns
  ch_f <- reactive({
    req(img())
    #browser()
    size <- as.numeric(dim(img()))
    chA <- img()[1:size[1], 1:size[2],n()] 
    colorMode(chA)<-"Grayscale"
    minCH <- min(as.vector(chA))
    maxCH <- min(as.vector(chA))
    ch_f<- normalize(chA, ft=c(0,1), c(minCH, maxCH))
  })
  output$ch <- renderPlot({
    #req(ch_f())
    plot(ch_f()*input$int)
  })
}
    
## To be copied in the UI
# mod_display_ch_ui("display_ch_ui_1")
    
## To be copied in the server
# callModule(mod_display_ch_server, "display_ch_ui_1")
 
