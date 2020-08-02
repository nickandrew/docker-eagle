# docker-eagle

Autodesk EAGLE (formerly by CadSoft) is popular PCB design software, with a schematic editor, extensive part libraries, PCB layout editor, track auto-routing and more.

EAGLE is available under both freeware and commercial licenses using a license key file.

This repository packages the latest (at commit time) 64-bit Linux release of EAGLE in a Docker container.

## BUILDING

First install docker (see [Docker Installation](http://docs.docker.com/installation/) )

Then run: `docker build -t eagle962 .`

## RUNNING

EAGLE is graphical software and the container runs a VNC server on container port 5901.

To run the container:

   ```docker run -p 32768:5901 -t -i nickandrew/eagle```

This will make the VNC server visible on localhost port 32768. Next, run a VNC client:

```
xtigervncviewer -SecurityTypes VncAuth 0.0.0.0:32768
```

VNC requires a password. A default password of "abcd1234" is built into the container.

The viewer window will open, with EAGLE already running and (the first time it is run) asking for a license key. Choose "Freeware" to start using EAGLE as freeware. Or, if you have a commercial or trial key from Autodesk, you'll need to copy that key into your container.

## Persistent storage

All processes inside the container run as user 'user', with disabled password and a home directory built into the container. To use persistent storage for your EAGLE projects, use a volume mount over /home/user/eagle like this:

   ```docker run -p 32768:5901 -v /my/eagle/directory:/home/user/eagle -i nickandrew/eagle```
