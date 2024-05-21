#!/bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/ios

# 检查有没有Podfile.lock
if [ -f Podfile.lock ]; then
    rm Podfile.lock
fi

pod cache clean --all
pod install --repo-update
pod repo update
pod install
