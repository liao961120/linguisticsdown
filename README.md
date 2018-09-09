<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/liao961120/linguisticsdown.svg?branch=master)](https://travis-ci.org/liao961120/linguisticsdown) [![Support R Version](https://img.shields.io/badge/R-≥%203.4.0-blue.svg)](https://cran.r-project.org/)

linguisticsdown
===============

The goal of linguisticsdown is to support Linguistics-related doucument writing in R Markdown, such as providing a [Shiny Gadget](https://shiny.rstudio.com/articles/gadgets.html) to write and insert IPA symbols easily and functions to draw syntax tree (not implemented yet).

Installation
------------

``` r
devtools::install_github("liao961120/linguisticsdown")
```

Example
-------

Lunch shiny gadget for inserting IPA symbols:

``` r
library(linguisticsdown)
writeIPA()
```

To Do
-----

1.  Draw Syntax Tree
