#!/bin/bash
##############################################################################
##                   Build the image, using dev.Dockerfile                  ##
##############################################################################
ROS_DISTRO=humble

uid=$(eval "id -u")
gid=$(eval "id -g")

#pass some arguments and settings to the dev.Dockerfile while building the image (dev.Dockerfile)
#name of the image builded here: utomaton-dev/ros-render:"ROS-Distribution eg humble"
#dont use cached data to clone up-to date repos all the time
docker build \
  --no-cache \
  --build-arg ROS_DISTRO="$ROS_DISTRO" \
  --build-arg UID="$uid" \
  --build-arg GID="$gid" \
  -f Dockerfile \
  -t automaton-dev/ros-render:"$ROS_DISTRO" .

##############################################################################
##                            Run the container                             ##
##############################################################################
SRC_CONTAINER=/home/hephaestus/ros2_ws/src

docker run \
  --name robot_cell \
  --rm \
  -it \
  --net=host \
  -e DISPLAY="$DISPLAY" \
  automaton-dev/ros-render:"$ROS_DISTRO"

# display and network access is already passed to the container