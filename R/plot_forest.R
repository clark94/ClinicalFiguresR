#' Creer un Forest Plot des effets de traitement
#'
#' Cette fonction cree un Forest Plot a partir des resultats
#' d'une analyse clinique.
#'
#' @param data Jeu de donnees contenant les estimations.
#' @param traitement Nom de la colonne des traitements.
#' @param estimate Nom de la colonne des estimations.
#' @param lower Nom de la borne inferieure de l'IC a 95 %.
#' @param upper Nom de la borne superieure de l'IC a 95 %.
#'
#' @return Un objet ggplot.
#' @export

plot_forest <- function(
    data,
    traitement = "traitement",
    estimate = "estimate",
    lower = "lower",
    upper = "upper"
) {

  # Verification des colonnes obligatoires
  colonnes_requises <- c(
    traitement,
    estimate,
    lower,
    upper,
    "p_value",
    "n_traitement",
    "n_placebo"
  )

  colonnes_absentes <- setdiff(
    colonnes_requises,
    names(data)
  )

  if (length(colonnes_absentes) > 0) {
    stop(
      paste(
        "Colonnes manquantes :",
        paste(colonnes_absentes, collapse = ", ")
      )
    )
  }

  # Creation des etiquettes statistiques
  data$label <- sprintf(
    "Effet = %.2f | IC95%% [%.2f ; %.2f] | p = %.3f | n = %d vs %d",
    data[[estimate]],
    data[[lower]],
    data[[upper]],
    data$p_value,
    data$n_traitement,
    data$n_placebo
  )

  # Creation du Forest Plot
  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[estimate]],
      y = .data[[traitement]]
    )
  ) +

    # Intervalles de confiance a 95 %
    ggplot2::geom_errorbar(
      ggplot2::aes(
        xmin = .data[[lower]],
        xmax = .data[[upper]]
      ),
      width = 0.2
    ) +

    # Estimation ponctuelle
    ggplot2::geom_point(
      size = 3
    ) +

    # Ligne verticale correspondant a l'absence d'effet
    ggplot2::geom_vline(
      xintercept = 0,
      linetype = "dashed"
    ) +

    # Informations statistiques
    ggplot2::geom_text(
      ggplot2::aes(
        x = .data[[upper]],
        label = label
      ),
      hjust = -0.05,
      size = 3.3
    ) +

    # Titres
    ggplot2::labs(
      title = "Forest plot des effets de traitement",
      subtitle = "Variation de l'ALT a Week 24 par rapport a la baseline",
      x = "Difference moyenne vs placebo (IC 95 %)",
      y = "Traitement"
    ) +

    # Style
    ggplot2::theme_minimal(
      base_size = 12
    ) +

    # Ajouter de l'espace a droite pour les statistiques
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(
        mult = c(0.05, 0.75)
      )
    )

  return(p)
}
