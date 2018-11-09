linguisticsdown
===============

The goal of **linguisticsdown** is to support Linguistics-related document writing in R Markdown, such as providing a [Shiny Gadget](https://shiny.rstudio.com/articles/gadgets.html) to write and insert IPA symbols easily and functions to draw syntax tree (not implemented yet).

Installation
------------

``` r
# CRAN
install.packages("linguisticsdown")

# Latest Version
devtools::install_github("liao961120/linguisticsdown")
```

Usage
-----

See **linguisticsdown** [web site](https://liao961120.github.io/linguisticsdown). Visit [this site](https://liao961120.shinyapps.io/IPA-Easily-Written/) to use Shiny live demo.

To Do
-----

1.  Correct IPA segments naming errors ([\#3](/../../issues/3))
2.  More Shiny gadget options
    -   Wrap in `/ /`, `[ ]`, or `don't wrap`
    -   Insert as decoded unicode
3.  Draw Syntax Tree

Data Source
-----------

Thanks [David R. Mortensen](https://github.com/dmort27) for his [IPA data](https://github.com/dmort27/epitran/blob/master/epitran/data/ipa-xsampa.csv).
