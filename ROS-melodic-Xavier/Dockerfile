FROM arm64v8/ros:melodic-robot-bionic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop \
    && rm -rf /var/lib/apt/lists/*

# install mavros
RUN apt-get install -y --no-install-recommends \
    ros-melodic-mavros ros-melodic-mavros-extras ros-melodic-mavros-msgs wget \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh \
    && chmod a+x install_geographiclib_datasets.sh \
    && ./install_geographiclib_datasets.sh
