FROM library/ubuntu:bionic AS build

ENV LANG=C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN mkdir -p /build /rootfs
WORKDIR /build
RUN apt-get download \
        libexpat1 \
        libffi6 \
        libsqlite3-0 \
        python \
        python2.7 \
        python-minimal \
        python2.7-minimal \
        libpython2.7-minimal \
        libpython-stdlib \
        libpython2.7-stdlib
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs

WORKDIR /rootfs
RUN rm -rf \
        etc \
        usr/bin/dh_* \
        usr/lib/valgrind \
        usr/share/doc \
        usr/share/man \
        usr/share/applications \
        usr/share/apps \
        usr/share/binfmts \
        usr/share/debhelper \
        usr/share/doc-base \
        usr/share/lintian \
        usr/share/perl5 \
        usr/share/pixmaps \
        usr/share/python/dh_*

WORKDIR /


FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
