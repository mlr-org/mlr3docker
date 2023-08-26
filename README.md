# mlr3docker

Docker Images for [mlr3](https://github.com/mlr-org/mlr3) on [Dockerhub](https://hub.docker.com/u/mlrorgdocker) for a [slim installation](https://hub.docker.com/r/mlrorgdocker/mlr3-slim) and a [full installation](https://hub.docker.com/r/mlrorgdocker/mlr3-full).

## Usage

Get the images from [Docker Hub](https://hub.docker.com/repository/docker/rhub/r-minimal):

```
docker pull mlrorgdocker/mlr3-slim:latest
docker pull mlrorgdocker/mlr3-full:latest
```

Then run the slim image with `docker run --rm -it mlr3-slim` and the full image with `docker run --rm -p 8888:8787 mlr3-full`.
The default username and password for the Rstudio server is set to `rstudio`.
To change the default password run: `docker run --rm -p 8888:8787 -e PASSWORD=password mlr3-full`
