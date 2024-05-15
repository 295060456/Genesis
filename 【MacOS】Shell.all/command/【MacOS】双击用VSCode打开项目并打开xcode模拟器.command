#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory
# 打开xcode模拟器
open -a Simulator
# 打开VSCode
code .
