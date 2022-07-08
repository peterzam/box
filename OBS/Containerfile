FROM ubuntu:latest

ARG UID=1000
ARG GID=1000
ENV TZ=Europe/London

RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -s /bin/bash -r -G audio,video -g ${GID} -m user

RUN DEBIAN_FRONTEND="noninteractive" TZ="Europe/London" apt-get install -y tzdata keyboard-configuration --no-install-recommends
RUN apt install -yq --no-install-recommends software-properties-common gpg-agent libpulse0 \
    && add-apt-repository -y ppa:obsproject/obs-studio \
    && apt update \
    && apt install -yq --no-install-recommends ffmpeg obs-studio \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

RUN echo "default-server = unix:/run/user/1000/pulse/native\nautospawn = no\ndaemon-binary = /bin/true\nenable-shm = false" > /etc/pulse/client.conf

USER user
WORKDIR /home/user
ENTRYPOINT [ "obs" ]