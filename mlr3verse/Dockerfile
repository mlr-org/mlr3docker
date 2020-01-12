FROM mllg/circleci-r:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    r-cran-devtools \
    r-cran-formatr \
    r-cran-ggplot2 \
    r-cran-knitr \
    r-cran-rmarkdown \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r --deps=TRUE --ncpus=-1 mlr3verse \
  && rm -rf /tmp/*
