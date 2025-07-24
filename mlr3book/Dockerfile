FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG GH_PAT
ARG TARGETARCH

# system dependencies queried with system_requirements.R on the R packages below
# texlive and lmodern for the book
# npm for quarto
# libharfbuzz-dev and libfribidi-dev for the textshaping on arm64
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake \
    gdal-bin \
    git \
    gsfonts \
    libabsl-dev \
    libcurl4-openssl-dev \
    libgdal-dev \
    libgeos-dev \
    libglpk-dev \
    libgmp3-dev \
    libhiredis-dev \
    libicu-dev \
    libjpeg-dev \
    libmagick++-dev \
    libmpfr-dev \
    libpng-dev \
    libproj-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    libx11-dev \
    libxml2-dev \
    make \
    pandoc \
    xz-utils \
    zlib1g-dev \
    texlive \
    texlive-xetex \
    texlive-fonts-extra \
    lmodern \
    npm \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# install quarto
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-${TARGETARCH}.deb && \
    apt-get install -y ./quarto-1.7.32-linux-${TARGETARCH}.deb

# install mlr3verse with suggested packages
# additional repo is needed for mlr3proba
RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --repos --deps TRUE https://packagemanager.posit.co/cran/latest https://mlr-org.r-universe.dev https://community.r-multiverse.org \
    mlr3verse \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

# install additional packages
# might be a dependency of the book or a needed suggested package
RUN install2.r --error --skipinstalled --ncpus ${NCPUS} --repos https://packagemanager.posit.co/cran/latest https://mlr-org.r-universe.dev https://community.r-multiverse.org \
    bestNormalize \
    counterfactuals \
    CVXR \
    DALEX \
    DALEXtra \
    dbplyr \
    dbscan \
    DiceKriging \
    downlit \
    duckdb \
    fairml \
    FSelectorRcpp \
    gbm \
    GenSA \
    GGally \
    ggdendro \
    ggExtra \
    ggfortify \
    ggtext \
    igraph \
    iml \
    kknn \
    knitr \
    lhs \
    lightgbm \
    linprog \
    magick \
    maps \
    nloptr \
    nycflights13 \
    partykit \
    pendensity \
    PMCMRplus \
    precrec \
    qgam \
    qs \
    quadprog \
    randomForestSRC \
    ranger \
    remotes \
    rgenoud \
    rmarkdown \
    RSQLite \
    survivalsvm \
    xgboost \
    xml2 \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

RUN Rscript -e "torch::install_torch()"

# install mlr3book
# without dependencies to avoid overwriting the already installed mlr3verse
RUN GITHUB_PAT=${GH_PAT} installGithub.r --deps FALSE \
    mlr-org/mlr3book \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

RUN git clone https://github.com/mlr-org/mlr3book.git

ENV PASSWORD=rstudio
