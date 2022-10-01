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

# PolyMC
x-polymc:
	podman run --rm -it \
	--name=x-polymc \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v ${XPATH}/configs/polymc:/home/user/.local/share/PolyMC \
	-v ${XPATH}/shared/polymc:/home/user/Shared \
	peterzam/x-polymc


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


# Viber
x-viber:
	podman run --rm \
	--name=x-viber \
	--userns=keep-id \
	--device=/dev/dri \
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /run/user/1000/pulse:/run/user/1000/pulse \
	-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
	-v ${HOME}/.local/share/fonts:/home/user/.local/share/fonts:ro \
	-v ${XPATH}/configs/viber:/home/user/.ViberPC \
	-v ${XPATH}/shared/viber:/home/user/Documents/ViberDownloads \
	peterzam/x-viber


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


## For Yubikey, add this line
# -v /dev:/dev --device-cgroup-rule='c 188:* rmw' --device-cgroup-rule='c 81:* rmw' \

## Further reading
# https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device
