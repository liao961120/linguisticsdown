library(magrittr)

# Combine IPA and its feature descriptions to a vector
ipa_feat <- read.csv("data-raw/ipa-xsampa-modified.csv",
                stringsAsFactors = F,
                encoding = "UTF-8")[, -2] %>%
  tidyr::unite(IPA_feat, IPA, Name,
               sep = "   ") %>% unlist()

# Create Repeated List for shiny::selectInput
num_idx <- c(rep("", length(ipa_feat)),
             paste0(" (", rep(2:10, each = length(ipa_feat)), ")"))
ipa_feat <- paste0(ipa_feat, num_idx)

saveRDS(ipa_feat, "data-raw/ipa-features.rds")
