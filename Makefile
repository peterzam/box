XPATH=<folder path for configs and shared folders>

# Brave
x-brave:
	podman run --rm \
	--name=x-brave \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/brave:/home/user/.config/BraveSoftware \
	-v ${XPATH}/shared/brave:/home/user/Shared \
	--shm-size 2g \
	peterzam/x-brave


# DBeaver
x-dbeaver:	
	podman run --rm \
	--name=x-dbeaver \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/dbeaver:/home/user/.local/share/DBeaverData \
	-v ${XPATH}/shared/dbeaver:/home/user/Shared \
	peterzam/x-dbeaver


# Discord
x-discord:	
	podman run --rm \
	--name=x-discord \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/discord:/home/user/.config/discord \
	-v ${XPATH}/shared/discord:/home/user/Shared \
	peterzam/x-discord


# Element
x-element:
	podman run --rm \
	--name=x-element \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/element:/home/user/.config/Element \
	-v ${XPATH}/shared/element:/home/user/Shared \
	peterzam/x-element


# Firefox
x-firefox:
	podman run --rm \
	--name=x-firefox \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/firefox:/home/user/.mozilla \
	-v ${XPATH}/shared/firefox:/home/user/Shared \
	peterzam/x-firefox


# Librewolf
x-librewolf:
	podman run --rm \
	--name=x-librewolf \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-e XDG_CURRENT_DESKTOP \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/librewolf:/home/user/.librewolf \
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
	peterzam/x-monero


# OBS
x-obs:
	podman run --rm \
	--name=x-obs \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
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
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v ${XPATH}/configs/prismlauncher:/home/user/.local/share/PrismLauncher \
	-v ${XPATH}/shared/prismlauncher:/home/user/Shared \
	peterzam/x-prismlauncher


# Qbittorrent
x-qbittorrent:
	podman run --rm \
	--name=x-qbittorrent \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XPATH}/configs/qbittorrent:/home/user/.config/qBittorrent \
	-v ${XPATH}/shared/qbittorrent:/home/user/Shared \
	peterzam/x-qbittorrent


# Telegram
x-telegram:
	podman run --rm \
	--name=x-telegram \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/telegram:/home/user/.local/share/TelegramDesktop \
	-v ${XPATH}/shared/telegram:/home/user/Shared \
	peterzam/x-telegram


# Tor
x-tor:
	podman run --rm \
	--name=x-tor \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${XPATH}/configs/tor:/home/user/tor/TorBrowser/Data/Browser \
	-v ${XPATH}/shared/tor:/home/user/Shared \
	peterzam/x-tor


# Winbox
x-winbox:
	podman run --rm \
	--name=x-winbox \
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
	-e XDG_CURRENT_DESKTOP \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v ${XPATH}/configs/zoom:/home/user/.zoom \
	-v ${XPATH}/configs/zoom/zoomus.conf:/home/user/.config/zoomus.conf \
	-v ${XPATH}/shared/zoom:/home/user/Shared \
	peterzam/x-zoom


## For Yubikey, add this line
# -v /dev:/dev --device-cgroup-rule='c 188:* rmw' --device-cgroup-rule='c 81:* rmw' \

## Further reading
# https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device

# to use wayland - https://unix.stackexchange.com/questions/330366/how-can-i-run-a-graphical-application-in-a-container-under-wayland
# -e XDG_RUNTIME_DIR=/tmp \
# -e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
# -v ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:/tmp/${WAYLAND_DISPLAY}  \

# For mozilla - 	-e MOZ_ENABLE_WAYLAND=1 \
# For chromium - --enable-features=UseOzonePlatform --ozone-platform=wayland - https://www.reddit.com/r/Fedora/comments/rkzp78/make_chrome_run_on_wayland_permanently
# For QT - -e QT_QPA_PLATFORM=wayland