# Summarise penguin body measurements by species

Calculate mean body mass and flipper length for each species. Only
observations with both measurements available are used.

## Usage

``` r
summarise_penguins(data)
```

## Arguments

- data:

  A data frame containing species, body_mass_g, and flipper_length_mm.

## Value

A data frame with one row per species and columns: species, n_total,
n_complete, n_excluded, mean_body_mass_g, and mean_flipper_length_mm.
Means are NA when no complete observations are available.

## Examples

``` r
summarise_penguins(penguin_data)
#>     species n_total n_complete n_excluded mean_body_mass_g
#> 1    Adelie     152        151          1         3700.662
#> 2 Chinstrap      68         68          0         3733.088
#> 3    Gentoo     124        123          1         5076.016
#>   mean_flipper_length_mm
#> 1               189.9536
#> 2               195.8235
#> 3               217.1870
```
