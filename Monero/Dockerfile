FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && curl -fSLO "https://downloads.getmonero.org/gui/linux64" \
    && tar xvf linux64 


FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user


RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
RUN apt install qt5dxcb-plugin -yq --no-install-recommends \
        && fc-cache -fv \
        && rm -rf /var/lib/apt/lists/* \
        && apt autoclean && apt autoremove --purge \
        && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
        && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;


USER user
WORKDIR /home/user
COPY --from=downloader --chown=user:user monero-gui-v* /home/user/monero
ENTRYPOINT [ "/home/user/monero/monero-wallet-gui" ]