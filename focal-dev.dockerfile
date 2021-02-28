# Usage:
#     $ docker build -f focal-dev.dockerfile -t focal-dev --build-arg UID=$(id -u) .
#     $ docker run -it --mount type=bind,source="$(pwd)",target=/home/focal/work focal-dev:latest

FROM ubuntu:focal

ARG USER_NAME=focal
ARG USER_PASSWORD=focal
ARG UID=1000

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	vim.tiny sudo \
	build-essential autoconf pkg-config libtool

# Create an user
RUN useradd -m -u ${UID} ${USER_NAME} && \
    echo ${USER_NAME}:${USER_PASSWORD} | chpasswd

RUN usermod -aG sudo ${USER_NAME}

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}/work
