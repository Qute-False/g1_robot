#!/usr/bin/env bash
set -e

docker build \
  -t g1-robot-dev:humble-gpu-v1 \
  -f docker/Dockerfile \
  --build-arg USERNAME=dev \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  .
