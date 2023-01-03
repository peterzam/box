XPATH=/home/p/custom/xcontainer

# Brave
x-brave:
	podman run --rm \
	--name=x-brave \
	--userns=keep-id \
	--device=/dev/dri \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/brave:/home/user/.config/BraveSoftware \
	-v ${XPATH}/shared/brave:/home/user/Shared \
	--shm-size 2g \
	peterzam/x-brave

x-brave-incognito:
	podman run --rm \
	--name=x-brave-incognito \
	--userns=keep-id \
	--device=/dev/dri \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/shared/brave:/home/user/Shared \
	--shm-size 2g \
	peterzam/x-brave --enable-features=UseOzonePlatform --ozone-platform=wayland

x-brave-incognito-x:
	podman run --rm \
	--name=x-brave-incognito-x \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/shared/brave:/home/user/Shared \
	--shm-size 2g \
	peterzam/x-brave

# Discord
x-discord:	
	podman run --rm \
	--name=x-discord \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/discord:/home/user/.config/discord \
	-v ${XPATH}/shared/discord:/home/user/Shared \
	peterzam/x-discord


# DBeaver
x-dbeaver:	
	podman run --rm \
	--name=x-dbeaver \
	--userns=keep-id \
	--device=/dev/dri \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/dbeaver:/home/user/.local/share/DBeaverData \
	-v ${XPATH}/shared/dbeaver:/home/user/Shared \
	peterzam/x-dbeaver


# Element
x-element:
	podman run --rm \
	--name=x-element \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/element:/home/user/.config/Element \
	-v ${XPATH}/shared/element:/home/user/Shared \
	peterzam/x-element

# Librewolf
x-librewolf:
	podman run --rm \
	--name=x-librewolf \
	--userns=keep-id \
	--device=/dev/dri \
	-e MOZ_ENABLE_WAYLAND=1 \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/librewolf:/home/user/.librewolf \
	-v ${XPATH}/shared/librewolf:/home/user/Shared \
	peterzam/x-librewolf

x-librewolf-incognito:
	podman run --rm \
	--name=x-librewolf-incognito \
	--userns=keep-id \
	--device=/dev/dri \
	-e MOZ_ENABLE_WAYLAND=1 \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/shared/librewolf:/home/user/Shared \
	peterzam/x-librewolf


# Monero
x-monero:
	podman run --rm \
	--name=x-monero \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XPATH}/configs/monero:/home/user/.config/monero-project \
	-v ${XPATH}/shared/monero:/home/user/Shared \
	-v /mnt/wd0/Misc/Monero/lmdb:/home/user/lmdb \
	peterzam/x-monero


# OBS
x-obs:
	podman run --rm \
	--name=x-obs \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v ${XPATH}/configs/obs:/home/user/.config/obs-studio \
	-v ${XPATH}/shared/obs:/home/user/Shared \
	peterzam/x-obs


# Prismlaucher
x-prismlauncher:
	podman run --rm -it \
	--name=x-prismlauncher \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e QT_QPA_PLATFORM=wayland \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
	-v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v ${XPATH}/configs/prismlauncher:/home/user/.local/share/PrismLauncher \
	-v ${XPATH}/shared/prismlauncher:/home/user/Shared \
	--memory-reservation 6G \
	-m 8G \
	peterzam/x-prismlauncher


# Qbittorrent
x-qbittorrent:
	podman run --rm \
	--name=x-qbittorrent \
	--userns=keep-id \
	--device=/dev/dri \
	-e QT_QPA_PLATFORM=wayland \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XPATH}/configs/qbittorrent:/home/user/.config/qBittorrent \
	-v ${XPATH}/shared/qbittorrent:/home/user/Shared \
	peterzam/x-qbittorrent


# Telegram
x-telegram:
	podman run --rm \
	--name=x-telegram \
	--userns=keep-id \
	--device=/dev/dri \
	-e QT_QPA_PLATFORM=wayland \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v /usr/share/fonts:/usr/share/fonts:ro \
	-v ${XPATH}/configs/telegram:/home/user/.local/share/TelegramDesktop \
	-v ${XPATH}/shared/telegram:/home/user/Shared \
	peterzam/x-telegram


# Tor
x-tor:
	podman run --rm \
	--name=x-tor \
	--userns=keep-id \
	--device=/dev/dri \
	-e MOZ_ENABLE_WAYLAND=1 \
	-e XDG_CURRENT_DESKTOP \
	-e XDG_RUNTIME_DIR \
	-e WAYLAND_DISPLAY \
    -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v ${XPATH}/configs/tor:/home/user/tor/TorBrowser/Data/Browser \
	-v ${XPATH}/shared/tor:/home/user/Shared \
	peterzam/x-tor

# Winbox
x-winbox:
	podman run --rm \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XPATH}/configs/winbox:/home/user/.wine \
	peterzam/x-winbox

 
# Zoom
x-zoom:
	podman run --rm \
	--name=x-zoom \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse \
	-v ${XPATH}/configs/zoom:/home/user/.zoom \
	-v ${XPATH}/configs/zoom/zoomus.conf:/home/user/.config/zoomus.conf \
	-v ${XPATH}/shared/zoom:/home/user/Shared \
	peterzam/x-zoom


# Jenkins
x-jenkins:
	podman run --rm -d \
	--name=x-jenkins \
	-v ${PWD}/Jenkins/mounted/Shared:/home/jenkins_home/Shared \
	-v ${PWD}/Jenkins/mounted/configs:/var/jenkins_home \
	-p 8080:8080 \
	-p 50000:50000 \
	--userns=keep-id \
	--cgroup-conf=memory.high=4294967296 \
	jenkins/jenkins


# -v /dev:/dev --device-cgroup-rule='c 188:* rmw' --device-cgroup-rule='c 81:* rmw' \
# https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device

# to use wayland - https://unix.stackexchange.com/questions/330366/how-can-i-run-a-graphical-application-in-a-container-under-wayland
# -e XDG_RUNTIME_DIR=/tmp \
# -e WAYLAND_DISPLAY \
# -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \

# For mozilla - 	-e MOZ_ENABLE_WAYLAND=1 \
# For chromium - --enable-features=UseOzonePlatform --ozone-platform=wayland - https://www.reddit.com/r/Fedora/comments/rkzp78/make_chrome_run_on_wayland_permanently
# For QT - -e QT_QPA_PLATFORM

# Experimental feature - -v ${XDG_RUNTIME_DIR}/pipewire-0:${XDG_RUNTIME_DIR}/pipewire-0 \
