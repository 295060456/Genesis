#!/bin/zsh

# 全局变量声明
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
    _JobsPrint_Green "【MacOS】新系统配置.一键配置环境变量"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 打开系统配置文件
open_files_if_enter() {
    _JobsPrint_Green "按回车键打开所有配置文件，输入任意字符并回车跳过..."
    read user_input
    if [[ -z "$user_input" ]]; then
        open "$HOME/.bash_profile"
        open "$HOME/.bashrc"
        open "$HOME/.zshrc"
    else
        _JobsPrint_Red "跳过打开配置文件。"
    fi
}
# 检查并复制配置文件
copy_file_with_prompt() {
    local src_file="$1"
    local dest_file="$2"
    if [[ -f "$src_file" ]]; then
        _JobsPrint_Green "发现文件 $src_file，是否复制到 $dest_file？按回车键同意，输入任意字符并回车跳过..."
        read user_input
        if [[ -z "$user_input" ]]; then
            cp "$src_file" "$dest_file"
            _JobsPrint_Green "已复制 $src_file 到 $dest_file"
        else
            _JobsPrint_Red "跳过复制 $src_file"
        fi
    else
        _JobsPrint_Red "文件 $src_file 不存在，跳过..."
    fi
}
# 主函数
main() {
    jobs_logo # 打印 "Jobs" logo
    self_intro # 自述信息
    open_files_if_enter # 打开系统配置文件
    # 检查并复制配置文件
    copy_file_with_prompt "$CURRENT_DIRECTORY/.bash_profile" "$HOME/.bash_profile"
    copy_file_with_prompt "$CURRENT_DIRECTORY/.bashrc" "$HOME/.bashrc"
    copy_file_with_prompt "$CURRENT_DIRECTORY/.zshrc" "$HOME/.zshrc"
}
# 执行主函数
main
