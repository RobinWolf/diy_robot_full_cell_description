# diy_robot_ful_cell_description

This repo contains a ros2 package which describes the full cell setup of our diy-robot secene.
The scene will include descriptions of the Base (Table, Box, ...), the 6-Axis Robotarm (https://github.com/RobinWolf/diy_robotarm_wer24_description) and the Parallel-Gripper . in our case with mounted soft-fingers (https://github.com/RobinWolf/diy_soft_gripper_describtion).

We use Docker for development (dev branch) and deployment (main branch) to avoid version and dependencies issues.
While building the container the depencencie-reops for the robotarm and gripper are cloned from GitHub and setup automated.
To run the package, you just have to source the run.sh script file. The container will start and you can work with the provided package, modify it or include it as an dependencie to another packages!
