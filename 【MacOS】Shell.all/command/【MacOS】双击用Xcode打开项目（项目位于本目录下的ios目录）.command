#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/ios
# 用打开xcode打开项目中关于iOS的部分
open -a Xcode $current_directory/ios/Runner.xcworkspace

