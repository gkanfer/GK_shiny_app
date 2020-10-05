app_server <- function(input, output,session) {
  # List the first level callModules here
  options(shiny.maxRequestSize=30*1024^2)
  observeEvent(input$reset_input,{
    shinyjs::reset("side-panel")
  })
  r <- reactiveValues()
  
  img1 <- callModule(mod_img_setup_server, "img_setup_ui_1", r)
  dapi_norm = callModule(mod_norm_ch_server, "norm_ch_ui_1", img=img1, n=reactive(r$mod3$DAPI), r)
  callModule(mod_nuc_params_server, "nuc_params_ui_1", r)
  nseg = callModule(mod_n_segment_server, "n_segment_ui_1", nuc_norm=dapi_norm, params=reactive(r$mod4))

  callModule(mod_ph_params_server, "ph_params_ui_1", r)
  pheno_norm = callModule(mod_norm_ch_server, "norm_ch_ui_2", img=img1, n=reactive(r$mod3$GFP))
  pseg = callModule(mod_ph_segment_server, "ph_segment_ui_1", ph_norm=pheno_norm, params=reactive(r$mod6), nseg=nseg, r)
  callModule(mod_dl_params_server, "dl_params_ui_1", r)
  
  callModule(mod_img_dir_server, "img_dir_ui_1", r)
  callModule(mod_img_dir_server, "img_dir_ui_2", r)

  callModule(mod_create_model_server, "create_model_ui_1", r)
  callModule(mod_test_model_server, "test_model_ui_1", r)
  
  output$params_ui = renderUI({
    if (input$up_par) {
      div(
        fileInput(("csv_file"), label=("Load the parameter (csv) file")),
        style = "padding-bottom: 0px; font-size: 80%; height:10 px"
      )
    }
  })
  
  observe({
    r$par = input$up_par
    r$csv = input$csv_file
  })
  
  count = 0
  observeEvent(input$button, {
    count <<- count + 1
    fn = nrow(r$img_dir$files)
    if (count == 0) {
      return(NULL)
    } else if (count <= fn) {
      callModule(mod_classify_loop_server, "mod_classify_loop_ui_1", r=r, classify=reactive("pos"), n=reactive(count))
    }
  })

  count2 = 0
  observeEvent(input$button_n, {
    count2 <<- count2 + 1
    fn = nrow(r$img_dir$files)
    if (count2 == 0) {
      return(NULL)
    } else if (count2 <= fn) {
      i = count2
      callModule(mod_classify_loop_server, "mod_classify_loop_ui_2", r=r, classify=reactive("neg"), n=reactive(i))
    } 
  })
  
  output$dl_training_P <- downloadHandler(
    filename <- function() {
      paste("positive_training.rds")
    },
    content <- function(file) {
      table <- r$loop$pos
      saveRDS(table, file=file)
    }
  )
  output$dl_training_N <- downloadHandler(
    filename <- function() {
      paste("negative_training.rds")
    },
    content <- function(file) {
      table2 <- r$loop$neg
      saveRDS(table2, file=file)
    }
  )
}
