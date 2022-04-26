FROM alpine:latest as downloader
ARG version=11.0.10
RUN apk update \
    && apk add curl \
    && curl -J -L -O "https://dist.torproject.org/torbrowser/${version}/tor-browser-linux64-${version}_en-US.tar.xz" \
    && tar xvf tor-browser-linux64-*

FROM ubuntu:impish
ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
COPY --from=downloader --chown=user:user /tor-browser_en-US/ /home/user/tor
RUN apt install -yq --no-install-recommends \
    libx11-xcb-dev \
    libxt6 \ 
    libgtk-3-0 \
    libdbus-glib-1-2 \
    file \
    libpulse0 \
    libavcodec-dev \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "/home/user/tor/Browser/start-tor-browser", "-v" ]
