#!/bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/ios

# 检查有没有Podfile.lock
if [ -f Podfile.lock ]; then
    rm Podfile.lock
fi

# 清除本地缓存的所有 Pod
pod cache clean --all
# 只更新本地库
pod repo update
# 安装库到项目
pod install
