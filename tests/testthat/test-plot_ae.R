test_that("plot_ae retourne un graphique ggplot", {

  data_test <- data.frame(
    TRTA = c("Placebo", "Placebo", "Traitement", "Traitement"),
    AEDECOD = c("Headache", "Nausea", "Headache", "Fatigue")
  )

  p <- plot_ae(
    data = data_test,
    traitement = "TRTA"
  )

  expect_s3_class(p, "ggplot")
})
