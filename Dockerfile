FROM ubuntu:16.04
MAINTAINER Nick Andrew <nick@nick-andrew.net>
EXPOSE 5901

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install vnc4server blackbox xterm
RUN apt-get -y install libpulse0
RUN apt-get -y install command-not-found
RUN apt-get -y install wget bzip2

RUN adduser --gecos 'User Name,,,' --disabled-password user

RUN apt-get -y install libcups2
RUN apt-get -y install man-db
RUN mkdir -p /opt/eagle-8.6.0
RUN chown user:user /opt/eagle-8.6.0

ADD vnc-passwd-abcd1234 /home/user/.vnc/passwd
RUN chown -R user:user /home/user/.vnc
RUN chmod 700 /home/user/.vnc
RUN chmod 600 /home/user/.vnc/passwd

# ------------------------------------------------------------------------
# Everything under here, run as user 'user'
# ------------------------------------------------------------------------

USER user
WORKDIR /opt

RUN wget -q -O eagle.tar.gz https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_8.6.0_English_Linux_64bit.tar.gz && tar zxf eagle.tar.gz && rm eagle.tar.gz

ADD bin /home/user/bin
RUN mkdir /home/user/eagle

WORKDIR /home/user
CMD /home/user/bin/start.sh
