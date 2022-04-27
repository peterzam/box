# xDocker
Docker with X Server. Actually, containerised my daily "linux" softwares. 
## *!!! Use this only if you fully understand what you are doing. This is a personal project. Don't use it in real-time deployment !!!*
Why did I write this?

First, I'm bored. Second, I want to make my daily apps portable. Third, I thought it would improve security by containerising the apps(but it is not the truth). Fourth, I don't want to mess with the OS network(route table) for routing different networks for different apps.

---
Drawbacks?
- Sharing X Server directly between host and container, PulseAudio(Sound) over the network is dangerous for daily use.
- The overall size for individual apps with containers will definitely be larger than non-containerised apps.
- Some apps may not work, might be pretty difficult to set up like OBS and Wireshark, or may not be worth running them on containers like cli apps.
- Of course, you will need docker.

---

## !!! Read this before build and run !!! 
### Brave Browser in Docker as example:

### **Things to know before build**
- "UID" from Dockerfile \<UID for container, should be the same as host's UID - [Why?](#permission-for-mounted-folder)\>
- "GID" from Dockerfile \<GID for container, should be the same as host's GID - [Why?](#permission-for-mounted-folder)\>

### Build
```bash
# Use docker buildkit to reduce image size
DOCKER_BUILDKIT=1 docker build -t peterzam/x-brave -f ./Brave/Dockerfile .
```
---

### **Things to check before run**
- Check [this thread](https://stackoverflow.com/questions/59087200/google-chrome-failed-to-move-to-new-namespace) about [seccomp](https://docs.docker.com/engine/security/seccomp/) and [sandboxing](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md)
- Create folders that need to be mounted first before running. [Why?](#permission-for-mounted-folder)
- For audio, check [here](#audio) first

### TLDR ; Check `info.yml`

### Run (With --seccomp)<*Recommend*>
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
--security-opt seccomp=${PWD}/rules.json \
peterzam/x-brave
```

### Run (With --no-sandbox)
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
- When mounting a folder from host to container, the mounted folder in the container carries permissions from the original host folder.
- If there is no folder on the host as the docker run command, the docker creates the folder automatically with root.
- So, The UID and GID for the container must have the permission for the mounted folder on host.
- The easiest way to work them properly is 
    - Create a docker image with the same UID and GID as host's mounted folder permission. 
    - Created the folders on the host beforehand with right permission that needed to be mounted .

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
