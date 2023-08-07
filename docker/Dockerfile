FROM debian:stretch
LABEL maintainer="Gainprox Developers <dev@gainprox.com>"
LABEL description="Dockerised GainproxCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
