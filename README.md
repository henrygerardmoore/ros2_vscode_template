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
git clone git@github.com:moveit/moveit.git
cd ..
```

Then, `cd` into that folder and run the `build_and_set_up.bash` script:
```bash
./.vscode/build_and_set_up.bash
```

Finally, attach to the docker container with vscode:
![image](https://github.com/henrygerardmoore/ros2_vscode_template/assets/44307180/ae93aba0-6360-4f66-8604-b03fbafde3b5)
