FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG catboost_version=1.2.7

# system dependencies queried with pak::pkg_system_deps() on the R packages below
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
#     cmake \
#     curl \
#     default-jdk \
#     gdal-bin \
#     git \
#     libabsl-dev \
      libcurl4-openssl-dev \
#     libfontconfig1-dev \
#     libfreetype6-dev \
#     libfribidi-dev \
#     libgdal-dev \
#     libgeos-dev \
#     libgit2-dev \
#     libglpk-dev \
#     libgmp3-dev \
#     libharfbuzz-dev \
#     libhiredis-dev \
#     libicu-dev \
#     libmpfr-dev \
#     libpng-dev \
#     libproj-dev \
#     libsqlite3-dev \
#     libssh2-1-dev \
#     libssl-dev \
#     libudunits2-dev \
#     libx11-dev \
#     libxml2-dev \
#     make \
#     pandoc \
#     python3 \
#     xz-utils \
#     zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# install rush for polars
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN Rscript -e "install.packages('pak'); \
                pak::repo_add(mlr3universe = 'https://mlr-org.r-universe.dev', multiverse = 'https://community.r-multiverse.org'); \
                pak::pak(c('mlr3verse','bbotk', 'mlr3db', 'mlr3fairness', 'mlr3hyperband', 'mlr3oml', 'mlr3learners', 'remotes', 'BART', 'mlr3extralearners', 'PlantedML/randomPlantedForest'), dependencies = TRUE, ask = FALSE);"

ENV PASSWORD=rstudio
