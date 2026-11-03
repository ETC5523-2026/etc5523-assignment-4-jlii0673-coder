# Prepare data for Penguin Explorer
# Source: palmerpenguins::penguins_raw
# https://allisonhorst.github.io/palmerpenguins/
# Data licence: CC0
# Run this script from the package project root.

raw <- palmerpenguins::penguins_raw

# Select fields and give them consistent names.
penguin_data <- dplyr::transmute(
  raw,
  species = sub(" .*", "", Species),
  island = Island,
  sex = dplyr::case_when(
    Sex == "MALE" ~ "Male",
    Sex == "FEMALE" ~ "Female",
    TRUE ~ NA_character_
  ),
  flipper_length_mm = `Flipper Length (mm)`,
  body_mass_g = `Body Mass (g)`
)

# Keep missing values so their treatment can be explained
# explicitly in the app and summary function.

# Check the prepared data.
stopifnot(
  nrow(penguin_data) == 344L,
  all(penguin_data$species %in% c("Adelie", "Chinstrap", "Gentoo")),
  all(
    is.na(penguin_data$flipper_length_mm) |
      penguin_data$flipper_length_mm > 0
  ),
  all(
    is.na(penguin_data$body_mass_g) |
      penguin_data$body_mass_g > 0
  )
)

# Save the dataset inside this package.
usethis::use_data(penguin_data, overwrite = TRUE)