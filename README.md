# g1_robot
This project uses the unitree G1 EDU U2 robot and develops robot gait through ROS2 to achieve actions such as uphill climbing, crawling and obstacle crossing

G1 机器人项目代码仓库。

## 目录说明
- `src/`: ROS2 功能包
- `docker/`: Docker 环境
- `scripts/`: 常用脚本
- `docs/`: 开发规范与实机流程

## 环境初始化

```bash
cd ~/g1_robot
bash scripts/setup_deps.sh
编译
cd ~/g1_robot
colcon build --symlink-install
source install/setup.bash
