#!/bin/bash
#

# Cleanup, if restarting a container
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

vnc4server :1
sleep 3
DISPLAY=:1 /opt/eagle-7.6.0/bin/eagle
