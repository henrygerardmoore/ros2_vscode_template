FROM osrf/ros:rolling-desktop-full

RUN apt-get update && apt-get install -y --no-install-recommends \
      gnupg=2.4.4-2ubuntu17 \
      lsb-release=12.0-2 \
      wget=1.21.4-1ubuntu4 && \
    rm -rf /var/lib/apt/lists/*
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install other development packages
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
      bash-completion \
      ccache \
      clang-format \
      gdb \
      git-lfs \
      python3-pip \
      sudo && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install pre-commit --break-system-packages --no-cache-dir

# make sure all packages from the base image are up-to-date with the packages installed in this Dockerfile
RUN apt-get -qq update && apt-get -qq -y upgrade && \
    rm -rf /var/lib/apt/lists/*

# add a non-root user
# (https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user)
ENV USER=ubuntu
ARG UID=1000
ARG GID=$UID
RUN echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER
USER $USER

# setup colcon mixin and metadata
WORKDIR /home/dev
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update
# the `colcon mixin` and `colcon metadata` commands leave a `log` folder in the WORKDIR which isn't needed
RUN rm -rf log

# define the colcon defaults.yaml file so that users can run `colcon build` without having to pass any additional arguments
COPY ./.colcon/defaults.yaml /home/$USER/.colcon/defaults.yaml

# the base image runs `rosdep init`, but also runs `rosdep update` as root. We have to run `rosdep update`
# again as the non-root user to set up rosdep for the non-root user
RUN rosdep update

# setup bash completion for colcon and vcstool
RUN echo "source /usr/share/vcstool-completion/vcs.bash" >> ~/.bashrc

# this is a workaround to the base image's entrypoint that sources ros (see https://github.com/osrf/docker_images/issues/114)
RUN echo 'source "/opt/ros/rolling/setup.bash"' >> ~/.bashrc \
    && echo "export AMENT_CPPCHECK_ALLOW_SLOW_VERSIONS=1" >> ~/.bashrc

# workaround for the following pre-commit error (the real fix is to use a version of cppcheck > 2.7):
#   cppcheck 2.7 has known performance issues and therefore will not be used, set the AMENT_CPPCHECK_ALLOW_SLOW_VERSIONS environment variable to override this.
ENV AMENT_CPPCHECK_ALLOW_SLOW_VERSIONS=1

# define where the user's colcon workspace will be mounted to inside the container
# (see the COLCON_WS volume in docker-compose.yaml)
ENV COLCON_WS="/home/ubuntu/overlay_ws"
# make the workspace the default directory when entering the container
WORKDIR $COLCON_WS

RUN echo "alias colcon_cd='cd ${COLCON_WS}'" >> ~/.bashrc

COPY ./entrypoint.sh /
ENV SHELL=/bin/bash
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
