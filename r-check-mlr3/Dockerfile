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
    && install2.r --deps=TRUE --ncpus=-1 mlr3 mlr3verse \
    && rm -rf /tmp/* /var/lib/apt/lists/*

# install all new packages into /r-lib;
# these should be cached by the CI
RUN mkdir -p /r-lib
ENV R_LIBS="/r-lib"
