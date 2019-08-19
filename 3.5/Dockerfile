FROM library/ubuntu:xenial AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        python-software-properties \
        software-properties-common \
        apt-utils

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN apt-get download \
        liblzma5 \
        libmpdec2 \
        libexpat1 \
        libffi6 \
        libsqlite3-0 \
        python3 \
        python3.5 \
        python3-minimal \
        python3.5-minimal \
        libpython3.5-minimal \
        libpython3-stdlib \
        libpython3.5-stdlib
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN rm -rf \
        etc \
        usr/lib/valgrind \
        usr/share/doc \
        usr/share/man \
        usr/share/applications \
        usr/share/apps \
        usr/share/binfmts \
        usr/share/debhelper \
        usr/share/lintian \
        usr/share/perl5 \
        usr/share/pixmaps \
        usr/bin/python3.5m \
 && ln -s python3.5 usr/bin/python3.5m \
 && ln -s python3.5 usr/bin/python

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
