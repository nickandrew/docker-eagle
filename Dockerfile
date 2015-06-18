FROM ubuntu:14.04.2
MAINTAINER Nick Andrew <nick@nick-andrew.net>
EXPOSE 5901

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install vnc4server blackbox xterm
RUN apt-get -y install libpulse0
RUN apt-get -y install command-not-found
RUN apt-get -y install wget

RUN adduser --gecos 'User Name,,,' --disabled-password user

RUN apt-get -y install libcups2
RUN apt-get -y install man-db
RUN mkdir -p /opt/eagle-7.3.0
RUN chown user:user /opt/eagle-7.3.0

# ------------------------------------------------------------------------
# Everything under here, run as user 'user'
# ------------------------------------------------------------------------

USER user
WORKDIR /home/user

RUN wget -q -O eagle-lin64-7.3.0.run http://web.cadsoft.de/ftp/eagle/program/7.3/eagle-lin64-7.3.0.run
RUN chmod 755 eagle-lin64-7.3.0.run
RUN ./eagle-lin64-7.3.0.run /opt
ADD bin /home/user/bin
# COPY eagle-freeware.key /opt/eagle-7.3.0/bin/eagle.key
# RUN chown 507:200 /opt/eagle-7.3.0/bin/eagle.key

CMD /home/user/bin/start.sh
