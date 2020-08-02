#!/bin/bash
#

# Cleanup, if restarting a container
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

tigervncserver -localhost no :1
sleep 3
DISPLAY=:1 /opt/eagle-9.6.2/eagle
