FROM rocker/r-ver:3.6.1
MAINTAINER "Michel Lang" michellang@gmail.com

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    git \
    libicu-dev \
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/*

RUN install2.r --error remotes 
RUN install2.r --error --deps=TRUE mlr3

CMD ["R"]
