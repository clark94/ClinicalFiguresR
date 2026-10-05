test_that("analyse_alt retourne les resultats attendus", {

  data_test <- data.frame(
    AVISIT = c("Week 24", "Week 24", "Week 24", "Week 24"),
    PARAM = rep("Alanine Aminotransferase (U/L)", 4),
    BASE = c(20, 22, 21, 20),
    AVAL = c(21, 23, 25, 26),
    TRTA = c("Placebo", "Placebo", "Treatment A", "Treatment A")
  )

  result <- analyse_alt(
    data = data_test,
    visit = "Week 24",
    placebo = "Placebo"
  )

  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)

  expect_true(all(
    c(
      "traitement",
      "estimate",
      "lower",
      "upper",
      "p_value",
      "n_traitement",
      "n_placebo"
    ) %in% names(result)
  ))

  expect_equal(result$n_placebo[1], 2)
  expect_equal(result$n_traitement[1], 2)
})
