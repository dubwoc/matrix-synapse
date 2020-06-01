FROM debian:stable
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN groupadd -g 6001 nasdisk
RUN useradd --create-home -g 6001 -u 6000 nastee

#--End Nas Preample--#

RUN echo "deb http://ftp.debian.org/debian buster-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y bash \
                       coturn \
                       supervisor
RUN apt-get install -t buster-backports -y matrix-synapse=1.12.4-1~bpo10+1
COPY files/etc//supervisor /etc/supervisor

# boog, why is it trying to write homeserver.log to this dir?
# why does run need to be this?
RUN chmod 4777 /etc/supervisor /run

# start supervisord
ENTRYPOINT [ "/usr/bin/supervisor" ]
