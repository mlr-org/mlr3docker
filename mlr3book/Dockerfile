FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=-1
ARG GH_PAT
ARG TARGETARCH

# system dependencies for R packagas are installed with pak::pak()
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

RUN Rscript -e "install.packages('pak'); \
                pak::repo_add(mlr3universe = 'https://mlr-org.r-universe.dev', multiverse = 'https://community.r-multiverse.org'); \
                pak::pak(c('mlr3verse'), dependencies = TRUE, ask = FALSE); \
                pak::pak(c('remotes', 'knitr', 'rmarkdown', 'GGally', 'ggExtra', 'precrec', 'CVXR', 'lhs', 'nloptr', 'bestNormalize', 'RSQLite', 'nycflights13', 'PMCMRplus', 'gbm', 'iml', 'DALEX', 'DALEXtra', 'counterfactuals', 'GenSA', 'mlr3oml', 'mlr3learners', 'mlr3torch', 'mlr3inferr', 'survivalsvm', 'pendensity', 'ggdendro', 'ggfortify', 'dbscan', 'ggtext', 'linprog', 'fairml', 'randomForestSRC', 'lightgbm', 'qgam', 'downlit', 'xml2', 'ranger', 'igraph', 'kknn', 'magick', 'xgboost', 'DiceKriging', 'rgenoud', 'FSelectorRcpp', 'qs', 'dbplyr', 'duckdb', 'partykit', 'quadprog', 'maps'), dependencies = TRUE, ask = FALSE); \
                torch::install_torch(); \
                pak::pak('mlr-org/mlr3book', dependencies = FALSE, ask = FALSE);"

RUN git clone https://github.com/mlr-org/mlr3book.git

ENV PASSWORD=rstudio
