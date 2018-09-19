#' Lookup IPA symbols with phonetic features or X-SAMPA
#'
#' @param x Character. A (partial) term of the features of
#'   an IPA symbol or the (partial) X-SAMPA symbol
#'   corresponding to an IPA symbol. Defaults to \code{NULL},
#'   which returns all IPA symbols with corresponding features
#'   and X-SAMPA symbols.
#' @param search Character. Search mode, either \code{feature}
#'   or \code{xsampa}.
#'
#' @return A data frame with 3 rows.
#'
#' @examples
#' \dontrun{
#' # Check all IPA symbols
#' searchIPA()
#'
#' # Search with feature
#' searchIPA("bilabial", "feature")
#'
#' # Search with X-SAMPA
#' searchIPA("_h", "xsampa")
#' }
#' @importFrom stringr str_detect
#' @export
searchIPA <- function(x = NULL , search = c("feature", "xsampa")) {

  if (is.null(x)) return(ipa_xsampa)

  stopifnot(search[1] %in% c("feature", "xsampa"))

  if (search[1] == "feature") {
    idx <- str_detect(ipa_xsampa$Name, x)
  } else {
    idx <- str_detect(ipa_xsampa$XSAMPA, x)
  }
  return(ipa_xsampa[idx, ])
}
