# xDocker
Docker with X Server. Actually, containerised my daily "Linux" softwares. 
## *!!! Use this only if you fully understand what you are doing. This is a personal project. Don't use it in real-time deployment !!!*
Why did I write this?

First, I'm bored. Second, I want to make my daily apps portable. Third, I thought it would improve security by containerising the apps(but it is not the truth). Fourth, I don't want to mess with the OS network(route table) for routing different networks for different apps.

So What is the result?

Till now, I am fairly satisfied about this and since currently there are only a few images, maybe in the future, I would change my mind.

---
Drawbacks?
- Mounting X Server and PulseAudio directly between host and container is not safe for daily use.
- The overall size for individual apps with containers will definitely be larger than non-containerised apps.
- Some apps may not work, might be pretty difficult to set up like OBS and Wireshark, or may not be worth running them on containers like cli apps.
- GUI is a little degrade than normal, but it can be solved by libgl1. Check about libgl1 [here](#libgl1)
- Of course, you will need docker.

---

## !!! Read this before build and run !!! 
### TLDR ; Check `info.yml`

*Brave Browser as example*

### **Things to know before build**
- "UID" from Dockerfile \<UID for container, should be the same as host's UID - [Why?](#permission-for-mounted-folder)\>
- "GID" from Dockerfile \<GID for container, should be the same as host's GID - [Why?](#permission-for-mounted-folder)\>

### Build
```bash
# Use docker buildkit to reduce image size
DOCKER_BUILDKIT=1 docker build -t peterzam/x-brave -f ./Brave/Dockerfile .
```

### **Things to check before run**
- Check [this thread](https://stackoverflow.com/questions/59087200/google-chrome-failed-to-move-to-new-namespace) about [seccomp](https://docs.docker.com/engine/security/seccomp/) and [sandboxing](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md)
- Create folders that need to be mounted first before running. [Why?](#permission-for-mounted-folder)
- For audio, check [here](#audio)
- For fonts, check [here](#fonts)
- For Graphic Drive, check [here](#libgl1)

### Run (With --seccomp)<*Recommend*>
```bash
docker run --rm \
--name x-brave \
-e DISPLAY \
-v ${XAUTHORITY}:/home/user/.Xauthority:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /run/user/1000/pulse:/run/user/1000/pulse:rw \
-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
-v ${PWD}/Brave/mounted/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/Brave/mounted/Shared:/home/user/Shared:rw \
--shm-size 2g \
--security-opt seccomp=${PWD}/rules.json \
peterzam/x-brave
```

### Run (With --no-sandbox)
```bash
docker run --rm \
--name x-brave \
-e DISPLAY \
-v ${XAUTHORITY}:/home/user/.Xauthority:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /run/user/1000/pulse:/run/user/1000/pulse:rw \
-v /usr/share/fonts/truetype/:/usr/share/fonts/truetype:ro \
-v ${PWD}/Brave/mounted/configs:/home/user/.config/BraveSoftware:rw \
-v ${PWD}/Brave/mounted/Shared:/home/user/Shared:rw \
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
`-v /run/user/1000/pulse:/run/user/1000/pulse:rw \` line from `docker run` command with `'--device /dev/snd \'`

### *Pulseaudio*
There are many methods to share audio with Pulseaudio. But in this example, I will mount PulseAudio directly via unix socket.
If you want to set-up more securely using pulse-cookie, check [this article](https://github.com/mviereck/x11docker/wiki/Container-sound:-ALSA-or-Pulseaudio#pulseaudio-with-shared-socket).

#### **Other recommend articles about Audio**
- https://github.com/TheBiggerGuy/docker-pulseaudio-example/blob/master/Dockerfile
- https://github.com/mviereck/x11docker/wiki/Container-sound:-ALSA-or-Pulseaudio
- https://www.systutorials.com/docs/linux/man/1-pax11publish/
- https://manpages.ubuntu.com/manpages/trusty/man1/start-pulseaudio-x11.1.html
- https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Network/
- https://superuser.com/questions/231920/forwarding-audio-like-x-in-ssh
- https://unix.stackexchange.com/questions/470961/how-to-set-up-pulseaudio-remote-properly-and-securely

---

## **Fonts**
- Font packages are pretty big for each image compared to the original linux shared library type. 
- I decided to not install them and mount fonts from host.The path is `/usr/share/fonts/` for Debian.

Recommend fonts:

| Package Name | Estimate Size | Type |
| --- | --- | --- |
| fonts-tlwg-loma-ttf | 400 KB | Basic|
| fonts-ubuntu | 4 MB | Basic |
| fonts-noto | 40 MB | Basic |
| fonts-noto-cjk|90 MB | Chinese,Japanese,Korean |
| fonts-noto-color-emoji | 10 MB | Emoji |
| fonts-noto-cjk-extra | 300 MB | Extra |
| fonts-noto-extra | 350 MB | Extra |

*!beware of font-fingerprinting for browsers while mounting host fonts onto container*

---

## **libgl1**
- libGL is OpenGL Mesa driver which use GLX protocol over X server via socket. [Read more here](https://dri.freedesktop.org/wiki/libGL/).
- Total size of libgl1 including dependencies is about 170MB but I think it is a worth trade-off for UI to install.
- And I decided to mount "/dev/dri" in some containers for [DRI](https://dri.freedesktop.org/wiki/) for graphic performance. 
---

## **apt-transport-https**
- apt-transport-https makes apt to fetch only over https.
- But I decided to left it.[Why?](https://news.ycombinator.com/item?id=18958679)

---
