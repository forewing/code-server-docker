# Docker image for code-server

This image is based on [code-server](https://github.com/cdr/code-server).

## Using docker-compose

- Make sure the volume is granted user of UID 1000 with read/write permission.

- Set password in environment, or you should check `${VOLUME}/.config/code-server/config.yml` for the auto-generated password.
