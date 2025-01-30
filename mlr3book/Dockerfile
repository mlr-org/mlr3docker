FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=${NCPUS:--1}
ARG GH_PAT
ARG TARGETARCH

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake \
    libmagick++-dev \
    default-jdk \
    libbz2-dev \
    libdeflate-dev \
    libfontconfig1-dev \
    libglpk-dev \
    libicu-dev \
    liblzma-dev \
    libpcre2-dev \
    libxml2-dev \
    libudunits2-dev \
    libproj-dev \
    libgdal-dev \
    zlib1g-dev \
    rustc \
    cargo \
    texlive \
    texlive-xetex \
    texlive-fonts-extra \
    lmodern \
    rsync \
    nodejs \
    npm \
    libgit2-dev \
    libharfbuzz-dev libfribidi-dev \
    xz-utils \
    libmpfr-dev \
    libhiredis-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-${TARGETARCH}.deb && \
    apt-get install -y ./quarto-1.6.39-linux-${TARGETARCH}.deb

RUN install2.r --error --skipinstalled --ncpus ${NCPUS} \
    dbplyr \
    FSelectorRcpp \
    igraph

RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE \
    remotes \
    knitr \
    rmarkdown \
    GGally \
    ggExtra \
    precrec \
    CVXR \
    lhs \
    nloptr \
    bestNormalize \
    RSQLite \
    nycflights13 \
    PMCMRplus \
    gbm \
    iml \
    DALEX \
    DALEXtra \
    counterfactuals \
    GenSA \
    mlr3oml \
    mlr3learners \
    mlr3torch \
    mlr3inferr \
    survivalsvm \
    pendensity \
    ggdendro \
    ggfortify \
    dbscan \
    ggtext \
    linprog \
    fairml \
    randomForestSRC \
    lightgbm \
    && installGithub.r mlr-org/mlr3proba \
    && install2.r --error --skipinstalled --ncpus ${NCPUS} --deps TRUE mlr3verse \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

RUN Rscript -e "torch::install_torch()"

RUN GITHUB_PAT=${GH_PAT} installGithub.r \
    mlr-org/mlr3book \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

RUN git clone https://github.com/mlr-org/mlr3book.git


ENV PASSWORD=rstudio
