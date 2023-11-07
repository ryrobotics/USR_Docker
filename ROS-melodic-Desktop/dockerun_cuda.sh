
#!/bin/bash

# enable access to xhost from the container
xhost +

if [ $1 = 'build' ]
then
    docker build -t ryrobotics/ros_melodic_cuda:base . -f Dockerfile.CUDA
fi

# Run docker
if [ $1 = 'run' ]
then
    docker run -it --privileged --net=host \
        --runtime nvidia \
        --env=LOCAL_USER_ID="$(id -u)" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume ~/melodic_src:/src/:rw \
        --restart=always \
        --name=px4_cuda ryrobotics/ros_melodic_cuda:base bash
fi