#! /bin/sh

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory
cd $current_directory

# 关闭所有iOS模拟器
xcrun simctl shutdown all
# 检查是否有iOS模拟器进程存在(存在即杀进程)
if pgrep -f 'Simulator' >/dev/null; then
    # 如果有，则会杀死所有包含"Simulator"字符串的进程
    pkill -f 'Simulator'
    echo "iOS模拟器进程已终止"
else
    echo "没有找到iOS模拟器进程"
fi

# 打开xcode模拟器
open -a Simulator
# 打开VSCode
code .

#xcrun simctl shutdown all：
#这是一个由苹果提供的命令行工具，用于与模拟器进行交互。
#simctl是用于管理iOS模拟器的工具，可以执行各种操作，如启动、关闭、安装应用等。
#shutdown all参数会关闭所有当前正在运行的iOS模拟器。

#pkill -f 'Simulator'：
#这是一个通用的Unix/Linux命令，用于根据进程名终止进程。
#pkill会根据提供的模式（这里是'Simulator'）终止匹配的进程。
#这个命令会终止包含"Simulator"字符串的所有进程，无论它们是何种进程（包括但不限于iOS模拟器）。
