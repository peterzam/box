# Brave Browser in Docker Container
## *Use this only if you fully understand what you are doing.*
---

### **Things to know before build**
- "UID" from line 3 - Dockerfile \<UID for container, should be the same as host's UID - [Why?](#permission-for-shared-folder)>
- "GID" from line 4 - Dockerfile \<GID for container, should be the same as host's GID - [Why?](#permission-for-shared-folder)>

### Build
```bash
# docker buildkit to reduce image size
DOCKER_BUILDKIT=1 docker build -t peterzam/x-brave -f dockerfiles/Brave/Dockerfile .
```
---

### **Things to check before run**
- Check [this thread](https://stackoverflow.com/questions/59087200/google-chrome-failed-to-move-to-new-namespace) about [seccomp](https://docs.docker.com/engine/security/seccomp/) and [sandboxing](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md)
- Create folders that need to be shared [Why?](#permission-for-shared-folder)
- For audio, check [here](#audio) first
- 

### Run (With seccomp and sandboxed)
```bash
docker run -it --rm \
--name x-brave \
-e DISPLAY \
-e PULSE_SERVER=tcp:<host-ip>:4713 \
-v ${XAUTHORITY}:/home/user/.Xauthority \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ${PWD}/dockerfiles/Brave/shared/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/dockerfiles/Brave/shared/Downloads:/home/user/Downloads:rw \
-v /dev/shm:/dev/shm \
--security-opt seccomp=${PWD}/chrome.json \
peterzam/x-brave
```

### Run (Without seccomp and sandboxed)
```bash
docker run -it --rm \
--name x-brave \
-e DISPLAY \
-e PULSE_SERVER=tcp:<host-ip>:4713 \
-v ${XAUTHORITY}:/home/user/.Xauthority \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ${PWD}/dockerfiles/Brave/shared/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/dockerfiles/Brave/shared/Downloads:/home/user/Downloads:rw \
-v /dev/shm:/dev/shm \
peterzam/x-brave --no-sandbox
```

---

## **Permission for shared folder**
- The application in the container is run with a specific created user, not root.
- When you mount a folder from host to container, the mounted folder in container carries permissions from original host folder.
- If there is no folder on host as the docker run command, the docker create the folder automatically with root.
- So, The UID and GID for the container must have the permission for mounted folder.
- The easiest way to work them properly is 
    - Create docker image with the same UID and GID as host. 
    - Created the folders that are need to be shared with container on host.

---

## **Audio**

### *ALSA*
If your host OS is using ALSA as sound server, replace 
`'-e PULSE_SERVER=tcp:<host-ip>:4713 \'` line from `docker run` command with `'--device /dev/snd \'`

### *Pulseaudio*
There are many methods to share audio with Pulseaudio. But in this example, I will use Pulseaudio over TCP 'with no authentication'.
If you want to set-up more securely, check [this wiki](https://github.com/mviereck/x11docker/wiki/Container-sound:-ALSA-or-Pulseaudio#pulseaudio-over-tcp) 
about pulseaudio over TCP.


#### **How to Set-up Pulseaudio over TCP**
- First, you need to install *PulseAudio Preferences* software with `sudo apt-get install paprefs` on host.
- And in *PulseAudio Preferences -> Network Server*, check *'Enable network access to local sound devices'* and *'Don't require authentication'*.
- Then restart PulseAudio server with `pulseaudio -k && pulseaudio --start`
- Replace `<host-ip>` with host's IP address in `docker run` command.

---