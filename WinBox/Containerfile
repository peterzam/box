FROM alpine:latest as downloader
ARG version=11.0.10
RUN apk update \
    && apk add curl \
    && curl -JL https://mt.lv/winbox64 -o winbox.exe

FROM ubuntu:latest
ARG UID=1000
ARG GID=1000

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user
COPY --from=downloader --chown=user:user /winbox.exe /home/user/

RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends

RUN apt install wine -yq --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "/usr/bin/wine","/home/user/winbox.exe" ]
