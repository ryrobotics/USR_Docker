
#!/bin/bash

# enable access to xhost from the container
xhost +

if [ $1 = 'build' ]
then
    docker build -t ray0117/ros_melodic_l4t:mavros . -f Dockerfile.l4t
    docker run -it --privileged --net=host \
         --runtime=nvidia \
        --env=LOCAL_USER_ID="$(id -u)" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume ~/src:/src/:rw \
        --restart=always \
        --name=nx_mavros ray0117/ros_melodic_l4t:mavros bash

elif [ $1 = 'build_arm64' ]
then
    docker build -t ray0117/ros_mavros_xaviernx:latest . -f Dockerfile.arm64v8
    docker run -it --privileged --net=host \
        --env=LOCAL_USER_ID="$(id -u)" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume ~/src:/src/:rw \
        --restart=always \
        --name=nx_mavros ray0117/ros_mavros_xaviernx:latest bash
fi

# Run docker
if [ $1 = 'run' ]
then
    docker start nx_mavros
    docker exec -it nx_mavros bash
elif [ $1 = 'run_other' ]
then
    docker start other
    docker exec -it other bash
fi