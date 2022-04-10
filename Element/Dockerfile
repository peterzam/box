FROM ubuntu:latest
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN apt install -yq --no-install-recommends \
        wget \
        apt-transport-https \
        ca-certificates \
        gnupg \
        libgbm-dev \
        libpulse0 \
    && wget -O /usr/share/keyrings/element-io-archive-keyring.gpg https://packages.element.io/debian/element-io-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" \
        > /etc/apt/sources.list.d/element-io.list \
    && apt update && apt install element-desktop -yq --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "element-desktop" ]