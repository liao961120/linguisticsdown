#' Insert IPA symbols with Shiny app
#'
#' \code{writeIPA} opens a shiny gadget in the viewer pane of RStudio
#' to let users insert a sequence of IPA symbols into
#' the source pane or console.
#' Users can choose to use phonetic features (such as
#' \emph{aspirated}, \emph{schwa},
#' \emph{vl}(voiceless) / \emph{vd}(voiced), etc.) to find IPA
#' symbols or use the
#' \href{https://en.wikipedia.org/wiki/X-SAMPA}{X-SAMPA}
#' input method directly. Note that due to the special
#' meanings of backslash(\code{\\}) in programming,
#' \strong{backslashes(\code{\\}) in X-SAMPA symbols are
#' replaced with slashes(\code{/})}.
#'
#' @return Inserted plain text at the cursor returned by
#'   \link[rstudioapi]{insertText}.
#'
#' @source
#'   \url{https://github.com/dmort27/epitran/blob/master/epitran/data/ipa-xsampa.csv}
#'
#' @import shiny
#' @import miniUI
#'
#' @export
writeIPA <- function() {
  ui <- miniPage(
    gadgetTitleBar("IPA Easily Written",
                   right = NULL),
    miniTabstripPanel(
      # Tab f: features to IPA
      miniTabPanel("Features", icon = icon("tag", lib = "glyphicon"),
        miniContentPanel(
          div(class = "row",
            div(class = "col-md-5 col-md-offset-2 col-xs-6",
                h6(strong('Output:')),
                verbatimTextOutput("feat2ipa"),
                br(),
                radioButtons("feat_format", "Insert Format",
                             choices = c("Plain symbols" = "html",
                                         "LaTeX" = "latex"),
                             selected = "html")
            ), # end div col2
            div(class = "col-md-3 col-md-offset-1 col-xs-6",
              selectInput("feat",
                        label = "Search:",
                        choices = ipafeatures,
                        multiple = TRUE,
                        selectize = TRUE),
              p(em("Type to search matched phonetic features."),
                style = "font-size: 0.8em")
            ) # end div col1
          ), # end div.row
          hr(),
          fluidRow(div(class = "col-md-4 col-md-offset-1 col-xs-12",
                       actionButton("write_features", "Write",
                                    class = "btn-success"),
                       tabf_infotext  # Saved in data-raw/ui-text/
                       )
                   ) # end fluidRow
          ) # end miniContentPanel
        ), # end miniTabPanel

      # Tab x: xsampa to IPA
      miniTabPanel("XSAMPA", icon = icon("table"),
        miniContentPanel(
          div(class = "row",
            div(class = "col-md-5 col-md-offset-2 col-xs-6",
                h6(strong('Output:')),
                verbatimTextOutput("xsamp2ipa"),
                br(),
                radioButtons("xsampa_format", "Insert Format",
                       choices = c("Plain symbols" = "html",
                                   "LaTeX" = "latex"),
                       selected = "html")
            ),
            div(class = "col-md-3 col-md-offset-1 col-xs-6",
              textInput("text",
                        label = "X-SAMPA to IPA:",
                        value = "p _h A"),
              tabx_infotext  # Saved in data-raw/ui-text/
            )
          ), # end div.row
          hr(),
          fluidRow(
            div(class = "col-md-5 col-md-offset-1 col-xs-6",
              actionButton("write_xsampa", "Write",
                           class = "btn-success")
              )
            ) # end fluidRow
          ) # end miniContentPanel
        ), # end miniTabPanel (tabx)

      # Tabl: IPA table
      miniTabPanel("Lookup", icon = icon("search"),
        miniContentPanel(
            DT::dataTableOutput('lookup',
                                height = "100%")
          )
      )


      ) # end miniTabstripPanel
  ) # end ui

  server <- function(input, output, session) {

    # Interactive Display of IPA symbols
    output$xsamp2ipa <- renderPrint({
      cat(xsampa2ipa(input$text))
    })

    # Feature Input
    output$feat2ipa <- renderPrint({
      cat(clean_dscrb(input$feat))
      })

    # Tab l: IPA lookup table
    output$lookup <- DT::renderDT(ipa_xsampa, rownames = FALSE,
                                  options = list(pageLength = 4,
                                                 dom = 'ftp'))

    # Handle the 'Write' buttom being pressed.
    ## Tab f: features
    observeEvent(input$write_features, {
      if (input$feat_format == "html") {
        return_val <- clean_dscrb(input$feat)
        stopApp(rstudioapi::insertText(return_val))
      } else {
        return_val <- paste0('`r linguisticsdown::cond_cmpl("',
                             clean_dscrb(input$feat),
                             '")`')
        stopApp(rstudioapi::insertText(return_val))
      }
    })

    ## Tab x: xsampa
    observeEvent(input$write_xsampa, {
      if (input$xsampa_format == "html") {
        return_val <- xsampa2ipa(input$text)
        stopApp(rstudioapi::insertText(return_val))
      } else {
        return_val <- paste0('`r linguisticsdown::cond_cmpl("',
                             xsampa2ipa(input$text),
                             '")`')
        stopApp(rstudioapi::insertText(return_val))
      }
    })


    # Handel Cancel button
    observeEvent(input$cancel, {
      stopApp(cat("Canceled"))
    })

  } # end server

  runGadget(ui, server, stopOnCancel = FALSE,
            viewer = paneViewer(minHeight = 385))
}

