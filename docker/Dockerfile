FROM osrf/ros:humble-desktop

# 换Ubuntu源
RUN sed -i 's|http://archive.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list \
 && sed -i 's|http://security.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

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
    ros-humble-image-transport \
    ros-humble-cv-bridge \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN rosdep init || true
RUN rosdep update || true

RUN pip3 install --no-cache-dir \
    setuptools \
    empy \
    catkin_pkg \
    numpy \
    pyyaml

ARG USERNAME=dev
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${USERNAME} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /workspace

COPY docker/ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh

RUN echo "source /opt/ros/humble/setup.bash" >> /home/${USERNAME}/.bashrc

USER ${USERNAME}

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
