library(igraph)
tree <- make_tree(20, 3)
plot(tree, layout=layout_as_tree)



library(stringr)
x <- '[SP "Some text" [NP ""][VP ""]]'

x2 <- '
[S
  [NP RSyntaxTree]
  [VP
    [V generates]
    [NP
      [Adj multilingual]
      [NP syntax trees]
    ]
  ]
]
'

## igraph solution (write tree to edge parser)
# https://stackoverflow.com/questions/33473107/visualize-parse-tree-structure

## nltk solution
# https://stackoverflow.com/questions/23429117/saving-nltk-drawn-parse-tree-to-image-file
# https://github.com/rstudio/reticulate
