# Using ROS 2 Rolling in Docker with VSCode

## Prerequisites

Install [docker](https://docs.docker.com/engine/install/) and [docker compose](https://docs.docker.com/compose/install/).

## Setup

Clone this repo into your preferred workspace name and `cd` into it:
```bash
git clone git@github.com:henrygerardmoore/ros2_vscode_template.git ros2_workspace
cd ros2_workspace
```

Then, clone whichever ROS 2 repo you like into `src`:
```bash
git -C src/ clone git@github.com:moveit/moveit2.git
```

If necessary, you can set up your repo's source dependencies with `vcstool`, for example:
```bash
vcs import --input src/moveit2/moveit2.repos src
```

Next, export the requisite environment variables. For example, I use the following:

```bash
export COLCON_WS=~/ros2_workspace # path to the current folder, highly recommended
export GPG_DIR=~/.gnupg # if you want to use gpg in your container to sign your commits
export ROS_DOMAIN_ID=44 # see https://docs.ros.org/en/rolling/Concepts/Intermediate/About-Domain-ID.html
```

Then, run the `build_and_set_up.bash` script (optionally including a container name, which defaults to `ros2_rolling_ws`):
```bash
CONTAINER_NAME=example_workspace ./src/.vscode/build_and_set_up.bash
```

Then, attach to the created docker container with vscode:
![image](https://github.com/henrygerardmoore/ros2_vscode_template/assets/44307180/ae93aba0-6360-4f66-8604-b03fbafde3b5)

Then, open the `src` folder (which will be located in `/home/ubuntu/overlay_ws/src`) in vscode to utilize this repository's built-in tasks.

Once you have opened the `src` folder, use the `update` task before trying to build, as it will install necessary dependencies.

If you want, you can then remove this repo's `.git` folder to make your workspace's root no longer a git repo, along with other extraneous things:

```bash
rm -rf .git
rm .gitignore
rm README.md
```

## Using VSCode tasks

This repository includes a template `.vscode` directory with the tasks you will need to build your code (in both release and debug mode) and use `clangd`.
You can use `ctrl`+`shift`+`B` to see the tasks available.
See [here](https://github.com/kineticsystem/vscode_ros2) for further information and tips on using VSCode with ROS 2.

## Using Git

This container should be set up to use your normal git configuration, optionally including GPG for signing commits.

# Contributions

If you notice a mistake or opportunity for improvement, feel free to open an issue or a PR :)
