FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG catboost_version=1.2.7

# system dependencies queried with pak::pkg_system_deps() on the R packages below
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake \
    curl \
    default-jdk \
    gdal-bin \
    git \
    libabsl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgdal-dev \
    libgeos-dev \
    libgit2-dev \
    libglpk-dev \
    libgmp3-dev \
    libharfbuzz-dev \
    libhiredis-dev \
    libicu-dev \
    libmpfr-dev \
    libpng-dev \
    libproj-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libssl-dev \
    libudunits2-dev \
    libx11-dev \
    libxml2-dev \
    make \
    pandoc \
    python3 \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source $HOME/.cargo/env

RUN Rscript -e "install.packages('pak'); \
                pak::repo_add(mlr3universe = 'https://mlr-org.r-universe.dev', multiverse = 'https://community.r-multiverse.org'); \
                pak::pak(c('mlr3verse','bbotk', 'mlr3db', 'mlr3fairness', 'mlr3hyperband', 'mlr3oml', 'mlr3learners', 'remotes', 'BART', 'mlr3extralearners', 'PlantedML/randomPlantedForest'), dependencies = TRUE, ask = FALSE);"


# RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE --repos https://packagemanager.posit.co/cran/latest https://community.r-multiverse.org \
#     duckdb \
#     # bbotk \
#     # mlr3db \
#     # mlr3fairness \
#     # mlr3hyperband \
#     # mlr3oml \
#     # mlr3learners \
#     # remotes \
#     # BART \
#     # && install2.r -r NULL -- --no-multiarch --no-test-load https://github.com/catboost/catboost/releases/download/v$catboost_version/catboost-R-Linux-$catboost_version.tgz \
#     # && installGithub.r mlr-org/mlr3proba PlantedML/randomPlantedForest \
#     # && install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE mlr3verse \
#     # && installGithub.r --deps TRUE mlr-org/mlr3extralearners \
#     && rm -rf /tmp/downloaded_packages \
#     && strip /usr/local/lib/R/site-library/*/libs/*.so

ENV PASSWORD=rstudio
