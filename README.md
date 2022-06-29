
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MainExistingDatasets

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/MainExistingDatasets)](https://CRAN.R-project.org/package=MainExistingDatasets)
[![R build
status](https://github.com/baptisteCD/MainExistingDatasets/workflows/R-CMD-check/badge.svg)](https://github.com/baptisteCD/MainExistingDatasets/actions)
<!-- badges: end -->

Shiny for Open Science to visualize, share, and inventory the main
existing human datasets for researchers.

## Installation

Required: - Softwares : R (≥ 2.10) - R libraries : see the
[DESCRIPTION](https://github.com/baptisteCD/MainExistingDatasets/blob/develop/DESCRIPTION)
file.

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("baptisteCD/MainExistingDatasets")
```

## Run the Shiny server

``` r
MainExistingDatasets::run_app()
```

## Load the dataset

``` r
data(human_datasets, package = "MainExistingDatasets")
```
