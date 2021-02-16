# Usage:
#     $ docker build -f bullseye-dev.dockerfile -t bullseye-dev --build-arg UID=$(id -u) .
#     $ docker run -it --mount type=bind,source="$(pwd)",target=/home/bullseye/work bullseye-dev:latest

FROM debian:bullseye

ARG USER_NAME=bullseye
ARG USER_PASSWORD=bullseye
ARG UID=1000

RUN dpkg --add-architecture armhf
RUN apt-get update && apt-get install -y \
	vim.tiny sudo \
	build-essential autoconf pkg-config libtool \
	crossbuild-essential-armhf

# Create an user
RUN useradd -m -u ${UID} ${USER_NAME} && \
    echo ${USER_NAME}:${USER_PASSWORD} | chpasswd

RUN usermod -aG sudo ${USER_NAME}

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}/work
