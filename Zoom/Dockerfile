FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && curl -J -L -O https://zoom.us/client/latest/zoom_amd64.deb

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user
COPY --from=downloader --chown=user:user /zoom_amd64.deb /zoom_amd64.deb

RUN apt install -yq  --no-install-recommends \
    libxcb-keysyms1 \
    libglib2.0-0 \
    libxcb-shape0 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxcb-randr0 \
    libxcb-image0 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libegl1-mesa \
    libxi6 \
    libsm6 \
    libxrender1 \
    libpulse0 \
    libxcomposite1 \
    libxcomposite1 \
    libxslt1.1 \
    libsqlite3-0 \
    libxcb-xtest0 \
    libdbus-1-3 \
    libxtst6 \
    ibus \
    libxcb-xinerama0 \
    libxkbcommon-x11-0 \
    desktop-file-utils \
    libfreetype6 \
    libnss3-dev \
    libasound2 \
    ca-certificates \
    && dpkg -i /zoom_amd64.deb && rm /zoom_amd64.deb \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "zoom" ]