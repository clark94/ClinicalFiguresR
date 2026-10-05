#' Intrigue des evenements indesirables par traitement
#'
#' @param data Jeu de donnees ADaM ADAE.
#' @param traitement Variable de traitement.
#'
#' @return Un objet ggplot.
#' @export

plot_ae <- function(data, traitement = "TRTA") {

  if (!traitement %in% names(data)) {
    stop("Variable de traitement non trouvee dans le jeu de donnees.")
  }

  resume <- data |>
    dplyr::filter(!is.na(.data[[traitement]])) |>
    dplyr::count(.data[[traitement]])

  p <- ggplot2::ggplot(
    data = resume,
    mapping = ggplot2::aes(
      x = .data[[traitement]],
      y = .data[["n"]]
    )
  )

  p <- p +
    ggplot2::geom_col() +
    ggplot2::geom_text(
      ggplot2::aes(label = .data[["n"]]),
      vjust = -0.5,
      size = 4
    ) +
    ggplot2::labs(
      title = "Evenements indesirables par groupe de traitement",
      x = "Groupe de traitement",
      y = "Nombre d'evenements indesirables"
    ) +
    ggplot2::theme_minimal(base_size = 12)

  return(p)
}
