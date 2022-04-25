FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && version=$(curl -s https://product-details.mozilla.org/1.0/firefox_versions.json  | grep LATEST_FIREFOX_VERSION | cut -d '"' -f4) \
    && curl -J -L -O https://download-installer.cdn.mozilla.net/pub/firefox/releases/$version/linux-x86_64/en-US/firefox-$version.tar.bz2 \
    && tar xvf firefox-*

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
COPY --from=downloader --chown=user:user /firefox /home/user/firefox
RUN apt install -yq --no-install-recommends \
    libgtk-3-0 \
    libasound2 \
    libxtst6 \
    libdbus-glib-1-2 \
    libpulse0 \
    libavcodec-dev \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "/home/user/firefox/firefox" ]
