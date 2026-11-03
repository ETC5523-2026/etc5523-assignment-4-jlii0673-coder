#' Summarise penguin body measurements by species
#'
#' Calculate mean body mass and flipper length for each species.
#' Only observations with both measurements available are used.
#'
#' @param data A data frame containing species, body_mass_g,
#'   and flipper_length_mm.
#'
#' @return A data frame with one row per species and columns:
#'   species, n_total, n_complete, n_excluded, mean_body_mass_g,
#'   and mean_flipper_length_mm.
#'   Means are NA when no complete observations are available.
#'
#' @export
#'
#' @examples
#' summarise_penguins(penguin_data)
summarise_penguins <- function(data) {
  
  required <- c(
    "species",
    "body_mass_g",
    "flipper_length_mm"
  )
  
  if (!is.data.frame(data) ||
      !all(required %in% names(data))) {
    stop(
      "data must be a data frame containing: ",
      paste(required, collapse = ", "),
      call. = FALSE
    )
  }
  
  if (!is.numeric(data$body_mass_g) ||
      !is.numeric(data$flipper_length_mm)) {
    stop("Measurement columns must be numeric.", call. = FALSE)
  }
  
  # An empty input returns an empty table with consistent columns.
  result <- data.frame(
    species = character(),
    n_total = integer(),
    n_complete = integer(),
    n_excluded = integer(),
    mean_body_mass_g = double(),
    mean_flipper_length_mm = double()
  )
  
  groups <- sort(unique(as.character(
    data$species[!is.na(data$species)]
  )))
  
  for (group in groups) {
    
    rows <- data[
      !is.na(data$species) & data$species == group,
      ,
      drop = FALSE
    ]
    
    complete <- stats::complete.cases(
      rows[, c("body_mass_g", "flipper_length_mm")]
    )
    
    valid <- rows[complete, , drop = FALSE]
    n_valid <- nrow(valid)
    
    result <- rbind(
      result,
      data.frame(
        species = group,
        n_total = nrow(rows),
        n_complete = n_valid,
        n_excluded = nrow(rows) - n_valid,
        mean_body_mass_g = if (n_valid > 0) {
          mean(valid$body_mass_g)
        } else {
          NA_real_
        },
        mean_flipper_length_mm = if (n_valid > 0) {
          mean(valid$flipper_length_mm)
        } else {
          NA_real_
        }
      )
    )
  }
  
  result
}