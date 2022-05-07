# USAGE

## How to build container

sudo docker build -t <container_name>

## How to run build container

### General Info

You have to mount your yocto directory to the /workdir directory of the build container. 
This is achieved by adding -v <path>/<to>/<yocto>:/workdir to the docker run command.

Also two optional arguments can be passed to the container:

- BUILD
- RECIPE

### Standard run command

sudo docker run -v ~/src/yocto:/workdir/yocto test