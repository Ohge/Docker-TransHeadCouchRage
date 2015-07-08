FROM debian:jessie
MAINTAINER Ohge <https://github.com/Ohge>

### INSTALL DEPENDENCIES
RUN set -xe &&\
    apt-get update &&\
    apt-get install -y git-core python python-cheetah software-properties-common nginx &&\
    add-apt-repository -y ppa:nginx/stable

### INSTALL TRANSMISSION
RUN apt-get install -y transmission-daemon

### INSTALL HEADPHONES
RUN cd /opt &&\
    git clone https://github.com/rembo10/headphones.git

### INSTALL COUCHPOTATO
RUN cd /opt &&\
    git clone https://github.com/RuudBurger/CouchPotatoServer.git

### INSTALL SICKRAGE
RUN cd /opt &&\
    git clone https://github.com/echel0n/SickRage.git &&\
    cp /opt/SickRage/autoProcessTV/autoProcessTV.cfg.sample /opt/SickRage/autoProcessTV/autoProcessTV.cfg

### CLEAN UP CONTAINER
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### CREATE PERSISTENT VOLUMES
VOLUME ["/etc/thcr"]
VOLUME ["/downloads"]
VOLUME ["/fetch"]

### EXPOSE PORTS
EXPOSE 80
EXPOSE 443
EXPOSE 54321
EXPOSE 54321/udp

### RUN SCRIPT
CMD ["/etc/thcr/.boot"]
