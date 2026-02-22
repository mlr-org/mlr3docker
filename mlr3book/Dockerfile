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
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-${TARGETARCH}.deb && \
    apt-get install -y ./quarto-1.7.32-linux-${TARGETARCH}.deb

# mlr3verse is installed with suggests
# additional dependencies for the book are installed
# mlr3book is installed without dependencies to not overwrite the mlr3verse packages
RUN Rscript - <<'EOF'
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/stable/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
pak::repo_add(
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org",
    raphaels1 = "https://raphaels1.r-universe.dev")
pak::pak("mlr3verse", dependencies = TRUE, ask = FALSE)
pak::pak(c(
    "mlr-org/mlr3cmprsk",
    "mlr-org/survdistr",
    "bestNormalize",
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
    "mlr3extralearners",
    "nloptr",
    "nycflights13",
    "partykit",
    "pendensity",
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
pak::pak("mlr-org/mlr3book", dependencies = FALSE, ask = FALSE)
EOF

RUN git clone https://github.com/mlr-org/mlr3book.git

ENV PASSWORD=rstudio
