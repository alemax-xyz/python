FROM library/debian:stable-slim AS build

ENV LANG=C.UTF-8 \
    SANDBOX_ROOT=/

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y wget openssl ca-certificates

ADD https://github.com/alemax-xyz/misc-tools.git#main /usr/local/bin/

RUN mkdir -p /build /rootfs

WORKDIR /build

COPY build/ .

COPY --from=clover/common:latest /var/lib/packages/ var/lib/packages/

RUN apt-sandbox --install --verstamp \
        --apt-config \
            APT::Install-Recommends=false \
            APT::Get::Upgrade==false \
        --repository . \
        --keyring . \
        --installed var/lib/packages \
        --obsolete packages.obsolete \
        --required packages.required

WORKDIR /rootfs

RUN rm -rf \
        etc \
        usr/share/applications \
        usr/share/doc \
        usr/share/doc-base \
        usr/share/lintian \
        usr/share/man \
        usr/share/pixmaps \
        usr/share/python3

WORKDIR /

FROM clover/common

ENV LANG=C.UTF-8

COPY --from=build /rootfs /
