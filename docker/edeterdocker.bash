#!/bin/bash

# ===================== 用户配置区域 =====================
# 请根据实际情况修改以下路径和名称
LOCAL_CODE_DIR="/home/yzy/edeter/EDTER"     # 本地代码目录绝对路径
# LOCAL_DATA_DIR="/本地/数据集路径"    # 本地数据集目录绝对路径
IMAGE_NAME="cuda11edter"        # Docker镜像名称
# PORT_MAP="6006:6006"                # 端口映射 (不需要可设为空)
# ======================================================

# 检查目录是否存在
check_dir() {
  if [ ! -d "$1" ]; then
    echo "错误：目录不存在 $1"
    echo "请执行以下命令创建目录："
    echo "sudo mkdir -p $1 && sudo chown $USER $1"
    exit 1
  fi
}

# 主启动命令
start_container() {
  docker run -itd \
    --name cuda11edter \
    --gpus all \
    --shm-size=16G \
    -v "${LOCAL_CODE_DIR}:/mmsegmentation" \
    ${PORT_MAP:+-p $PORT_MAP} \
    $IMAGE_NAME \
    tail -f /dev/null

  echo "==========================================="
  echo "容器已启动，使用以下命令进入容器："
  echo "docker exec -it cuda11edter bash"
}

# 预检查
check_dir "$LOCAL_CODE_DIR"
# check_dir "$LOCAL_DATA_DIR"

# 执行启动
start_container

