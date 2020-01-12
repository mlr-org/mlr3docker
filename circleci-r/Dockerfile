FROM rocker/r-base:latest
MAINTAINER "Michel Lang" michellang@gmail.com

ENV NOT_CRAN=true \
    _R_CHECK_CRAN_INCOMING_REMOTE_=false \
    _R_CHECK_LENGTH_1_CONDITION_=true \
    _R_CHECK_LENGTH_1_LOGIC2_=true \
    _R_CHECK_TESTS_NLINES_=0 \
    PATH="/usr/lib/R/site-library/littler/examples:${PATH}"

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    pandoc \
    pandoc-citeproc \
    ghostscript \
    lmodern \
    texinfo \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-plain-generic \
    texlive-science \
    texlive-xetex \
    qpdf \
    && r -e 'update.packages(ask = FALSE, Ncpus = parallel::detectCores())' \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
