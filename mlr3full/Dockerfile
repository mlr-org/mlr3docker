FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG catboost_version=1.2.7

# system dependencies queried with system_requirements.R on the R packages below
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake \
    default-jdk \
    libbz2-dev \
    libcurl4-openssl-dev \
    libdeflate-dev \
    libfontconfig1-dev \
    libgit2-dev \
    libglpk-dev \
    libhiredis-dev \
    libicu-dev \
    liblzma-dev \
    libpcre2-dev \
    libxml2-dev \
    xz-utils \
    zlib1g-dev \
    libudunits2-dev \
    gdal-bin libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

# additional repo is needed for mlr3proba and polars dependency of mlr3db
# installs all packages needed to run learners in mlr3learners and mlr3extralearners
# installs all packages needed to run mlr3db backends
# installs all packages needed to run optimizers in bbotk
RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE --repos https://packagemanager.posit.co/cran/latest https://community.r-multiverse.org \
    mlr3verse \
    bbotk \
    mlr3db \
    mlr3fairness \
    mlr3hyperband \
    mlr3oml \
    mlr3learners \
    mlr3extralearners \
    remotes \
    BART \
    && install2.r -r NULL -- --no-multiarch --no-test-load https://github.com/catboost/catboost/releases/download/v$catboost_version/catboost-R-Linux-$catboost_version.tgz \
    && installGithub.r PlantedML/randomPlantedForest \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

ENV PASSWORD=rstudio
