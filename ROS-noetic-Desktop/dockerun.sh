
#!/bin/bash

# enable access to xhost from the container
xhost +

version='noetic'

mkdir -p ~/${version}_src

if [ $1 = 'build' ]
then
    docker build -t ryrobotics/ros_noetic_desktop:mavros . -f Dockerfile.noetic
    # docker run -it --privileged --net=host \
    #     --runtime nvidia \
    #     --env=LOCAL_USER_ID="$(id -u)" \
    #     --env="DISPLAY" \
    #     --env="QT_X11_NO_MITSHM=1" \
    #     --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    #     --volume ~/noetic_src:/src/:rw \
    #     --name=noetic ryrobotics/ros_noetic_desktop:mavros bash

fi

# Run docker
if [ $1 = 'run' ]
then
    docker start nuc_px4
    docker exec -it nuc_px4 bash
elif [ $1 = 'run_other' ]
then
    docker start other
    docker exec -it other bash
fi