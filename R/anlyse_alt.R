#' Analyse du changement d'ALT a une visite donnee
#'
#' Calcule le changement d'ALT par rapport a la baseline et compare
#' chaque groupe de traitement au groupe placebo avec un test de Welch.
#'
#' @param data Jeu de donnees contenant les mesures d'ALT.
#' @param visit Visite a analyser. Par defaut "Week 24".
#' @param placebo Nom du groupe placebo.
#'
#' @return Un data.frame contenant les differences moyennes et
#' les intervalles de confiance a 95 %.
#'
#' @export

analyse_alt <- function(
    data,
    visit = "Week 24",
    placebo = "Placebo"
) {

  # Nettoyage de la visite
  data$AVISIT <- trimws(data$AVISIT)

  # Selection des observations
  df <- data[
    trimws(data$AVISIT) == visit &
      data$PARAM == "Alanine Aminotransferase (U/L)" &
      !is.na(data$BASE) &
      !is.na(data$AVAL) &
      !is.na(data$TRTA),
  ]

  # Calcul du changement depuis la baseline
  df$CHG <- df$AVAL - df$BASE

  # Verification du placebo
  if (!placebo %in% df$TRTA) {
    stop("Le groupe placebo n'est pas present dans les donnees.")
  }

  # Traitements a comparer au placebo
  traitements <- setdiff(unique(df$TRTA), placebo)

  resultats <- lapply(traitements, function(trt) {

    placebo_values <- df$CHG[df$TRTA == placebo]
    treatment_values <- df$CHG[df$TRTA == trt]

    test <- stats::t.test(
      treatment_values,
      placebo_values
    )

    data.frame(
      traitement = paste(trt, "vs", placebo),
      estimate = mean(treatment_values) - mean(placebo_values),
      lower = test$conf.int[1],
      upper = test$conf.int[2],
      p_value = test$p.value,
      n_traitement = length(treatment_values),
      n_placebo = length(placebo_values)
    )
  })

  do.call(rbind, resultats)
}
