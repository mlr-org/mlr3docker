FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG GH_PAT
ARG TARGETARCH

# system dependencies queried with pak::pkg_system_deps() on the R packages below
# texlive and fonts-lmodern for the book
# npm for quarto
# xz-utils for duckdb on arm64
# libharfbuzz-dev and libfribidi-dev for the textshaping on arm64
# rsync for deployment
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libicu-dev \
    make \
    libglpk-dev \
    libxml2-dev \
    git \
    pandoc \
    libssl-dev \
    zlib1g-dev \
    libgmp3-dev \
    libmpfr-dev \
    cmake \
    libcurl4-openssl-dev \
    libjpeg-dev \
    libpng-dev \
    libx11-dev \
    libmagick++-dev \
    gsfonts \
    libudunits2-dev \
    libproj-dev \
    libgdal-dev \
    texlive \
    texlive-xetex \
    texlive-fonts-extra \
    lmodern \
    xz-utils \
    npm \
    libharfbuzz-dev \
    libfribidi-dev \
    libmpfr-dev \
    rsync \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-${TARGETARCH}.deb && \
    apt-get install -y ./quarto-1.7.32-linux-${TARGETARCH}.deb

RUN install2.r --error --skipinstalled --ncpus ${NCPUS} \
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
    qgam \
    downlit \
    xml2 \
    ranger \
    igraph \
    kknn \
    magick \
    xgboost \
    DiceKriging \
    rgenoud \
    FSelectorRcpp \
    qs \
    dbplyr \
    duckdb \
    partykit \
    quadprog \
    maps \
    && GITHUB_PAT=${GH_PAT} installGithub.r mlr-org/mlr3proba \
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
