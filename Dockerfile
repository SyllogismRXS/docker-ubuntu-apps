ARG UBUNTU_VERSION
ARG IMAGE_NAME=ubuntu:${UBUNTU_VERSION}

FROM ${IMAGE_NAME}
MAINTAINER Kevin DeMarco
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    python3-pip \
    python3-venv \
    build-essential \
    cmake \
    ffmpeg \
    x11-apps \
    sudo \
    libfuse2 `# Start: AppImage dependencies` \
    fuse \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libgtk-3-0 \
    libsecret-1-0 `# End: AppImage dependencies` \
    && rm -rf /var/lib/apt/lists/*

# Create user
ENV USERNAME syllo
RUN adduser --disabled-password --gecos '' $USERNAME \
    && usermod --shell /bin/bash $USERNAME \
    && adduser $USERNAME sudo \
    && adduser $USERNAME dialout \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV HOME_DIR /home/${USERNAME}
USER $USERNAME

CMD ["bash"]
