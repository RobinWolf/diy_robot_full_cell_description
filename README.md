# diy_robot_full_cell_description


## thematical Classification

This repo contains a ros2 package which describes the full cell setup of our diy-robot secene.
The scene will include descriptions of the Base (Table, Box, ...), the 6-Axis Robotarm (https://github.com/RobinWolf/diy_robotarm_wer24_description) and the Parallel-Gripper . in our case with mounted soft-fingers (https://github.com/RobinWolf/diy_soft_gripper_describtion).

We use Docker for development (dev branch) and deployment (main branch) to avoid version and dependencies issues.
While building the container the depencencie-reops for the robotarm and gripper are cloned from GitHub and setup automated.
To run the package, you just have to source the run.sh script file. The container will start and you can work with the provided package, modify it or include it as an dependencie to another packages!

The main idea is, that this repo can be cloned inside a docker-container containing and combining all packages for operationg the Robot (e.g. description, drivers, moveit2, applivation) Using differnet docker containers is very likely, because this makes the whole integration very modular.

Refer to the main Readme.md [https://github.com/mathias31415/diy_robotics/blob/main/ROS-Packages/ROS-OVERVIEW.md](https://github.com/mathias31415/diy_robotics/blob/main/ROS-Packages/README.md) for a general overview.

![cell_classification](images/cell_classification.png)

## Package Structure

![cell_file_tree](images/cell_file_tree.png)

 - images and README.md are only for docomentation purposes
 - Dockerfile, run.sh and dds_profile.xml are used to create the docker container where ROS is running in
 - CMakeLists.txt and package.xml are defining this build process (wich dependencies are needed, which file should be installed where in the created directories, ...)
 - meshes, rviz, urdf, config and launch are the directories which are containing the source files for this package, they will be described in the following


## URDF Definition

For this URDF definition we use the ROS xacro extention to ensure clear structures and the best modularity.

The graphics below show how the whole cell is assembled from sub-description packages diy_robotarm_wer24_description (https://github.com/RobinWolf/diy_robotarm_wer24_description/tree/main) and diy_soft_gripper_description (https://github.com/RobinWolf/diy_soft_gripper_description).
In addition to the xacro sub-urdf definitions we have implemented the usage of several confuguration files in the "config" directory. These refer to the ````diy_robotarm_macro.urdf.xacro````.

![cell_urdf_structure](images/cell_urdf_structure.png)

As you see the main urdf for the cell is located inside of this package (grey). It calls the xacro macros from the sub-definitions for the arm and the gripper. These packages are cloned from GitHub while building the container to a seperate dependencies-workspace inside of the container. Because these packages are built and sourced while building too, you can directoy acess the files inside there from the new diy_robot_full_cell package.

The whole scene was build up from the parts subframe, arm and gripper. To aviod namespace collisions (especially for the ````materials.urdf.xacro````) it's highly recommendet to use different tf_prefixes! In our implementation there are 4 different tf_prefixes with the following default values:

- tf_prefix = "" --> for possible multiple-robot cells
- sub_tf_prefix = "sub_" --> for the subframe
- arm_tf_prefix = "arm_" --> for the 6axis arm
- grip_tf_prefix = "grip_" --> for the gripper

To connect the different macros you just have to set the "parents" parameter right (see red highlited font). In our case we linked the subframe to the world, the arm base to the subframe and the gripper base to link6/ flange of the arm.

We kept the geometry of the subframe very simple. We defined a subframe geometry that the robot can't reach regions below Z-world = 0, because in that case the real subframe geometry doesn't matters. You just can bolt the robot on a wooden plate or something else flat. But feel free to adapt our subframe geometry to yours by changing the ````/meshes/placeholder.stl````with your CAD-model.



## Launch

By running the launch file ````visualization.launch.py```` automatically when you start the docker container by sourcing the run script ````./run.sh```` you will launch Rviz and the Joint State Publisher GUI. This is only for visualization and checking purposes, because we don't do a real bringup of the robot model. Joint States are just published by the GUI on the specific ROS-topic.

Now the whole description of our ROS-integration is finished. In refer to the main repo, we finished **Part 1** at this stage. 

Now you should be able to move the robot arm around in Rviz by sliding the bars of the Joint State Publisher GUI. You can not actuate the gripper or a real robot in this development stage, therefore you need the drivers to run. Tehese we will implement in the further stages. If you are also interested in this, please switch to the following repos for the gripper (https://github.com/RobinWolf/diy_soft_gripper_driver) and the robot arm (https://github.com/RobinWolf/diy_robotarm_wer24_driver).
