FROM ubuntu:18.04
MAINTAINER Nick Andrew <nick@nick-andrew.net>
EXPOSE 5901

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install vnc4server blackbox xterm
RUN apt-get -y install libpulse0
RUN apt-get -y install command-not-found
RUN apt-get -y install wget bzip2

RUN adduser --gecos 'User Name,,,' --disabled-password user

# Do this early, to cache the huge binary download
RUN wget -q -O /tmp/eagle.tar.gz https://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_9.4.2_English_Linux_64bit.tar.gz

# Install particular eagle dependencies
RUN apt-get -y install libnspr4 libglib2.0-0 libnss3 libasound2

RUN apt-get -y install libcups2
RUN apt-get -y install man-db
RUN mkdir -p /opt/eagle-9.4.2
RUN chown user:user /opt/eagle-9.4.2

ADD vnc-passwd-abcd1234 /home/user/.vnc/passwd
RUN chown -R user:user /home/user/.vnc
RUN chmod 700 /home/user/.vnc
RUN chmod 600 /home/user/.vnc/passwd
ADD bin /home/user/bin
RUN chown -R user:user /home/user/bin

# ------------------------------------------------------------------------
# Everything under here, run as user 'user'
# ------------------------------------------------------------------------

USER user
WORKDIR /opt

RUN tar zxpf /tmp/eagle.tar.gz
RUN mkdir /home/user/eagle

WORKDIR /home/user
CMD /opt/eagle-9.4.2/eagle

USER root
RUN rm /tmp/eagle.tar.gz
