#' Penguin body measurements
#'
#' Prepared measurements for 344 penguins from the Palmer Archipelago,
#' Antarctica. Intended for comparing body mass and flipper length
#' among species and between sexes.
#'
#' @format A data frame with 344 rows and 5 variables:
#' \describe{
#'   \item{species}{Penguin species: Adelie, Chinstrap, or Gentoo.}
#'   \item{island}{Island where the penguin was observed.}
#'   \item{sex}{Recorded sex: Male or Female. Unknown values are NA.}
#'   \item{flipper_length_mm}{Flipper length in millimetres.}
#'   \item{body_mass_g}{Body mass in grams.}
#' }
#' @details
#' Missing values are retained. Analyses should explicitly report
#' which observations are excluded because of missing measurements
#' or unknown sex.
#'
#' Prepared using the script in data-raw/prepare_penguins.R.
#' The source data are distributed under CC0.
#'
#' @source
#' Palmer Station LTER and Kristen Gorman, via the palmerpenguins package.
#' \url{https://allisonhorst.github.io/palmerpenguins/}
#'
#' @examples
#' head(penguin_data)
#' table(penguin_data$species)
"penguin_data"