#!/bin/sh
xhost +
XSOCK=/tmp/.X11-unix
# XAUTH=/tmp/.docker.xauth
# sudo touch $XAUTH
# sudo xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker_name='vins'

docker run --privileged  -it --net=host \
           --gpus all \
           --runtime=nvidia \
           --volume ~/ego_src:/home/usr/src:rw \
           --volume=$XSOCK:$XSOCK:rw \
           --volume=/dev:/dev:rw \
           --shm-size=1gb \
           --env="XAUTHORITY=${XAUTH}" \
           --env="DISPLAY=${DISPLAY}" \
           --env=TERM=xterm-256color \
           --env="QT_X11_NO_MITSHM=1" \
           --name=nx_${docker_name} ryrobotics/ros_melodic_l4t:${docker_name} bash