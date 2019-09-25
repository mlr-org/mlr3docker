FROM mllg/mlr3:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN r -e 'remotes::install_cran("mlr3filters", dependencies = TRUE, upgrade = "always", Ncpus = parallel::detectCores())' \
  && rm -rf /tmp/*

CMD ["R"]
