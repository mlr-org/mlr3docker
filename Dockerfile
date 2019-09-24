FROM rocker/r-ver:3.6.1
MAINTAINER "Michel Lang" michellang@gmail.com

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    git \
    libicu-dev \
    default-jdk-headless \
    default-jre-headless \
  && R CMD javareconf

RUN install2.r -n 6 --error \
    remotes \
    rJava

RUN install2.r -n 6 --error --deps=TRUE \
    mlr3 \
    mlr3learners \
    mlr3db \
    mlr3filters
