#!/bin/bash

# 检查并添加行到./bash_profile
add_line_if_not_exists_bash_profile() {
    local line=$1
    if ! grep -qF "$line" ~/.bash_profile; then
        echo '' >> ~/.bash_profile # 写入之前，先进行提行
        echo "$line" >> ~/.bash_profile
        echo "添加到.bash_profile：" "$line"
    else
        echo ".bash_profile中已存在" "$line"
    fi
}
# 检查并添加行到./bashrc
add_line_if_not_exists_bashrc() {
    local line=$1
    if ! grep -qF "$line" ~/.bashrc; then
        echo '' >> ~/.bashrc # 写入之前，先进行提行
        echo "$line" >> ~/.bashrc
        echo "添加到.bashrc：" "$line"
    else
        echo ".bashrc中已存在" "$line"
    fi
}
# 检查并添加行到./zshrc
add_line_if_not_exists_zshrc() {
    local line=$1
    if ! grep -qF "$line" ~/.zshrc; then
        echo '' >> ~/.zshrc # 写入之前，先进行提行
        echo "$line" >> ~/.zshrc
        echo "添加到.zshrc：" "$line"
    else
        echo ".zshrc中已存在" "$line"
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
