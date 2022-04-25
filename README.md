# xDocker
Docker with X Server. Actually, containerise my daily "linux" softwares. 
## *!!! Use this only if you fully understand what you are doing. This is personal project. Don't use in real-time deployment !!!*
Why I wrote this project:
First, I'm bored. Second, I usually stick with a specific OS but I want my apps to be as portable as possible. Third, I thought it would improve security by containersie the apps(but it is not the truth). Fourth, I don't wanna mess with the OS network(route table) for routing different networks with different apps.

---
Drawbacks?
- Sharing X Server directly between host and container, PulseAudio(Sound) over network are dangerous for non-experts.
- The overall size for individual apps with containers will definitely larger than app alone.
- Some apps may or may not work, pretty difficult to set up like OBS, or not worth to run them on containers like cli apps.
- Of course, you need docker.

---

## !!! Read this before build and run !!! 
### Brave Browser in Docker as example:

### **Things to know before build**
- "UID" from Dockerfile \<UID for container, should be the same as host's UID - [Why?](#permission-for-mounted-folder)>
- "GID" from Dockerfile \<GID for container, should be the same as host's GID - [Why?](#permission-for-mounted-folder)>

### Build
```bash
# docker buildkit to reduce image size
DOCKER_BUILDKIT=1 docker build -t peterzam/x-brave -f dockerfiles/Brave/Dockerfile .
```
---

### **Things to check before run**
- Check [this thread](https://stackoverflow.com/questions/59087200/google-chrome-failed-to-move-to-new-namespace) about [seccomp](https://docs.docker.com/engine/security/seccomp/) and [sandboxing](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md)
- Create folders that need to be mounted [Why?](#permission-for-mounted-folder)
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
-v ${PWD}/dockerfiles/Brave/mounted/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/dockerfiles/Brave/mounted/Shared:/home/user/Shared:rw \
--shm-size 2g \
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
-v ${PWD}/dockerfiles/Brave/mounted/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/dockerfiles/Brave/mounted/Shared:/home/user/Shared:rw \
--shm-size 2g \
peterzam/x-brave --no-sandbox
```

---

## **Permission for mounted folder**
- The application in the container is run with a specific created user, not root.
- When you mount a folder from host to container, the mounted folder in container carries permissions from original host folder.
- If there is no folder on host as the docker run command, the docker create the folder automatically with root.
- So, The UID and GID for the container must have the permission for mounted folder.
- The easiest way to work them properly is 
    - Create docker image with the same UID and GID as host. 
    - Created the folders that are need to be mounted with container on host.

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
