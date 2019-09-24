FROM mllg/mlr3:latest
MAINTAINER "Michel Lang" michellang@gmail.com

RUN install2.r --error --deps=TRUE mlr3db \
  && rm -rf /tmp/*

CMD ["R"]
