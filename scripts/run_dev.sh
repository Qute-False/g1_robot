#!/usr/bin/env bash
set -e

xhost +local:docker

docker run -itd \
  --name g1-dev-$USER \
  --network host \
  --ipc host \
  --privileged \
  --gpus all \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -v $(pwd):/workspace \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /dev:/dev \
  -w /workspace \
  g1-robot-dev:humble-gpu-v1
