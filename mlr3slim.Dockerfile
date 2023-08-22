FROM rocker/r-ver:latest

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
    org.opencontainers.image.source="https://github.com/mlr-org/mlr3docker" \
    org.opencontainers.image.vendor="mlr-org"

ARG NCPUS=${NCPUS:--1}

RUN install2.r --error --skipinstalled -n ${NCPUS} mlr3verse
