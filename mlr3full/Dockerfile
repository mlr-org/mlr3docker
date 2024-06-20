FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=${NCPUS:--1}
ARG catboost_version=1.2.5

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake \
    default-jdk \
    libbz2-dev \
    libdeflate-dev \
    libfontconfig1-dev \
    libglpk-dev \
    libicu-dev \
    liblzma-dev \
    libpcre2-dev \
    libxml2-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE \
    bbotk \
    mlr3db \
    mlr3fairness \
    mlr3hyperband \
    mlr3oml \
    mlr3verse \
    mlr3learners \
    remotes \
    BART \
    && install2.r -r NULL -- --no-multiarch --no-test-load https://github.com/catboost/catboost/releases/download/v$catboost_version/catboost-R-Linux-$catboost_version.tgz \
    && installGithub.r mlr-org/mlr3proba PlantedML/randomPlantedForest \
    && installGithub.r --deps TRUE mlr-org/mlr3extralearners \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

ENV PASSWORD=rstudio
