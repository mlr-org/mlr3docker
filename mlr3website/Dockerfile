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
    rsync \
    && rm -rf /var/lib/apt/lists/*

# mlr3calibration is not on CRAN/r-universe, so it is installed from GitHub
# mlr3website is installed without dependencies to not overwrite packages installed from r-universe
# mlr3fairness, mlr3spatiotempcv, mlr3filters and mlr3pipelines fail to create a proper dictionary currently (23.04.2026)
RUN Rscript - <<'EOF'
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/rc/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
# CRAN is added as a fallback because rocker uses PPM by default,
# which can lag behind CRAN after new package releases
pak::repo_add(
    CRAN2 = "https://cloud.r-project.org",
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org")
pak::pak("mlr3verse", dependencies = TRUE, ask = FALSE)
pak::pak(c(
    "mlr-org/mlr3website",
    "mlr-org/mlr3fairness",
    # force latest version
    "mlr3filters@0.9.1",
    "mlr-org/mlr3spatiotempcv",
    "mlr-org/mlr3pipelines@fix_flt_ensemble_dict",
    "giuseppec/mlr3calibration",
    "adagio",
    "anytime",
    "apcluster",
    "BART",
    "base64enc",
    "bestNormalize",
    "betacal",
    "bst",
    "clue",
    "cowplot",
    "DataExplorer",
    "DiceKriging",
    "discrim",
    "distr6",
    "dplyr",
    "DT",
    "e1071",
    "farff",
    "fastICA",
    "fastVoteR",
    "FSelectorRcpp",
    "GenSA",
    "GGally",
    "ggdendro",
    "ggfortify",
    "ggmap",
    "ggparty",
    "ggpubr",
    "glmnet",
    "gridExtra",
    "gt",
    "here",
    "klaR",
    "kknn",
    "microbenchmark",
    "mlbench",
    "mlr3benchmark",
    "mlr3cmprsk",
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
    "PMCMRplus",
    "praznik",
    "precrec",
    "probably",
    "rchallenge",
    "reactable",
    "rgl",
    "rpart.plot",
    "RSQLite",
    "sf",
    "sessioninfo",
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
