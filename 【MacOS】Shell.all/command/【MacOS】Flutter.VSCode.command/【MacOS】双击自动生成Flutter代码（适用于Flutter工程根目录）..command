#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory/android

# 提示用户是否执行 flutter packages upgrade, flutter clean, flutter pub get --no-example
echo "是否执行 flutter packages upgrade, flutter clean, flutter pub get --no-example? (按任意键执行，直接回车跳过)"
read -r user_input

if [ -n "$user_input" ]; then
  flutter packages upgrade
  flutter clean
  flutter pub get --no-example
else
  echo "跳过执行 flutter packages upgrade, flutter clean, flutter pub get --no-example"
fi

# 继续执行其他命令
flutter pub run build_runner build
