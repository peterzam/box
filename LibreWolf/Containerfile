FROM ubuntu:latest
ARG UID=1000
ARG GID=1000

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user

RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
RUN apt install -yq --no-install-recommends \
    libgtk-3-0 \
    libxtst6 \
    libdbus-glib-1-2 \
    libpulse0 \
    libasound2 \
    libavcodec-dev \
    libgl1 \
    wget \
    gnupg \
    ca-certificates \
    && distro=$(if echo " bullseye focal impish jammy uma una " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi) \
    && echo "deb [arch=amd64] http://deb.librewolf.net $distro main" | tee /etc/apt/sources.list.d/librewolf.list \
    && wget https://deb.librewolf.net/keyring.gpg -O /etc/apt/trusted.gpg.d/librewolf.gpg \
    && apt update \
    && apt install librewolf -yq --no-install-recommends \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "librewolf" ]
