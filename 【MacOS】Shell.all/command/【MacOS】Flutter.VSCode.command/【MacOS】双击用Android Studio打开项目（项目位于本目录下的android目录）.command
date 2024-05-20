#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/android

# 打开Android Studio
open -a "Android Studio" $current_directory/android
