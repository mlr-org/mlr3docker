FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

# system dependencies for R packages are installed with pak::pak()
# libcurl4-openssl-dev is required for pak
# libharfbuzz-dev and libfribidi-dev are required for textshaping/ragg (tidyverse dependency)
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*

# mlr3calibration is not on CRAN/r-universe, so it is installed from GitHub
RUN Rscript - <<'EOF'
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/rc/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
pak::repo_add(
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org",
    raphaels1 = "https://raphaels1.r-universe.dev")
pak::pak("mlr3verse", dependencies = TRUE, ask = FALSE)
pak::pak(c(
    "mlr-org/mlr3website",
    "mlr-org/mlr3cmprsk",
    "mlr-org/survdistr",
    "adagio",
    "anytime",
    "apcluster",
    "BART",
    "base64enc",
    "betacal",
    "bst",
    "cowplot",
    "DataExplorer",
    "discrim",
    "distr6",
    "dplyr",
    "DT",
    "e1071",
    "farff",
    "fastICA",
    "fastVoteR",
    "giuseppec/mlr3calibration",
    "ggmap",
    "ggparty",
    "ggpubr",
    "glmnet",
    "gridExtra",
    "gt",
    "klaR",
    "microbenchmark",
    "mlbench",
    "mlr3extralearners",
    "mlr3inferr",
    "mlr3proba",
    "mlr3spatial",
    "mlr3torch",
    "modeldata",
    "mvtnorm",
    "naniar",
    "ooplah",
    "OpenML",
    "patchwork",
    "plumber",
    "praznik",
    "probably",
    "rchallenge",
    "reactable",
    "rgl",
    "rpart.plot",
    "sf",
    "skimr",
    "smotefamily",
    "terra",
    "tidymodels",
    "tidyr",
    "tidyterra",
    "tidyverse",
    "torchvision",
    "viridisLite"), ask = FALSE)
torch::install_torch()
EOF

ENV PASSWORD=rstudio
