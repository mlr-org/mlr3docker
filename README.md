# mlr3docker

<!-- badges: start -->
[![license](https://img.shields.io/badge/license-GPLv3-blue.svg)](https://opensource.org/licenses/GPL-3.0)
<!-- badges: end -->

## Overview

This repository provides Docker images for the [mlr3](https://github.com/mlr-org/mlr3) project.
Available on Docker Hub, we offer two distinct configurations: a [slim installation](https://hub.docker.com/r/mlrorg/mlr3-slim) for a lightweight setup, and a [full installation](https://hub.docker.com/r/mlrorg/mlr3-full) that includes all extensions and dependencies for comprehensive use.
We also offer a container to build the mlr3 book.

## Usage

Get the images from [Docker Hub](https://hub.docker.com/u/mlrorg), e.g.:

```sh
docker pull mlrorg/mlr3-slim:latest
```

## Images

The images build on `rocker/rstudio:latest`, except for `mlr3slim`, which builds on `rocker/r-ver:latest`.
See [rocker-versioned2](https://github.com/rocker-org/rocker-versioned2) repo for details.

| image                                                        | description                                           | metrics                                                                                                                |
| ------------------------------------------------------------ | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| [mlr3-book](https://hub.docker.com/r/mlrorg/mlr3-book) | Container to build mlr3 book                          | [![](https://img.shields.io/docker/pulls/mlrorg/mlr3-book.svg)](https://hub.docker.com/r/mlrorg/mlr3-book) |
| [mlr3-slim](https://hub.docker.com/r/mlrorg/mlr3-slim) | Adds mlr3verse                                        | [![](https://img.shields.io/docker/pulls/mlrorg/mlr3-slim.svg)](https://hub.docker.com/r/mlrorg/mlr3-slim) |
| [mlr3-full](https://hub.docker.com/r/mlrorg/mlr3-full) | Adds mlr3verse & mlr3extralearners incl. dependencies | [![](https://img.shields.io/docker/pulls/mlrorg/mlr3-full.svg)](https://hub.docker.com/r/mlrorg/mlr3-slim) |
