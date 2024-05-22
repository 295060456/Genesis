#!/bin/bash

# 检查并添加行到 ~/.bash_profile
add_line_if_not_exists_bash_profile() {
    local line=$1
    if ! grep -qF "$line" ~/.bash_profile; then
        # 如果行中包含目标字符串 "RRR"
        if [[ "$line" =~ RRR ]]; then
            # 如果 "RRR" 前面没有 # 或者 # 和 "RRR" 之间没有其他字符，则进行添加
            if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
                echo '' >> ~/.bash_profile # 写入之前，先进行提行
                echo "$line" >> ~/.bash_profile
                print "添加到 ~/.bash_profile ：" "$line"
            else
                print "不添加到 ~/.bash_profile ：" "$line"
            fi
        else
            echo '' >> ~/.bash_profile # 写入之前，先进行提行
            echo "$line" >> ~/.bash_profile
            print "添加到 ~/.bash_profile ：" "$line"
        fi
    else
        print "~/.bash_profile 中已存在" "$line"
    fi
}
# 检查并添加行到 ~/.bashrc
add_line_if_not_exists_bashrc() {
    local line=$1
    if ! grep -qF "$line" ~/.bashrc; then
        # 如果行中包含目标字符串 "RRR"
        if [[ "$line" =~ RRR ]]; then
            # 如果 "RRR" 前面没有 # 或者 # 和 "RRR" 之间没有其他字符，则进行添加
            if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
                echo '' >> ~/.bashrc # 写入之前，先进行提行
                echo "$line" >> ~/.bashrc
                echo "添加到 ~/.bashrc ：" "$line"
            else
                echo "不添加到 ~/.bashrc ：" "$line"
            fi
        else
            echo '' >> ~/.bashrc # 写入之前，先进行提行
            echo "$line" >> ~/.bashrc
            echo "添加到 ~/.bashrc ：" "$line"
        fi
    else
        echo ".bashrc 中已存在" "$line"
    fi
}
# 检查并添加行到 ~/.zshrc
add_line_if_not_exists_zshrc() {
    local line=$1
    if ! grep -qF "$line" source ~/.zshrc; then
        # 如果行中包含目标字符串 "RRR"
        if [[ "$line" =~ RRR ]]; then
            # 如果 "RRR" 前面没有 # 或者 # 和 "RRR" 之间没有其他字符，则进行添加
            if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
                echo '' >> ~/.zshrc # 写入之前，先进行提行
                echo "$line" >> source ~/.zshrc
                print "添加到 ~/.zshrc ：" "$line"
            else
                print "不添加到 ~/.zshrc ：" "$line"
            fi
        else
            echo '' >> ~/.zshrc # 写入之前，先进行提行
            echo "$line" >> source ~/.zshrc
            print "添加到 ~/.zshrc ：" "$line"
        fi
    else
        print "~/.zshrc 中已存在" "$line"
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
    add_line_if_not_exists_bash_profile 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    add_line_if_not_exists_bashrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    add_line_if_not_exists_zshrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    
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
