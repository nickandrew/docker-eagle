#!/bin/bash
#

# Cleanup, if restarting a container
rm -f /tmp/.X1-lock

vnc4server :1
sleep 3
DISPLAY=:1 /opt/eagle-7.3.0/bin/eagle
