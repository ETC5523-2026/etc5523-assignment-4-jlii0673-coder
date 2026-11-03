# Penguin body measurements

Prepared measurements for 344 penguins from the Palmer Archipelago,
Antarctica. Intended for comparing body mass and flipper length among
species and between sexes.

## Usage

``` r
penguin_data
```

## Format

A data frame with 344 rows and 5 variables:

- species:

  Penguin species: Adelie, Chinstrap, or Gentoo.

- island:

  Island where the penguin was observed.

- sex:

  Recorded sex: Male or Female. Unknown values are NA.

- flipper_length_mm:

  Flipper length in millimetres.

- body_mass_g:

  Body mass in grams.

## Source

Palmer Station LTER and Kristen Gorman, via the palmerpenguins package.
<https://allisonhorst.github.io/palmerpenguins/>

## Details

Missing values are retained. Analyses should explicitly report which
observations are excluded because of missing measurements or unknown
sex.

Prepared using the script in data-raw/prepare_penguins.R. The source
data are distributed under CC0.

## Examples

``` r
head(penguin_data)
#> # A tibble: 6 × 5
#>   species island    sex    flipper_length_mm body_mass_g
#>   <chr>   <chr>     <chr>              <dbl>       <dbl>
#> 1 Adelie  Torgersen Male                 181        3750
#> 2 Adelie  Torgersen Female               186        3800
#> 3 Adelie  Torgersen Female               195        3250
#> 4 Adelie  Torgersen NA                    NA          NA
#> 5 Adelie  Torgersen Female               193        3450
#> 6 Adelie  Torgersen Male                 190        3650
table(penguin_data$species)
#> 
#>    Adelie Chinstrap    Gentoo 
#>       152        68       124 
```
