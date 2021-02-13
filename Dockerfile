FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yq \
    openssl \
    net-tools \
    git \
    locales \
    sudo \
    dumb-init \
    vim \
    curl \
    wget \
    build-essential \
    bsdmainutils \
    gdb

RUN locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN adduser --gecos '' --shell /usr/bin/bash --disabled-password code && \
    echo "code ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd && \
    chown -R code /home/code
VOLUME [ "/home/code" ]

ENV CODER_VERSION 3.9.0
WORKDIR /app
ADD start.sh /app
RUN wget -q https://github.com/cdr/code-server/releases/download/v${CODER_VERSION}/code-server-${CODER_VERSION}-linux-amd64.tar.gz && \
    tar -xaf code-server-*.tar.gz && \
    rm code-server-*.tar.gz && \
    mv code-server-* code-server && \
    chmod +x /app/start.sh

USER code
WORKDIR /home/code

ENTRYPOINT ["dumb-init", "--", "/app/start.sh"]
CMD ["--bind-addr", "0.0.0.0:8080", "--auth", "password"]
