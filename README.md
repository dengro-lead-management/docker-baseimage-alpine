# DenGro Docker Base Image

This is the repo for the base Docker image used in application deployments. It is based on the official alpine image and inspired by `linuxserver/docker-baseimage-alpine`.

# Running

Note that this image does not contain any application code. Run the following command to run and `exec` an interactive bash shell:

	docker exec -it dengroltd/baseimage-alpine:latest /bin/bash

# Building and publishing

Build the image by run the following command:

	docker build --tag dengroltd/baseimage-alpine:latest .
	docker push dengroltd/baseimage-alpine:latest

Note that `--tag` is rquired in order to publish the image.