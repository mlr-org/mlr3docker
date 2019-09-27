FROM rocker/r-base:latest
MAINTAINER "Michel Lang" michellang@gmail.com

ENV NOT_CRAN=true
ENV _R_CHECK_CRAN_INCOMING_REMOTE_=false
ENV _R_CHECK_LENGTH_1_CONDITION_=true
ENV _R_CHECK_LENGTH_1_LOGIC2_=true
ENV _R_CHECK_TESTS_NLINES_=0
ENV PATH="/usr/lib/R/site-library/littler/examples:${PATH}" 

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    pandoc \
    r-cran-remotes \
    r-cran-testthat \
    r-cran-rcmdcheck \
  && r -e 'update.packages(ask = FALSE, Ncpus = parallel::detectCores())' \
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/*
