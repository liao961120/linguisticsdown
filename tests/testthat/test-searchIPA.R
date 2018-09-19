context("R/data-search-ipa.R")

test_that("search IPA returns properly", {
  expect_equal(nrow(searchIPA("_h", "xsampa")), 1)
  expect_true(nrow(searchIPA("affricate", "feature")) > 1)
})
