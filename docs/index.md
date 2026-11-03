# Penguin Explorer

`exploredata` is an R package containing prepared Palmer penguin data, a
summary function, and an interactive Shiny app.

## Intended user and question

This app is designed for undergraduate biology students learning about
differences in body size among penguin species.

**Question:** How do body mass and flipper length differ among Adelie,
Chinstrap and Gentoo penguins, and how do these comparisons change when
viewing males and females separately?

## Installation

Install the package from GitHub:

``` r
# Run once if remotes is not installed:
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

The app runs locally and uses data included in the installed package. It
does not download data when launched.

## Using the app

1.  Select the species you want to compare.
2.  Choose All, Male or Female.
3.  Compare the scatterplot and summary table.
4.  Switch between sexes to investigate whether the species differences
    remain visible.

Each point represents one penguin. The horizontal axis shows flipper
length in millimetres; the vertical axis shows body mass in grams.
Colour identifies species.

The summary table reports selected, complete and excluded record counts,
together with mean body mass and mean flipper length. Both means use
records with both measurements available.

All includes records with unknown sex. Selecting Male or Female excludes
records with unknown sex.

If no species are selected, the app asks you to select at least one.

## Summary function

``` r
summarise_penguins(penguin_data)
```

[`summarise_penguins()`](https://etc5523-2026.github.io/etc5523-assignment-4-jlii0673-coder/reference/summarise_penguins.md)
calculates sample counts and mean measurements by species. The app uses
this exported function to generate its summary table.

## Data and reproducibility

The source is
[`palmerpenguins::penguins_raw`](https://allisonhorst.github.io/palmerpenguins/reference/penguins_raw.html),
containing 344 records. The prepared dataset retains species, island,
sex, flipper length and body mass.

The script `data-raw/prepare_penguins.R` selects and renames fields,
standardises sex labels, retains missing values, checks the data, and
saves `data/penguin_data.rda`.

To reproduce the prepared data, install the preparation tools and run
the script from the repository root:

``` r
install.packages(c("palmerpenguins", "dplyr", "usethis"))
source("data-raw/prepare_penguins.R")
```

Data were collected and made available by Dr Kristen Gorman and Palmer
Station LTER. The source data are distributed under CC0.

Source and citation information:
<https://allisonhorst.github.io/palmerpenguins/>

Horst AM, Hill AP, Gorman KB (2020). *palmerpenguins: Palmer Archipelago
(Antarctica) penguin data.* <https://doi.org/10.5281/zenodo.3960218>

## Interpretation and limitations

In the complete sample, Gentoo penguins have greater mean body mass and
mean flipper length than the other two species. Use the sex filter to
investigate whether this pattern is also visible within males and
females.

Group means do not describe all individual variation. Compare the
scatterplot as well as the table, and consider the unequal sample sizes
and excluded records.

These data describe sampled penguins in the Palmer Archipelago. They do
not necessarily represent all penguin populations. Observed associations
do not establish causal relationships.

## Licence

Package code: MIT. See LICENSE.md.

Source data: CC0.

## Generative AI declaration

I used ChatGPT to help plan the app’s intended user and question, draft
R code for data preparation, summary functions and the Shiny app,
suggest styling, draft documentation, and troubleshoot errors.

## Documentation website

<https://etc5523-2026.github.io/etc5523-assignment-4-jlii0673-coder/>
