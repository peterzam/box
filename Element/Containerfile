FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user

RUN apt install -yq --no-install-recommends \
        wget \
        ca-certificates \
        gnupg \
        libgbm-dev \
        libpulse0 \
        libasound2 \
    && wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" \
        > /etc/apt/sources.list.d/element-io.list \
    && apt update && apt install element-desktop -yq --no-install-recommends \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "element-desktop" ]
