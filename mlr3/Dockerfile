FROM rocker/r-base:latest
MAINTAINER "Michel Lang" michellang@gmail.com
COPY r-cmd-check /usr/local/bin

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    pandoc \
    r-cran-remotes \
    r-cran-testthat \
    r-cran-rcmdcheck \
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/*

RUN r -e 'remotes::install_cran("mlr3", dependencies = TRUE, upgrade = "always", force = TRUE, Ncpus = parallel::detectCores())' \
  && rm -rf /tmp/*

CMD ["R"]
