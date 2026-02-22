FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

# system dependencies for R packages are installed with pak::pak()
# libcurl4-openssl-dev is required for pak
# curl is required for installing polars
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# install rust for polars
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# install pak
RUN Rscript - <<'EOF'

EOF

# NOT_CRAN speeds up the installation of the polars package
# additional repositories are needed for mlr3proba and polars
# installing bbotk, mlr3learners, mlr3extralearners and mlr3db with suggests allows to use all optimizers, learners and databases
# catboost is installed via architecture-specific binary URL
# mlr3cmprsk and survdistr are not on r-universe so they are installed from their respective GitHub repositories
RUN Rscript - <<'EOF'
Sys.setenv(NOT_CRAN = "true")
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/stable/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
cb_version = "1.2.10"
catboost_url = paste0("url::https://github.com/catboost/catboost/releases/download/v", cb_version, "/catboost-R-linux-", Sys.info()[["machine"]], "-", cb_version, ".tgz")
pak::repo_add(
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org",
    raphaels1 = "https://raphaels1.r-universe.dev")
pak::pak(c(
    catboost_url,
    "mlr-org/mlr3cmprsk",
    "mlr-org/survdistr",
    "mlr3verse",
    "bbotk",
    "mlr3db",
    "mlr3fairness",
    "mlr3hyperband",
    "mlr3oml",
    "mlr3learners",
    "BART",
    "PlantedML/randomPlantedForest",
    "mlr3extralearners"), dependencies = TRUE, ask = FALSE)
EOF

ENV PASSWORD=rstudio
