# Docker-TransHeadCouchRage
This is a user centric container with Transmission, Headphones, CouchPotato, and SickRage for Docker. When a user executes "install.sh" it automaticaly creates the mapped volumes in their home directory, assigns unused ports to the container, and runs the container proccess using their UID and GID giving them full ownership of any files created by the container process. Best of all it supports multiple isolated users!

This is still a "very alpha" release. Please check back for the finished project.

Persistent user directories:

~/.thcr

~/downloads

~/fetch

## Requirements
- Debian/Ubuntu base OS (other flavors untested yet)

- Docker v1.6

- Installing user must be in "docker" group

## Install
Clone the project
> git clone https://github.com/Ohge/docker-sickrage.git

Execute the build script
> ./install.sh

## Uninstall
> ./uninstall.sh

## Usage
Open your browser to start using the SickRage webGUI
> http://host:port


## Future Releases
- Add PLEX and Samba support

- Add VLC/FFMPEG streaming solution

- Add htaccess control app
