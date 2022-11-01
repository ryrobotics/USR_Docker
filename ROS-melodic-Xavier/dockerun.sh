
#!/bin/bash

# enable access to xhost from the container
xhost +

docker_name='latest'

if [ $1 = 'build' ]
then
    docker build -t ryrobotics/ros_melodic_l4t:${docker_name} . -f Dockerfile.l4t
fi

# Run docker
if [ $1 = 'run' ]
then
    docker run -it --privileged --net=host \
        --runtime=nvidia \
        --env=LOCAL_USER_ID="$(id -u)" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume ~/src:/src/:rw \
        --restart=always \
        --name=nx_${docker_name} ryrobotics/ros_melodic_l4t:latest bash
fi