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
WORKDIR /home/user

RUN wget -q -O eagle-lin64-7.3.0.run http://web.cadsoft.de/ftp/eagle/program/7.3/eagle-lin64-7.3.0.run
RUN chmod 755 eagle-lin64-7.3.0.run
RUN ./eagle-lin64-7.3.0.run /opt
RUN rm eagle-lin64-7.3.0.run
RUN mkdir /home/user/eagle

CMD /home/user/bin/start.sh
