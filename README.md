# ClinicalFiguresR

![R](https://img.shields.io/badge/R-4.4%2B-blue)
![Tests](https://img.shields.io/badge/tests-9%20passed-brightgreen)
![R CMD check](https://img.shields.io/badge/R%20CMD%20check-0%20errors%20%7C%200%20warnings-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

## Overview

**ClinicalFiguresR** is an R package designed to create standardized clinical-trial visualizations and perform simple treatment comparisons from ADaM-style datasets.

The project focuses on reproducible clinical programming workflows using **R**, **ggplot2**, **dplyr**, **roxygen2**, and **testthat**.

It was developed as a portfolio project to demonstrate skills in:

- clinical data analysis;
- ADaM-style dataset manipulation;
- reusable R function development;
- statistical visualization;
- treatment comparison;
- package documentation;
- automated testing;
- R package quality control.

---

## Main Features

### Adverse Event Visualization

`plot_ae()` summarizes adverse events by treatment group and produces a standardized `ggplot2` visualization.

Typical variables include:

- treatment group;
- adverse-event preferred term;
- event frequency.

---

### ALT Longitudinal Profile

`plot_alt()` creates a longitudinal visualization of mean **Alanine Aminotransferase (ALT)** values by visit and treatment group.

The function is designed for ADaM-style laboratory datasets containing variables such as:

```text
PARAM
TRTA
AVISIT
AVISITN
AVAL
```

---

### ALT Evolution Over Time

`plot_alt_time()` provides a longitudinal ALT profile and summarizes laboratory measurements across visits and treatment groups.

The visualization can include:

- mean ALT;
- visit;
- treatment group;
- standard error.

---

### Treatment Comparison

`analyse_alt()` performs simple treatment comparisons against placebo for a selected visit.

The output includes:

```text
treatment
estimate
lower
upper
p_value
n_treatment
n_placebo
```

This can be used directly as input for treatment-effect summaries and forest plots.

---

### Forest Plot

`plot_forest()` produces a standardized forest plot displaying:

- treatment effect estimates;
- 95% confidence intervals;
- p-values;
- treatment and placebo sample sizes.

This type of visualization is commonly used in clinical-trial reporting and subgroup analyses.

---

## Example

### Adverse Events

```r
library(ClinicalFiguresR)

ae_data <- data.frame(
  TRTA = c(
    "Placebo",
    "Placebo",
    "Treatment",
    "Treatment"
  ),
  AEDECOD = c(
    "Headache",
    "Nausea",
    "Headache",
    "Fatigue"
  )
)

plot_ae(
  data = ae_data,
  traitement = "TRTA"
)
```

---

### ALT Profile

```r
alt_data <- data.frame(
  PARAM = rep(
    "Alanine Aminotransferase (U/L)",
    8
  ),

  TRTA = c(
    "Placebo",
    "Placebo",
    "Placebo",
    "Placebo",
    "Treatment",
    "Treatment",
    "Treatment",
    "Treatment"
  ),

  AVISIT = c(
    "Baseline",
    "Week 1",
    "Week 2",
    "Week 3",
    "Baseline",
    "Week 1",
    "Week 2",
    "Week 3"
  ),

  AVISITN = c(
    0, 1, 2, 3,
    0, 1, 2, 3
  ),

  AVAL = c(
    20, 22, 21, 23,
    20, 24, 26, 25
  )
)

plot_alt(alt_data)
```

---

## Package Structure

```text
ClinicalFiguresR/
│
├── DESCRIPTION
├── NAMESPACE
├── LICENSE
├── README.md
├── ClinicalFiguresR.Rproj
│
├── R/
│ ├── analyse_alt.R
│ ├── plot_ae.R
│ ├── plot_alt.R
│ ├── plot_alt_time.R
│ ├── plot_forest.R
│ ├── globals.R
│ └── imports.R
│
├── man/
│ ├── analyse_alt.Rd
│ ├── plot_ae.Rd
│ ├── plot_alt.Rd
│ ├── plot_alt_time.Rd
│ └── plot_forest.Rd
│
├── tests/
│ ├── testthat.R
│ └── testthat/
│ ├── test-analyse_alt.R
│ ├── test-plot_ae.R
│ ├── test-plot_alt.R
│ ├── test-plot_alt_time.R
│ └── test-plot_forest.R
│
└── data-raw/
```

---

## Testing and Quality Assurance

The package uses [`testthat`](https://testthat.r-lib.org/) for automated unit testing.

Current test status:

```text
FAIL 0
WARN 0
SKIP 0
PASS 9
```

The package was also validated using:

```r
devtools::document()
devtools::test()
devtools::check()
```

Current `R CMD check` status:

```text
0 errors
0 warnings
```

An environment-related timestamp note may appear on some Windows systems and does not originate from the package source code.

---

## Installation

### Install from a local clone

```r
install.packages("devtools")

devtools::install()
```

### Development mode

```r
devtools::load_all()
```

---

## Main Technologies

- R
- ggplot2
- dplyr
- rlang
- stats
- roxygen2
- testthat
- devtools

---

## Clinical Data Context

The project is designed around common **ADaM-style clinical-trial structures**, including datasets related to:

```text
ADSL Subject-level analysis
ADAE Adverse events
ADLB Laboratory measurements
ADTTE Time-to-event endpoints
ADVS Vital signs
```

The current package focuses primarily on adverse-event summaries, ALT laboratory profiles, treatment comparisons, and forest plots.

---

## Reproducibility

The package follows standard R package development practices:

```r
devtools::document()
devtools::test()
devtools::check()
```

Functions are separated into reusable modules and supported by automated tests and generated documentation.

---

## Roadmap

Future developments may include:

- subgroup forest plots;
- Kaplan-Meier visualizations;
- time-to-event analysis;
- laboratory shift plots;
- adverse-event severity summaries;
- treatment-emergent adverse-event tables;
- standardized publication-ready themes;
- automated figure export;
- support for additional ADaM domains;
- clinical reporting workflows using Quarto.

---

## Author

**Chancy Mampouya Clark**

Master's student in Data Science / Artificial Intelligence  
Université Lumière Lyon 2

Interests:

- R programming
- Clinical data analysis
- Biostatistics
- Data Science
- Machine Learning
- Reproducible research
- Clinical-trial visualization

---

## License

This project is licensed under the **MIT License**.

---

## Disclaimer

ClinicalFiguresR is an educational and portfolio project.

It is not intended to replace validated production software used for regulatory submissions or clinical decision-making.
