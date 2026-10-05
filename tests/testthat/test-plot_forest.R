test_that("plot_forest retourne un graphique ggplot", {

  data_test <- data.frame(
    traitement = c(
      "Treatment A vs Placebo",
      "Treatment B vs Placebo",
      "Treatment C vs Placebo"
    ),

    estimate = c(-2.1, 1.5, -0.8),

    lower = c(-3.5, 0.2, -2.0),

    upper = c(-0.7, 2.8, 0.4),

    p_value = c(0.01, 0.03, 0.25),

    n_traitement = c(50, 48, 52),

    n_placebo = c(50, 50, 50)
  )

  p <- plot_forest(data_test)

  expect_s3_class(p, "ggplot")
})
