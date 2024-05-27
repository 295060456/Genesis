#!/bin/bash

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo "\033[31m当前文件路径为：\033[0m $current_directory/ios"
cd $current_directory/ios
# cd $current_directory

# 检查是否存在Podfile文件
if [ -f "$current_directory/Podfile" ]; then
  echo "Podfile exists. Proceeding with pod install..."
  # 在新的终端中运行pod install命令
  osascript -e "tell application \"Terminal\" to do script \"cd '$current_directory' && pod install\""
else
  echo "Podfile not found. Aborting pod install."
fi
