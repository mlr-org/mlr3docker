FROM rocker/r-base:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN ln -s /usr/lib/R/site-library/littler/examples/update.r /usr/local/bin/update.r \
  && ln -s /usr/lib/R/site-library/littler/examples/rcc.r /usr/local/bin/rcc.r \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    pandoc \
    r-cran-remotes \
    r-cran-testthat \
    r-cran-rcmdcheck \
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/*

RUN update.r \
  && install2.r -n -1 --error --deps=TRUE mlr3 \
  && rm -rf /tmp/*

CMD ["R"]
