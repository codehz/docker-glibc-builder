FROM 32bit/ubuntu:16.04
MAINTAINER Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>
MAINTAINER CodeHz <github+codehz@outlook.com>
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.24
RUN apt-get -q update \
	&& apt-get -qy install build-essential wget openssl gawk
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
