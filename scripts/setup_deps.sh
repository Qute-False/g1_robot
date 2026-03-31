#!/usr/bin/env bash
set -e

echo "===== Setup G1 Robot Dependencies ====="

# 获取仓库根目录
ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SRC_DIR=$ROOT_DIR/src

mkdir -p $SRC_DIR
cd $SRC_DIR

# ===== unitree_ros2 =====
if [ ! -d "unitree_ros2" ]; then
    echo "[INFO] Cloning unitree_ros2..."
    git clone https://bgithub.xyz/unitreerobotics/unitree_ros2.git
else
    echo "[INFO] unitree_ros2 already exists"
fi

# 固定版本（建议锁 commit，避免以后炸）
#cd unitree_ros2
#git checkout main
# 👉 推荐你换成具体 commit，例如：
# git checkout xxxxxxx
#cd ..

# ===== unitree_sdk2 =====
if [ ! -d "unitree_sdk2" ]; then
    echo "[INFO] Cloning unitree_sdk2..."
    git clone https://bgithub.xyz/unitreerobotics/unitree_sdk2.git
else
    echo "[INFO] unitree_sdk2 already exists"
fi

#cd unitree_sdk2
#git checkout main
#cd ..

echo "===== Dependencies setup complete ====="
