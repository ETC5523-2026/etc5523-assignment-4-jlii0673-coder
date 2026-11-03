# Getting started with Penguin Explorer

## Purpose

Penguin Explorer helps undergraduate biology students investigate:

**How do body mass and flipper length differ among Adelie, Chinstrap and
Gentoo penguins, and how do these comparisons change when viewing males
and females separately?**

## Install the package

Run these commands in your R console:

``` r
install.packages("remotes")

remotes::install_github(
  "ETC5523-2026/etc5523-assignment-4-jlii0673-coder"
)
```

## Launch the app

``` r
library(exploredata)
launch_app()
```

The app opens locally and uses data included in the installed package.
An internet connection is not needed to retrieve data when it runs.

## Use the controls

1.  Keep all three species selected to compare their distributions.
2.  Change the sex selection from All to Male, then Female.
3.  Observe how the points, sample counts and summary means change.
4.  Select two species to examine their overlap more closely.

All includes penguins with unknown sex. Male and Female include only
records with the selected recorded sex.

If you deselect every species, the app displays “Please select at least
one species.” Select a species again to restore the outputs.

## Read the outputs

Each point in the scatterplot represents one penguin:

- The horizontal axis shows flipper length in millimetres.
- The vertical axis shows body mass in grams.
- Colour identifies species.

Points toward the upper right represent heavier penguins with longer
flippers. Overlapping colours indicate similar measurements among
individuals of different species.

The table reports the number of selected records, complete records and
excluded records for each species. Both means use only records with body
mass and flipper length available. These are also the records displayed
in the scatterplot.

## Explore the summary function

The app uses the exported function
[`summarise_penguins()`](https://etc5523-2026.github.io/etc5523-assignment-4-jlii0673-coder/reference/summarise_penguins.md).
You can also use it directly:

``` r
library(exploredata)

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

In the full sample, Gentoo penguins have a mean body mass of
approximately 5,076 g and a mean flipper length of 217.2 mm. Both means
are greater than those of the other two species.

However, a group mean does not show all individual variation. Use the
scatterplot to examine overlap and spread.

To investigate the question within males:

``` r
male_data <- penguin_data[
  !is.na(penguin_data$sex) & penguin_data$sex == "Male",
  ,
  drop = FALSE
]

summarise_penguins(male_data)
#>     species n_total n_complete n_excluded mean_body_mass_g
#> 1    Adelie      73         73          0         4043.493
#> 2 Chinstrap      34         34          0         3938.971
#> 3    Gentoo      61         61          0         5484.836
#>   mean_flipper_length_mm
#> 1               192.4110
#> 2               199.9118
#> 3               221.5410
```

Repeat this comparison for females using the app. Check whether the
ordering of species remains the same and whether the sizes of the
differences change.

## Missing data and limitations

The prepared data contain 344 records. Two lack one or both
measurements, leaving 342 complete records in the overall plot and
summary means.

Filtering by sex also excludes records with unknown sex. Always read the
selected and excluded record counts alongside the results.

The data describe sampled penguins from the Palmer Archipelago. Species
have unequal sample sizes, and the sample does not necessarily represent
other places or penguin populations.

The comparisons are descriptive. An association between flipper length
and body mass does not establish a causal relationship.

## Data source and preparation

The data originate from
[`palmerpenguins::penguins_raw`](https://allisonhorst.github.io/palmerpenguins/reference/penguins_raw.html),
made available by Dr Kristen Gorman and Palmer Station LTER under CC0.

See the [Palmer Penguins
documentation](https://allisonhorst.github.io/palmerpenguins/) for
source and citation information.

The repository script `data-raw/prepare_penguins.R` selects relevant
fields, standardises names and sex labels, retains missing values,
checks the prepared data and saves the package dataset.
