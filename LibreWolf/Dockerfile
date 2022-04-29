FROM alpine:latest as downloader
RUN apk update \
    && apk add curl jq \
    && curl -fSLO "https://gitlab.com/api/v4/projects/24386000/packages/generic/librewolf/$(curl -s https://gitlab.com/api/v4/projects/24386000/releases/ | jq '.[]' | jq -r '.name' | head -1 | cut -c 2- )/LibreWolf.x86_64.AppImage"

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
COPY --from=downloader --chown=user:user --chmod=700 /LibreWolf.x86_64.AppImage /home/user/LibreWolf
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
ENTRYPOINT [ "/home/user/LibreWolf","--appimage-extract-and-run" ]
