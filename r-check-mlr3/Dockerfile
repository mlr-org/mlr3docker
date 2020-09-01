FROM mlrorg/r-check:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends --no-upgrade \
        r-cran-ggplot2 \
        r-cran-ggally \
        r-cran-bibtex \
        r-cran-dicekriging \
        r-cran-e1071 \
        r-cran-glmnet \
        r-cran-ranger \
        r-cran-kknn \
        r-cran-nnet \
        r-cran-xgboost \
    && apt-get install -y --install-recommends \
        r-cran-mlr3 \
    && update.r --ncpus=-1 \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*

USER docker

RUN echo "R_LIBS_USER=/home/docker/r-library" > /home/docker/.Renviron \
  && mkdir -p /home/docker/r-library \
  && install2.r --deps=TRUE --ncpus=-1 mlr3 mlr3verse \
  && update.r --ncpus=-1 \
  && rm -rf /tmp/*
