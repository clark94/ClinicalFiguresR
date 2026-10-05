#' Evolution de l'ALT au cours du temps
#'
#' @param data Jeu de donnees ADaM ADLBHY.
#' @return Un objet ggplot.
#' @export

plot_alt <- function(data) {

  alt <- data |>
    dplyr::filter(
      PARAM == "Alanine Aminotransferase (U/L)",
      !is.na(AVAL),
      !is.na(TRTA),
      !is.na(AVISIT)
    ) |>
    dplyr::group_by(AVISIT, AVISITN, TRTA) |>
    dplyr::summarise(
      moyenne = mean(AVAL, na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::arrange(AVISITN)

  p <- ggplot2::ggplot(
    alt,
    ggplot2::aes(
      x = AVISITN,
      y = moyenne,
      group = TRTA,
      linetype = TRTA
    )
  ) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::geom_point(size = 2.5) +
    ggplot2::labs(
      title = "Evolution de l'ALT au cours du temps",
      x = "Visite",
      y = "ALT moyenne (U/L)",
      linetype = "Groupe de traitement"
    ) +
    ggplot2::theme_minimal(base_size = 12)

  return(p)
}
