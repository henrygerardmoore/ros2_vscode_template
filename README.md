# Using VSCode with ROS2 Rolling
Clone the repo into your preferred workspace name and `cd` into it:
```bash
git clone git@github.com:henrygerardmoore/ros2_vscode_template.git ros2_workspace
cd ros2_workspace
```

Then, clone whichever ros2 repo you like into `src`:
```bash
mkdir src
cd src
git clone git@github.com:moveit/moveit2.git
cd ..
```

If necessary, you can set up your repo's dependencies with `vcstool`, for example:
```bash
vcs import --input src/moveit2/moveit2.repos src
```

Next, export the requisite environment variables. For example, I use the following:

```bash
export COLCON_WS=~/ros2_workspace # path to the current folder, highly recommended
export GPG_DIR=~/.gnupg # if you want to use gpg in your container to sign your commits
export ROS_DOMAIN_ID=44 # see https://docs.ros.org/en/rolling/Concepts/Intermediate/About-Domain-ID.html
```

Then, run the `build_and_set_up.bash` script:
```bash
./.vscode/build_and_set_up.bash
```

Finally, attach to the created docker container with vscode:
![image](https://github.com/henrygerardmoore/ros2_vscode_template/assets/44307180/ae93aba0-6360-4f66-8604-b03fbafde3b5)

If you want, you can then remove the `.git` folder to make your workspace no longer a git repo and remove other extraneous things:
```bash
rm -rf .git
rm .gitignore
rm README.md
```

# Using the tasks

This repository includes a template `.vscode` directory with the tasks you will need to build your code (in both release and debug mode) and use `clangd`.
You can use `ctrl`+`shift`+`B` to see the tasks available.
See [here](https://github.com/kineticsystem/vscode_ros2) for further information and tips on using VSCode with ROS2.

# Contributions

If you notice a mistake or opportunity for improvement, feel free to open an issue or a PR :)