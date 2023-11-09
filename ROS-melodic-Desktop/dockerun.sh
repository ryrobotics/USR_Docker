
#!/bin/bash

# enable access to xhost from the container
xhost +

if [ $1 = 'build' ]
then
    docker build -t ryrobotics/ros_melodic_nuc:mavros . -f Dockerfile.nuc
    docker run -it --privileged --net=host \
        --env=LOCAL_USER_ID="$(id -u)" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume ~/melodic_src:/src/:rw \
        --volume ~/Public/gazebo_models:/root/.gazebo/models/:ro \
        --restart=always \
        --name=nuc_px4 ryrobotics/ros_melodic_nuc:mavros bash

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