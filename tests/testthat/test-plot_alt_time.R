test_that("plot_alt_time retourne un graphique ggplot", {

  data_test <- data.frame(
    PARAM = rep("Alanine Aminotransferase (U/L)", 12),

    AVISIT = c(
      "Baseline", "Baseline",
      "Week 4", "Week 4",
      "Week 8", "Week 8",
      "Baseline", "Baseline",
      "Week 4", "Week 4",
      "Week 8", "Week 8"
    ),

    TRTA = c(
      rep("Placebo", 6),
      rep("Treatment A", 6)
    ),

    AVAL = c(
      20, 22,
      23, 21,
      24, 22,
      21, 23,
      25, 27,
      28, 30
    )
  )

  p <- plot_alt_time(data_test)

  expect_s3_class(p, "ggplot")
})
