library(shiny)

tabx_infotext <-p(
  'Use ', strong('slash'), '(/)', ' instead of ',
  strong('backslash'), '(\\) in X-SAMPA.',
  br(),
  'There must be',
  strong('one space character between two symbols'), '.'
  )


tabf_infotext <- div(br(), h4(strong('Details')),
  p('Search and select IPA symbols by typing their names,',
  'such as ', strong("vl plosive"), '(voiceless plosive).',
  'Note the trailing numbers at the end of the
  names of the IPA symbols have no meaning, they are
  just the result of a little hack to deal with some
  limitations of the app.'
  )
)

saveRDS(tabf_infotext, "data-raw/tabf_infotext.rds")
saveRDS(tabx_infotext, "data-raw/tabx_infotext.rds")
