FROM ubuntu:23.10
MAINTAINER Nick Andrew <nick@nick-andrew.net>
EXPOSE 5901

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install tigervnc-standalone-server blackbox xterm
RUN apt-get -y install libpulse0
RUN apt-get -y install command-not-found
RUN apt-get -y install wget bzip2

RUN adduser --gecos 'User Name,,,' --disabled-password user

# A timezone needs to be set before tzdata is installed.
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get -y install locales
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN /usr/sbin/locale-gen

# Install particular eagle dependencies
RUN apt-get -y install libnspr4 libglib2.0-0 libnss3 libasound2

RUN apt-get -y install libcups2
RUN apt-get -y install man-db

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

ADD Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz /opt

RUN ls -l /tmp
RUN mkdir /home/user/eagle

WORKDIR /home/user
CMD /home/user/bin/start.sh
