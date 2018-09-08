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
      miniTabPanel("Features", icon = icon("search"),
        miniContentPanel(
          div(class = "row",
            div(class = "col-md-4 col-xs-6",
              selectInput("feat",
                        label = "Search:",
                        choices = ipafeatures,
                        multiple = TRUE,
                        selectize = TRUE),
              p("(e.g. ", em("plosive"), ", ", em("schwa"), ")")
            ),
            div(class = "col-md-4 col-xs-6",
              radioButtons("feat_format", "Insert Type",
                           choices = c("Plain symbols" = "html",
                                       "Support LaTeX" = "latex"),
                           selected = "html")
            )
          ),
          hr(),
          fluidRow(div(class = "col-md-4 col-xs-6",
                       verbatimTextOutput("feat2ipa")),
                   div(class = "col-md-4 col-xs-6",
                     actionButton("write_features", "Write",
                           class = "btn-primary")
                     )
                   ),
          tabf_infotext  # Saved in data-raw/ui-text/
          )
        ),
      # Tab x: xsampa to IPA
      miniTabPanel("XSAMPA", icon = icon("table"),
        miniContentPanel(
          textInput("text",
                    label = "X-SAMPA to IPA:",
                    value = "p _h A"),
          tabx_infotext, # Saved in data-raw/ui-text/
          hr(),
          fluidRow(
            column(3, verbatimTextOutput("xsamp2ipa"))
            ),
          radioButtons("xsampa_format", "Insert Type",
                       choices = c("Plain symbols" = "html",
                                   "Support LaTeX" = "latex"),
                       selected = "html"),
          actionButton("write_xsampa", "Write", class = "btn-primary")
          )
        )
    )
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

  runGadget(ui, server, stopOnCancel = FALSE)
}

