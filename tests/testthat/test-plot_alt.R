test_that("plot_alt retourne un graphique ggplot", {

  data_test <- data.frame(
    PARAM = rep("Alanine Aminotransferase (U/L)", 8),

    TRTA = c(
      "Placebo", "Placebo", "Placebo", "Placebo",
      "Traitement", "Traitement", "Traitement", "Traitement"
    ),

    AVISIT = c(
      "Baseline", "Week 1", "Week 2", "Week 3",
      "Baseline", "Week 1", "Week 2", "Week 3"
    ),

    AVISITN = c(0, 1, 2, 3, 0, 1, 2, 3),

    AVAL = c(20, 22, 21, 23, 20, 24, 26, 25)
  )

  p <- plot_alt(data_test)

  expect_s3_class(p, "ggplot")
})
