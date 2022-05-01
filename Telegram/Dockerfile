FROM alpine:latest as downloader
ARG version=11.0.10
RUN apk update \
    && apk add curl \
    && curl -JLO $(curl -s https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | grep -E ".*url.*tar.xz" | cut -d '"' -f4) \
    && tar xvf tsetup.* && rm Telegram/Updater

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user
COPY --from=downloader --chown=user:user /Telegram /home/user/Telegram

RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends

RUN apt install -yq --no-install-recommends \
    libglib2.0-dev \
    libfontconfig1 \
    libegl1 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "/home/user/Telegram/Telegram" ]