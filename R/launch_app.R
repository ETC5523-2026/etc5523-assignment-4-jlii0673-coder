#' Launch Penguin Explorer
#'
#' Open a Shiny app for comparing penguin body mass and
#' flipper length among species and between sexes.
#'
#' @param ... Additional arguments passed to shiny::runApp().
#'
#' @return Runs the Shiny application.
#'
#' @importFrom ggplot2 ggplot
#' @export
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
launch_app <- function(...) {
  
  app_dir <- system.file(
    "shiny",
    package = "exploredata"
  )
  
  if (app_dir == "") {
    stop(
      "App files were not found. Please reinstall exploredata.",
      call. = FALSE
    )
  }
  
  shiny::runApp(appDir = app_dir, ...)
}