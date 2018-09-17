library(stringr)
library(dplyr)
dat <- read.csv("data-raw/ipa-xsampa-modified.csv",
                stringsAsFactors = F,
                encoding = "UTF-8") %>%
  mutate(X.SAMPA2 = str_replace_all(X.SAMPA,
                                    fixed("\\"), "/")) %>%
  select(IPA, X.SAMPA2, Name) %>%
  rename('XSAMPA' = X.SAMPA2)

saveRDS(dat, "data-raw/ipa-xsampa.rds")



# problematic <- c("glottalized", "syllable break", "uvular fricative")
# shouldbe <- c("NA", ".", "R")
#duplicate row: remove 158--glottal plosive
#erro row: remove 118--glottalized
#correct row: change 43--vd uvular fricative  R/ to R
#correct row change 135--syllable break IPA & X-SAMPA
