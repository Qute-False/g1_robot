FROM ros:humble

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# -----------------------------
# 基础工具 + ROS2 常用工具 + GUI
# -----------------------------
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    vim \
    nano \
    tmux \
    net-tools \
    iputils-ping \
    iproute2 \
    usbutils \
    sudo \
    locales \
    lsb-release \
    gnupg2 \
    software-properties-common \
    build-essential \
    cmake \
    gdb \
    x11-apps \
    mesa-utils \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    python3-argcomplete \
    ros-humble-rviz2 \
    ros-humble-rqt \
    ros-humble-rqt-common-plugins \
    ros-humble-rqt-image-view \
    ros-humble-image-transport \
    ros-humble-cv-bridge \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# locale
# -----------------------------
RUN locale-gen en_US en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# -----------------------------
# rosdep
# -----------------------------
RUN rosdep init || true
RUN rosdep update || true

# -----------------------------
# Python 常用包
# -----------------------------
RUN pip3 install --no-cache-dir \
    setuptools \
    empy \
    catkin_pkg \
    numpy \
    pyyaml

# -----------------------------
# 创建开发用户
# 构建时可传 UID/GID，避免挂载目录权限错乱
# -----------------------------
ARG USERNAME=dev
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${USERNAME} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# -----------------------------
# 工作区
# -----------------------------
WORKDIR /workspace

# 复制入口脚本
COPY docker/ros_entrypoint.sh /ros_entrypoint.sh
RUN sudo chmod +x /ros_entrypoint.sh || chmod +x /ros_entrypoint.sh

# 自动 source ROS2
RUN echo "source /opt/ros/humble/setup.bash" >> /home/${USERNAME}/.bashrc

USER ${USERNAME}

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
