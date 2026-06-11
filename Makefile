.PHONY: pull-mlr3book pull-mlr3full pull-mlr3slim pull-mlr3website \
        bash-mlr3book bash-mlr3full bash-mlr3slim bash-mlr3website \
        build-mlr3bookdev build-mlr3websitedev build-mlr3dev \
        start-mlr3bookdev start-mlr3websitedev

pull-mlr3book:
	docker pull mlrorg/mlr3-book:latest

pull-mlr3full:
	docker pull mlrorg/mlr3-full:latest

pull-mlr3slim:
	docker pull mlrorg/mlr3-slim:latest

pull-mlr3website:
	docker pull mlrorg/mlr3-website:latest

bash-mlr3book:
	docker run --rm -it mlrorg/mlr3-book:latest bash

bash-mlr3full:
	docker run --rm -it mlrorg/mlr3-full:latest bash

bash-mlr3slim:
	docker run --rm -it mlrorg/mlr3-slim:latest bash

bash-mlr3website:
	docker run --rm -it mlrorg/mlr3-website:latest bash

build-mlr3bookdev: pull-mlr3book
	docker build -t mlrorg/mlr3-bookdev:latest mlr3bookdev

build-mlr3websitedev: pull-mlr3website
	docker build -t mlrorg/mlr3-websitedev:latest mlr3websitedev

build-mlr3dev:
	docker build -t mlrorg/mlr3-dev:latest mlr3dev

start-mlr3bookdev:
	(cd mlr3bookdev && docker compose up -d)

start-mlr3websitedev:
	(cd mlr3websitedev && docker compose up -d)

