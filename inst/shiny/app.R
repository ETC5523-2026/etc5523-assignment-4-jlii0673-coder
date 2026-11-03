library(shiny)

# Use data included in our package.
penguins <- exploredata::penguin_data

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f3f6fa;
        color: #243447;
        font-family: 'Segoe UI', Arial, sans-serif;
        font-size: 16px;
        line-height: 1.6;
      }

      .container-fluid {
        max-width: 1200px;
        margin: 0 auto;
        padding: 24px;
      }

      h2 {
        color: #153e54;
        font-weight: 700;
        margin-bottom: 18px;
      }

      h4 {
        color: #153e54;
        font-weight: 600;
        margin-top: 24px;
      }

      .well {
        background-color: #ffffff;
        border: 1px solid #dce5ed;
        border-top: 4px solid #167d9a;
        border-radius: 10px;
        padding: 22px;
      }

      .help-block {
        color: #526475;
      }

      #body_plot {
        background-color: #ffffff;
        border-radius: 10px;
      }

      #sample_note {
        background-color: #e4f1f5;
        border-left: 4px solid #167d9a;
        padding: 12px 16px;
        margin: 16px 0;
      }

      #summary_table {
        overflow-x: auto;
      }

      .table {
        background-color: #ffffff;
        font-size: 14px;
      }

      .table > thead > tr > th {
        background-color: #153e54;
        color: #ffffff;
        padding: 12px;
      }

      .table > tbody > tr > td {
        padding: 12px;
      }

      .shiny-output-error-validation {
        color: #8a4b08;
        font-weight: 600;
        padding: 16px;
      }
    "))
  ),
  titlePanel("Penguin Explorer"),
  
  p(
    "For undergraduate biology students exploring differences",
    "in body size among penguin species."
  ),
  
  h4("Our question"),
  p(
    "How do body mass and flipper length differ among species,",
    "and how do these comparisons change when viewing",
    "males and females separately?"
  ),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "species",
        "Choose species to compare:",
        choices = c("Adelie", "Chinstrap", "Gentoo"),
        selected = c("Adelie", "Chinstrap", "Gentoo")
      ),
      
      selectInput(
        "sex",
        "Choose sex:",
        choices = c("All", "Male", "Female"),
        selected = "All"
      ),
      
      helpText(
        "Select species, then compare all penguins or",
        "view males and females separately.",
        "All includes penguins with unknown sex."
      )
    ),
    
    mainPanel(
      plotOutput("body_plot"),
      
      p(
        "Each point represents one penguin.",
        "Points farther right have longer flippers;",
        "points higher up have greater body mass.",
        "Colour identifies species."
      ),
      
      textOutput("sample_note"),
      
      h4("Summary by species"),
      tableOutput("summary_table"),
      
      p(
        "These are descriptive comparisons of the sampled penguins.",
        "They do not establish causal relationships or necessarily",
        "represent all penguins."
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Recalculate whenever species or sex changes.
  filtered_data <- reactive({
    
    validate(
      need(
        length(input$species) > 0,
        "Please select at least one species."
      )
    )
    
    selected <- penguins[
      penguins$species %in% input$species,
      ,
      drop = FALSE
    ]
    
    if (input$sex != "All") {
      selected <- selected[
        !is.na(selected$sex) &
          selected$sex == input$sex,
        ,
        drop = FALSE
      ]
    }
    
    validate(
      need(
        nrow(selected) > 0,
        "No penguins match your selection. Try another filter."
      )
    )
    
    selected
  })
  
  # Use the exported summary function.
  summary_data <- reactive({
    exploredata::summarise_penguins(filtered_data())
  })
  
  output$body_plot <- renderPlot({
    
    selected <- filtered_data()
    
    complete <- stats::complete.cases(
      selected[, c("flipper_length_mm", "body_mass_g")]
    )
    
    validate(
      need(
        any(complete),
        "No complete measurements are available for this selection."
      )
    )
    
    ggplot2::ggplot(
      selected[complete, , drop = FALSE],
      ggplot2::aes(
        x = flipper_length_mm,
        y = body_mass_g,
        colour = species
      )
    ) +
      ggplot2::geom_point(size = 3, alpha = 0.7) +
      ggplot2::scale_colour_manual(
        values = c(
          Adelie = "#D55E00",
          Chinstrap = "#0072B2",
          Gentoo = "#009E73"
        ),
        drop = FALSE
      ) +
      ggplot2::labs(
        x = "Flipper length (mm)",
        y = "Body mass (g)",
        colour = "Species"
      ) +
      ggplot2::theme_minimal(base_size = 14)
  })
  
  output$sample_note <- renderText({
    
    summary <- summary_data()
    
    paste0(
      "Selected records: ", sum(summary$n_total),
      ". Complete measurements: ", sum(summary$n_complete),
      ". Excluded due to missing measurements: ",
      sum(summary$n_excluded), "."
    )
  })
  
  output$summary_table <- renderTable({
    
    summary <- summary_data()
    
    names(summary) <- c(
      "Species",
      "Selected records",
      "Complete records",
      "Excluded records",
      "Mean body mass (g)",
      "Mean flipper length (mm)"
    )
    
    summary
  }, digits = 1)
}

shinyApp(ui = ui, server = server)