FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG catboost_version=1.2.7

# system dependencies for R packagas are installed with pak::pak()
# libcurl4-openssl-dev is required for pak
# curl is required for installing polars
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# install rust for polars
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# NOT_CRAN speeds up the installation of the polars package
# additional repositories are needed for mlr3proba and polars
# installing bbotk, mlr3learners, mlr3extralearners and mlr3db with suggests allows to use all optimizers, learners and databases
RUN Rscript -e "Sys.setenv(NOT_CRAN = 'true'); \
                install.packages('pak'); \
                pak::repo_add(mlr3universe = 'https://mlr-org.r-universe.dev', multiverse = 'https://community.r-multiverse.org'); \
                pak::pak(c('mlr3verse','bbotk', 'mlr3db', 'mlr3fairness', 'mlr3hyperband', 'mlr3oml', 'mlr3learners', 'remotes', 'BART', 'mlr3extralearners', 'PlantedML/randomPlantedForest'), dependencies = TRUE, ask = FALSE);"

ENV PASSWORD=rstudio
