<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/liao961120/linguisticsdown.svg?branch=master)](https://travis-ci.org/liao961120/linguisticsdown) [![Support R Version](https://img.shields.io/badge/R-≥%203.4.0-blue.svg)](https://cran.r-project.org/)

linguisticsdown
===============

The goal of **linguisticsdown** is to support Linguistics-related doucument writing in R Markdown, such as providing a [Shiny Gadget](https://shiny.rstudio.com/articles/gadgets.html) to write and insert IPA symbols easily and functions to draw syntax tree (not implemented yet).

Installation
------------

``` r
devtools::install_github("liao961120/linguisticsdown")
```

Usage
-----

### Write IPA symbols by Phonetic Features

![](man/figs/features.gif)

### Write IPA symbols with [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA)

![](man/figs/xsampa.gif)

Conditional Compilation
-----------------------

IPA symbols may not be properly rendered when output to PDF, depending on the font chosen to compile LaTeX to PDF. See [wikipedia](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet#Typefaces) for a list of fonts supporting IPA symbols.

To overcome this problem, you can use a document template provided by **linguisticsdown** by calling:

``` r
rmarkdown::draft("name_your_file.Rmd",
                 template = "support_ipa",
                 package = "linguisticsdown")
```

, or if you use [RStudio](https://www.rstudio.com/): ![](man/figs/template.gif)

Then, make sure **"LaTeX" in "Insert Format" is selected** when inserting IPA symbols: ![](man/figs/latex.gif)

This option wraps the IPA symbols with the function `cond_cmpl()`, which wraps latex code around IPA symbols when compiled to LaTeX but leaves the symbols untouched when compiled to HTML formats. Hence, you can compiled to any format with properly rendered IPA symbols without changing the source file.

Note: make sure you have the font, [**Doulos SIL**](https://software.sil.org/doulos/download/), installed on your computer to make conditional compilation work. If you would like to use other fonts, read the document template `support_ipa` for more details.

To Do
-----

1.  Draw Syntax Tree
