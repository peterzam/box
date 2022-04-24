FROM alpine:latest as downloader
ARG version=4.4.2
RUN apk update \
    && apk add curl \
    && "https://onboardcloud.dl.sourceforge.net/project/qbittorrent/qbittorrent-appimage/qbittorrent-${version}/qbittorrent-${version}_x86_64.AppImage" -o /tmp/qbittorrent

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -g ${GID} -m user
RUN apt install qt5dxcb-plugin -yq --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* \
        && apt autoclean && apt autoremove --purge \
        && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
        && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
COPY --from=downloader --chmod=0744 --chown=${UID}:${GID} /tmp/qbittorrent ./qbittorrent
ENTRYPOINT [ "/home/user/qbittorrent","--appimage-extract-and-run" ]
