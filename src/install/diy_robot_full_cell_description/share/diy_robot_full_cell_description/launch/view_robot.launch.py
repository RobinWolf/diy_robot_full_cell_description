from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare


def generate_launch_description():
    description_package = "diy_robot_full_cell_description"
    description_file = "cell_model.urdf.xacro"

    base_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(
            [PathJoinSubstitution([FindPackageShare('diy_robotarm_wer24_description'), 'launch']), "/visualize.launch.py"]),
        launch_arguments={
            "description_package": description_package,
            "description_file": description_file,
        }.items(),
    )

    nodes_to_start = [
        base_launch,
    ]

    return LaunchDescription(nodes_to_start)
