#!/usr/bin/env bash
set -e

CONTAINER_NAME="g1-dev-$USER"
IMAGE_NAME="g1-robot-dev:humble-gpu-v1"

DOCKER_ARGS=(
  -itd
  --name "$CONTAINER_NAME"
  --network host
  --ipc host
  --privileged
  --gpus all
#  --user $(id -u):$(id -g) \
  -e NVIDIA_VISIBLE_DEVICES=all
  -e NVIDIA_DRIVER_CAPABILITIES=all
  -v "$(pwd):/workspace"
  -v /dev:/dev
  -w /workspace
)

# 只有宿主机存在图形环境时，才挂载 X11
if [ -n "$DISPLAY" ] && [ -d /tmp/.X11-unix ]; then
  echo "[INFO] DISPLAY=$DISPLAY, enabling X11 forwarding"
  xhost +local:docker
  DOCKER_ARGS+=(
    -e DISPLAY="$DISPLAY"
    -e QT_X11_NO_MITSHM=1
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw
  )
else
  echo "[WARN] No DISPLAY detected, starting container in headless mode"
fi

# 若已存在同名容器，先删除
if docker ps -a --format '{{.Names}}' | grep -qx "$CONTAINER_NAME"; then
  echo "[INFO] Removing existing container: $CONTAINER_NAME"
  docker rm -f "$CONTAINER_NAME"
fi

docker run "${DOCKER_ARGS[@]}" "$IMAGE_NAME"

echo "[INFO] Container started: $CONTAINER_NAME"
echo "[INFO] Enter with: docker exec -it $CONTAINER_NAME bash"
