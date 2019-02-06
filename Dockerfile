FROM alpine:edge
MAINTAINER dandengro
LABEL maintainer="dandengro"

# set version for s6 overlay
ARG OVERLAY_VERSION="v1.21.7.0"
ARG OVERLAY_ARCH="amd64"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
HOME="/app" \
TERM="xterm"

RUN \
    # install build packages
    apk add --no-cache --virtual=build-dependencies \
        curl \
        tar && \
    # install runtime packages
    apk add --no-cache \
        bash \
        ca-certificates \
        coreutils \
        shadow \
        tzdata && \
    # add s6 overlay
    curl -o \
        /tmp/s6-overlay.tar.gz -L \
        "https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
    tar xfz \
        /tmp/s6-overlay.tar.gz -C / && \
    # create abc user and make our folders
    groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/false abc && \
    usermod -G users abc && \
    mkdir -p \
        /app \
        /config \
        /defaults && \
    # cleanup
    apk del --purge \
        build-dependencies && \
    rm -rf \
        /tmp/*

# add local files
COPY root/ /

ENTRYPOINT ["/init"]