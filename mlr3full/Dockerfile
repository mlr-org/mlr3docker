FROM rocker/rstudio:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=${NCPUS:--1}

RUN install2.r --error --skipinstalled --ncpus ${NCPUS} \
    bbotk \
    mlr3db \
    mlr3fairness \
    mlr3hyperband \
    mlr3oml \
    mlr3verse \
    remotes \
    && installGithub.r \
    mlr-org/mlr3extralearners \
    mlr-org/mlr3proba \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
