FROM mllg/circleci-r:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN apt-get update -qq && apt-get install -y --no-install-recommends --no-upgrade \
    r-cran-devtools \
    r-cran-ggplot2 \
    r-cran-knitr \
    r-cran-rmarkdown \
    r-cran-checkmate \
    r-cran-data.table \
    r-cran-future \
    r-cran-future.apply \
    r-cran-bibtex \
    r-cran-mlbench \
    && update.r --ncpus=-1 \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

USER docker

RUN echo "R_LIBS_USER=/home/docker/r-library" > /home/docker/.Renviron \
  && mkdir -p /home/docker/r-library \
  && install2.r --deps=TRUE --ncpus=-1 -l /home/docker/r-library mlr3 mlr3verse \
  && update.r --ncpus=-1 -l /home/docker/r-library \
  && rm -rf /tmp/*
