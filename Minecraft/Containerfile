FROM alpine:latest as downloader
RUN apk update \
    && apk add curl \
    && curl -J -L -O https://launcher.mojang.com/download/Minecraft.deb

FROM ubuntu:latest
ARG UID=1000
ARG GID=1000

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user
COPY --from=downloader --chown=user:user /Minecraft.deb /Minecraft.deb

RUN apt install -yq  --no-install-recommends \
    default-jre \
    libasound2 \
    libpulse0 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libgbm1 \
    libfontconfig1 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libpangocairo-1.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcb1 \
    libsecret-1-0 \
    xdg-utils \
    gnome-keyring \
    dbus-x11 \
    wget \
    libcurl4 \
    && dpkg -i /Minecraft.deb && rm /Minecraft.deb \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "/bin/bash","-c","eval $(printf 'a' | gnome-keyring-daemon --replace --unlock) && minecraft-launcher" ]