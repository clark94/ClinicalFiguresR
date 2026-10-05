#' Courbe d'evolution de l'ALT au cours du temps
#'
#' Cette fonction represente la moyenne de l'ALT
#' a chaque visite pour chaque groupe de traitement.
#'
#' @param data Jeu de donnees ADaM contenant les donnees ALT.
#'
#' @return Un objet ggplot.
#'
#' @export

plot_alt_time <- function(data) {

  # Selection de l'ALT
  df <- data[
    data$PARAM == "Alanine Aminotransferase (U/L)" &
      !is.na(data$AVAL) &
      !is.na(data$TRTA) &
      !is.na(data$AVISIT),
  ]

  # Nettoyage des noms de visites
  df$AVISIT <- trimws(df$AVISIT)

  # Visites que nous voulons afficher
  visits <- c(
    "Baseline",
    "Week 2",
    "Week 4",
    "Week 6",
    "Week 8",
    "Week 12",
    "Week 16",
    "Week 20",
    "Week 24"
  )

  df <- df[df$AVISIT %in% visits, ]

  # Ordre chronologique
  df$AVISIT <- factor(
    df$AVISIT,
    levels = visits
  )

  # Calcul moyenne + erreur standard
  summary_data <- aggregate(
    AVAL ~ AVISIT + TRTA,
    data = df,
    FUN = function(x) {
      c(
        mean = mean(x, na.rm = TRUE),
        se = sd(x, na.rm = TRUE) / sqrt(length(x))
      )
    }
  )

  # Transformer le resultat
  plot_data <- data.frame(
    AVISIT = summary_data$AVISIT,
    TRTA = summary_data$TRTA,
    mean = summary_data$AVAL[, "mean"],
    se = summary_data$AVAL[, "se"]
  )

  # Graphique
  p <- ggplot2::ggplot(
    plot_data,
    ggplot2::aes(
      x = AVISIT,
      y = mean,
      group = TRTA,
      linetype = TRTA,
      shape = TRTA
    )
  ) +

    ggplot2::geom_line(
      linewidth = 0.8
    ) +

    ggplot2::geom_point(
      size = 2.5
    ) +

    ggplot2::geom_errorbar(
      ggplot2::aes(
        ymin = mean - se,
        ymax = mean + se
      ),
      width = 0.15
    ) +

    ggplot2::labs(
      title = "Evolution de l'ALT au cours du temps",
      subtitle = "Moyenne ? erreur standard par groupe de traitement",
      x = "Visite",
      y = "ALT moyenne (U/L)",
      linetype = "Traitement",
      shape = "Traitement"
    ) +

    ggplot2::theme_minimal(
      base_size = 12
    ) +

    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        hjust = 1
      ),
      legend.position = "bottom"
    )

  return(p)
}
