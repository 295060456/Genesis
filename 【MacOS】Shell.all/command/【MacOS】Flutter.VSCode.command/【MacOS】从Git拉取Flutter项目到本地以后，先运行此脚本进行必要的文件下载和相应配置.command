#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/android

flutter doctor -v
fvm flutter --version
fvm flutter pub get
flutter precache
