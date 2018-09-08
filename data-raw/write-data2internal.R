ipafeatures <- readRDS("data-raw/ipa-features.rds")
ipa_xsampa <- readRDS("data-raw/ipa-xsampa.rds")
tabf_infotext <- readRDS("data-raw/tabf_infotext.rds")
tabx_infotext <- readRDS("data-raw/tabx_infotext.rds")

devtools::use_data(ipafeatures, ipa_xsampa,
                   tabf_infotext, tabx_infotext,
                   internal = T, overwrite = T)
