FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && curl -fSL "https://discord.com/api/download?platform=linux&format=tar.gz" -o discord.tar.gz \
    && tar xzvf discord.tar.gz


FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user
COPY --from=downloader --chown=user:user Discord /home/user/Discord

RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
RUN apt install -yq --no-install-recommends \
    libgbm-dev \
    libxshmfence1 \
    libdrm2 \
    libpulse0 \
    libc++1 \
    libappindicator1 \
    gvfs \
    libcap2 \
    libgconf-2-4 \
    libgtk-3-0 \
    libcanberra-gtk3-module \
    libnotify4 \
    libnss3 \
    libxkbfile1 \
    libxss1 \
    libxtst6 \
    libx11-xcb1 \
    xdg-utils \
    libatomic1 \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "/home/user/Discord/Discord" ]
