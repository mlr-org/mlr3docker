FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG GH_PAT
ARG TARGETARCH

# system dependencies for R packages are installed with pak::pak()
# libcurl4-openssl-dev is required for pak
# additional dependencies:
# texlive and fonts-lmodern for the book
# npm for quarto
# rsync for deployment
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    # additional dependencies
    texlive \
    texlive-xetex \
    texlive-fonts-extra \
    lmodern \
    npm \
    rsync \
    # cargo is required for building clarabel (dependency of CVXR)
    cargo \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-${TARGETARCH}.deb && \
    apt-get install -y ./quarto-1.7.32-linux-${TARGETARCH}.deb

# mlr3verse is installed with suggests
# additional dependencies for the book are installed
# mlr3fairness and mlr3spatiotempcv fail to create a proper dictionary currently (23.04.2026)
RUN Rscript - <<'EOF'
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/stable/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
# CRAN is added as a fallback because rocker uses PPM by default,
# which can lag behind CRAN after new package releases
pak::repo_add(
    CRAN = "https://cloud.r-project.org",
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org")
pak::pak("mlr3verse", dependencies = TRUE, ask = FALSE)
pak::pak(c(
    "mlr-org/mlr3book",
    "mlr-org/mlr3fairness",
    "mlr-org/mlr3spatiotempcv",
    "bestNormalize",
    "clue",
    "counterfactuals",
    "CVXR",
    "DALEX",
    "DALEXtra",
    "dbplyr",
    "dbscan",
    "DiceKriging",
    "downlit",
    "duckdb",
    "fairml",
    "FSelectorRcpp",
    "gbm",
    "GenSA",
    "GGally",
    "ggdendro",
    "ggExtra",
    "ggfortify",
    "ggtext",
    "here",
    "igraph",
    "iml",
    "kknn",
    "knitr",
    "lhs",
    "lightgbm",
    "linprog",
    "magick",
    "maps",
    "mlr3cmprsk",
    "mlr3extralearners",
    "nloptr",
    "nycflights13",
    "partykit",
    "PMCMRplus",
    "precrec",
    "qgam",
    "qs2",
    "quadprog",
    "randomForestSRC",
    "ranger",
    "remotes",
    "rgenoud",
    "rmarkdown",
    "rprojroot",
    "RSQLite",
    "sessioninfo",
    "survivalsvm",
    "xgboost",
    "xml2"), dependencies = NA, ask = FALSE)
torch::install_torch()
EOF

RUN git clone https://github.com/mlr-org/mlr3book.git

ENV PASSWORD=rstudio
