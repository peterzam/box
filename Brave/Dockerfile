FROM ubuntu:latest
ARG UID=1000
ARG GID=1000
RUN apt-get update && groupadd -g ${GID} -r user && useradd -u ${UID} -r -G audio,video -g ${GID} -m user
RUN apt install --yes --no-install-recommends \
        ca-certificates \
        fonts-tlwg-loma-ttf \
        gnupg \
        libgl1 \
        pulseaudio \
    && apt-key adv --keyserver keyserver.ubuntu.com \
        --recv-keys D8BAD4DE7EE17AF52A834B2D0BB75829C2D4E821 \
    && echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        > /etc/apt/sources.list.d/brave-browser-release.list \
    && apt update \
    && apt-cache policy brave-browser \
    && apt-get install -yq --no-install-recommends \
        brave-browser \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoclean && apt autoremove --purge \
    && find / -xdev -type f -perm /u+s -exec chmod -c u-s {} \; \
    && find / -xdev -type f -perm /g+s -exec chmod -c g-s {} \;

USER user
WORKDIR /home/user
ENTRYPOINT [ "brave-browser" ]