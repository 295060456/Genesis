#!/bin/bash

# 定义函数，参数为文件路径和要检查的字符串
add_line_if_not_exists() {
    local FILE_PATH="$1"
    local STRING="$2"
    local UNIQUE=true
    
    # 检查文件是否存在，如果不存在则创建它
    if [ ! -f "$FILE_PATH" ]; then
        touch "$FILE_PATH"
    fi
    
    # 逐行读取文件内容
    while IFS= read -r line; do
        # 检查行中是否包含指定字符串
        if [[ "$line" =~ "$STRING" ]]; then  # 修改此处，添加双引号
            # 如果字符串前面没有 # 或者 # 和字符串之间没有其他字符
            if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
                UNIQUE=false
                break
            fi
        fi
    done < "$FILE_PATH"
    
    # 如果文件中没有符合条件的字符串，则写入字符串
    if $UNIQUE; then
        echo "$STRING" >> "$FILE_PATH"
        echo "字符串 '$STRING' 已添加到文件 $FILE_PATH"
    else
        echo "文件 $FILE_PATH 已经包含字符串 '$STRING'"
    fi
}
# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
cd $current_directory
# 检查是否已安装 FVM
if ! command -v fvm &> /dev/null; then
    echo "FVM 还没安装。安装现在开始..."
    # 安装 FVM
    dart pub global activate fvm
    # 将 FVM 添加到 PATH
    add_line_if_not_exists "$HOME/.bashrc" "export PATH="$PATH":"$HOME/.pub-cache/bin""
    add_line_if_not_exists "$HOME/.zshrc" "export PATH="$PATH":"$HOME/.pub-cache/bin""
    add_line_if_not_exists "$HOME/.bash_profile" "export PATH="$PATH":"$HOME/.pub-cache/bin""
    
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile

    color=$(tput setaf 2) # 设置文本颜色为绿色
    reset=$(tput sgr0)    # 重置颜色设置
    echo "${color}FVM installed successfully.${reset}"
else
    color=$(tput setaf 1) # 设置文本颜色为红色
    reset=$(tput sgr0)    # 重置颜色设置
    echo "${color}FVM is already installed.${reset}"
fi
# 下载最新的fvm稳定版
echo "${color}下载最新的fvm稳定版：${reset}"
fvm install stable
# 使用最新的fvm稳定版
echo "${color}使用最新的fvm稳定版：${reset}"
fvm use stable
# 查看fvm的安装路径
# 用FVM管理当前项目的Flutter.SDK版本的SDK路径：在`.fvm`隐藏文件夹路径下
echo "查看fvm的安装路径："
echo "${color}用FVM管理当前项目的Flutter.SDK版本的SDK路径：在${reset}$(tput smul).fvm${reset}${color}隐藏文件夹路径下：${reset}"
which fvm
# 查看fvm管理的当前项目的Flutter版本
echo "${color}查看fvm管理的当前项目的Flutter版本：${reset}"
fvm flutter --version
