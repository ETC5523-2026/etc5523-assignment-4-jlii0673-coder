# Launch Penguin Explorer

Open a Shiny app for comparing penguin body mass and flipper length
among species and between sexes.

## Usage

``` r
launch_app(...)
```

## Arguments

- ...:

  Additional arguments passed to shiny::runApp().

## Value

Runs the Shiny application.

## Examples

``` r
if (interactive()) {
  launch_app()
}
```
