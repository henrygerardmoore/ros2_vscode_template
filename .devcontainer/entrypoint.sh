#!/bin/bash
set -e

if [[ -d "${COLCON_WS}/src" ]]
then
  echo -e "Installing all remaining dependencies from the workspace...\n"
  sudo apt -qq update && rosdep install --ignore-src --from-paths src -y -r
  echo -e "\nDone installing the remaining dependencies from the workspace.\n"
else
  echo "No src directory was detected in the workspace.."
fi

echo "When you are ready to build the workspace, run:"
echo -e "\tcd ${COLCON_WS} && colcon build\n"

exec "$@"
