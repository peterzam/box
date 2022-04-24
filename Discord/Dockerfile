FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && curl -fSL "https://discord.com/api/download?platform=linux&format=tar.gz" -o discord.tar.gz \
    && tar xzvf discord.tar.gz

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
COPY --from=downloader --chown=user:user Discord /home/user/Discord
RUN apt install -yq --no-install-recommends \
    fonts-noto-color-emoji \
    fonts-noto-cjk \
    libgbm-dev \
    libxshmfence1 \
    libdrm2 \
    libpulse0 \
    libc++1 \
    libappindicator1 \
    gconf2 \
    gconf-service \
    gvfs-bin \
    libasound2 \
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
# font-noto-extra <- add this package for some font errors but the size is large.

USER user
WORKDIR /home/user
ENTRYPOINT [ "/home/user/Discord/Discord" ]