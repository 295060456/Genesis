#!/bin/zsh

# 定义全局变量
CURRENT_DIRECTORY=$(dirname "$(readlink -f "$0")") # 获取当前脚本文件的目录
# 通用打印方法
_JobsPrint() {
    local COLOR="$1"
    local text="$2"
    local RESET="\033[0m"
    echo "${COLOR}${text}${RESET}"
}
# 定义红色加粗输出方法
_JobsPrint_Red() {
    _JobsPrint "\033[1;31m" "$1"
}
# 定义绿色加粗输出方法
_JobsPrint_Green() {
    _JobsPrint "\033[1;32m" "$1"
}
# 打印 "Jobs" logo
jobs_logo() {
    local border="=="
    local width=49  # 根据logo的宽度调整
    local top_bottom_border=$(printf '%0.1s' "${border}"{1..$width})
    local logo="
||${top_bottom_border}||
||  JJJJJJJJ     oooooo    bb          SSSSSSSSSS  ||
||        JJ    oo    oo   bb          SS      SS  ||
||        JJ    oo    oo   bb          SS          ||
||        JJ    oo    oo   bbbbbbbbb   SSSSSSSSSS  ||
||  J     JJ    oo    oo   bb      bb          SS  ||
||  JJ    JJ    oo    oo   bb      bb  SS      SS  ||
||   JJJJJJ      oooooo     bbbbbbbb   SSSSSSSSSS  ||
||${top_bottom_border}||
"
    _JobsPrint_Green "$logo"
}
# 自述信息
self_intro() {
    _JobsPrint_Green "【MacOS】用 FVM 管理项目工程 Flutter.SDK 版本"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 切换到当前目录
set_and_cd_to_script_dir() {
    # 获取并设置当前脚本文件的目录
    _JobsPrint_Green "当前目录：$CURRENT_DIRECTORY"
    # 切换到该目录
    cd "$script_dir" || { _JobsPrint_Red "切换目录失败"; exit 1; }
}
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
        _JobsPrint_Green "字符串 '$STRING' 已添加到文件 $FILE_PATH"
    else
        _JobsPrint_Red "文件 $FILE_PATH 已经包含字符串 '$STRING'"
    fi
}
# 检查是否已安装 FVM
check_FVM(){
    if ! command -v fvm &> /dev/null; then
        _JobsPrint_Green "FVM 还没安装。安装现在开始..."
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
        echo "${color}FVM 成功安装${reset}"
    else
        color=$(tput setaf 1) # 设置文本颜色为红色
        reset=$(tput sgr0)    # 重置颜色设置
        _JobsPrint_Green "${color}FVM 已经安装${reset}"
    fi
}
# 下载和配置 FVM
downLoad_and_config_FVM(){
    # 下载最新的 FVM 稳定版
    _JobsPrint_Green "${color}下载最新的fvm稳定版：${reset}"
    fvm install stable
    # 使用最新的 FVM 稳定版
    _JobsPrint_Green "${color}使用最新的fvm稳定版：${reset}"
    fvm use stable
    # 查看 FVM 的安装路径
    # 用FVM 管理当前项目的 Flutter.SDK 版本的 SDK 路径：在`.fvm`隐藏文件夹路径下
    _JobsPrint_Green "查看fvm的安装路径："
    _JobsPrint_Green "${color}用FVM管理当前项目的Flutter.SDK版本的SDK路径：在${reset}$(tput smul).fvm${reset}${color}隐藏文件夹路径下：${reset}"
    which fvm
    # 查看 FVM 管理的当前项目的 Flutter 版本
    _JobsPrint_Green "${color}查看fvm管理的当前项目的Flutter版本：${reset}"
    fvm flutter --version
}
# 主流程
jobs_logo # 打印 "Jobs" logo
self_intro # 自述信息
set_and_cd_to_script_dir # 切换到当前目录
check_FVM # 检查是否已安装 FVM
downLoad_and_config_FVM # 下载和配置 FVM
