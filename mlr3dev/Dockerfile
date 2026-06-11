FROM ghcr.io/finbarr/yolobox:latest

USER root

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

# Install R from CRAN apt repo for Ubuntu noble (24.04).
# yolobox already provides curl, wget, gnupg, ca-certificates, build-essential.
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
        | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
    && echo "deb https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/" \
        > /etc/apt/sources.list.d/cran.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends r-base r-base-dev \
    && rm -rf /var/lib/apt/lists/*

# Use Posit Package Manager (PPM) for fast Linux binaries, matching rocker/mlr3full.
RUN printf '%s\n' \
    'options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest"))' \
    'options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))' \
    >> /usr/lib/R/etc/Rprofile.site

# R system deps for the mlr3 package set (libssl/libcurl already in yolobox).
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libxml2-dev \
    libgit2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    libxt-dev \
    redis-tools \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

# Quarto for rendering .qmd documents (same version as mlr3book).
RUN ARCH="$(dpkg --print-architecture)" \
    && wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v1.7.32/quarto-1.7.32-linux-${ARCH}.deb" \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends "./quarto-1.7.32-linux-${ARCH}.deb" \
    && rm -f "quarto-1.7.32-linux-${ARCH}.deb" \
    && rm -rf /var/lib/apt/lists/*

# Rust for polars (same as mlr3full).
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Mirror the mlr3full R-package install (catboost arch URL, multiverse repos, torch on x86_64).
# NOT_CRAN speeds up the installation of the polars package.
# CRAN is added as a fallback because PPM can lag behind CRAN after new package releases.
RUN Rscript - <<'EOF'
Sys.setenv(NOT_CRAN = "true")
install.packages('pak', repos = sprintf('https://r-lib.github.io/p/pak/stable/%s/%s/%s', .Platform$pkgType, R.Version()$os, R.Version()$arch))
cb_version = "1.2.10"
catboost_url = paste0("url::https://github.com/catboost/catboost/releases/download/v", cb_version, "/catboost-R-linux-", Sys.info()[["machine"]], "-", cb_version, ".tgz")
pak::repo_add(
    CRAN2 = "https://cloud.r-project.org",
    mlr3universe = "https://mlr-org.r-universe.dev",
    multiverse = "https://community.r-multiverse.org")
pak::pak(c(
    catboost_url,
    "mlr3cmprsk",
    "mlr3verse",
    "bbotk",
    "mlr3db",
    "mlr3fairness",
    "mlr3filters",
    "mlr3hyperband",
    "mlr3oml",
    "mlr3learners",
    "BART",
    "PlantedML/randomPlantedForest",
    "mlr3extralearners"), dependencies = TRUE, ask = FALSE)
if (Sys.info()[["machine"]] == "x86_64") torch::install_torch()
EOF

# Install R dev packages.
# GitHub install is done via remotes instead of pak because pak's bundled R6 lazy-load DB is corrupt in this base image and fails when building source packages.
RUN Rscript -e 'pak::pak(c("devtools", "usethis", "lintr", "styler", "rcmdcheck", "covr", "pkgdown", "languageserver"), ask = FALSE)' \
    && Rscript -e 'remotes::install_github("mlr-org/mlr3pkgdowntemplate", upgrade = "never")'

# Install air (R formatter from Posit).
RUN curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh \
    && cp -L /root/.local/bin/air /usr/local/bin/air \
    && chmod +x /usr/local/bin/air

# Use HTTPS + gh credential helper for GitHub so $GH_TOKEN works for ssh-style remotes
RUN printf '%s\n' \
    '[url "https://github.com/"]' \
    '    insteadOf = git@github.com:' \
    '    insteadOf = ssh://git@github.com/' \
    '[credential "https://github.com"]' \
    '    helper = ' \
    '    helper = !gh auth git-credential' \
    '[credential "https://gist.github.com"]' \
    '    helper = ' \
    '    helper = !gh auth git-credential' \
    > /etc/gitconfig

USER yolo
