# Helper Functions

#' Convert a string of X-SAMPAs to a string of IPAs
#'
#' @importFrom magrittr %>%
#' @keywords internal
xsampa2ipa <- function(string) {

  # X-SAMPA IPA Lookup Table
  dat <- ipa_xsampa # internal data

  in_txt <- string %>%
      stringr::str_split(pattern = " ") %>%
      unlist()
  idx <- match(in_txt, dat$XSAMPA)
  out_txt <- paste(dat$IPA[idx], collapse = "") %>%
    stringr::str_remove_all("NA")
  return(out_txt)
}


#' Clean the description of ipafeatures
#' @keywords internal
clean_dscrb <- function(x) {
  x <- stringr::str_remove(x, "   .+$")
  return(paste0(x, collapse = ""))
}


#' Conditional Compilation
#'
#' \code{cond_cmpl} wraps a sequence of IPA string
#' with LaTeX code in R Markdown document when compiled
#' to LaTeX. When compiled to HTML, returns the
#' original sequence.
#'
#' @param ipa String. A sequence of IPA symbols.
#'
#' @export
cond_cmpl <- function(ipa) {
  if (knitr::opts_knit$get('rmarkdown.pandoc.to') == "latex") {
    ipa <- paste0("\\ipatext{", ipa, "}")
  }
  return(ipa)
}
