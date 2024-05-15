#!/bin/bash

# 定义关闭终端窗口的函数
close_terminal_window() {
    # 获取所有终端窗口的索引
    WINDOW_IDS=$(osascript -e 'tell application "Terminal" to get id of every window')
    # 将索引分行并输出
    echo "当前终端ID为："
    echo "$WINDOW_IDS" | tr ',' '\n'
    # 假设要关闭第一个窗口（索引从1开始）
    WINDOW_TO_CLOSE=$(echo "$WINDOW_IDS" | tr ',' '\n' | head -n 1)
    # 关闭指定窗口
    osascript -e "tell application \"Terminal\" to close (every window whose id is $WINDOW_TO_CLOSE) without saving"
}

# 打开新的终端窗口并切换到脚本所在的目录
open_terminal_and_cd() {
    local dir="$1"
    osascript <<EOF
tell application "Terminal"
    do script "cd $dir"
    activate
end tell
EOF
}

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")

# 关闭终端窗口
close_terminal_window

# 打开新的终端窗口并切换到脚本所在的目录
open_terminal_and_cd "$current_directory"
