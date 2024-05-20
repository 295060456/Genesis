#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory
# 执行项目清理
flutter clean
# 重新下载依赖包
flutter pub get
