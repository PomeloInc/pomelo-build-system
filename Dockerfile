# Copyright 2022, Benedikt Humml

# Use Ubuntu 20.04 LTS
FROM ubuntu:20.04

# Use bash as default shell
SHELL ["/bin/sh", "-c"]

# Install maybe (see. https://docs.yoctoproject.org/3.2.3/ref-manual/ref-system-requirements.html#required-packages-for-the-build-host)
# RUN apt-get build-dep qemu
# RUN apt-get remove oss4-dev

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

# Install software required by the Yocto Project 
RUN apt-get -y install gawk wget git-core diffstat unzip texinfo \
    gcc-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm python3-subunit mesa-common-dev
RUN apt-get install -y locales

# Set locale
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install build script
USER root
COPY ./build_script.sh /usr/local/bin/
RUN ls
RUN ls /usr/local/bin/
RUN chmod -R 777 /usr/local/bin/build_script.sh

# set project specific stuff
# ENV PROJECT bbb
# ENV TYPE core-image-minimal

# set user
ENV USER_NAME pomelo
RUN useradd $USER_NAME
USER $USER_NAME

# # Needed?
# ARG host_uid=1001
# ARG host_gid=1001
# RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

ENTRYPOINT ["build_script.sh"]

# Clone repository
# WORKDIR /home/$USER_NAME
# RUN git clone --recurse-submodules https://github.com/pomelo/yocto.git
# ENV REPO_DIR /home/$USER_NAME/yocto
# ENV BUILD_OUTPUT_DIR /home/$USER_NAME/yocto/$PROJECT/tmp/deploy

# Prepareenvironment.
# WORKDIR $REPO_DIR
# CMD git pull --recurse-submodules
# CMD source poky/oe-init-build-env board/bbb && git pull && bitbake core-image-minimal
# CMD tail -f /dev/null
