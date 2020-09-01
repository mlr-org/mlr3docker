FROM rocker/r-ubuntu:20.04
MAINTAINER "Michel Lang" michellang@gmail.com

COPY r-cmd-check /usr/local/bin

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
        texlive-base \
        texlive-fonts-extra \
        texlive-fonts-recommended \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-plain-generic \
        texlive-science \
        texlive-xetex \
        qpdf \
        git \
        libicu-dev \
        default-jdk \
        libssl-dev \
        libcurl4-openssl-dev \
        r-cran-devtools \
        r-cran-rmarkdown \
    && R CMD javareconf \
    && update.r --ncpus=-1 \
    && rm -rf /tmp/* /var/lib/apt/lists/*
