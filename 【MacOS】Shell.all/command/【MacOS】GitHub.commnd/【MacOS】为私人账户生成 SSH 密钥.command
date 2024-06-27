#!/bin/bash

# 全局变量声明
CURRENT_DIRECTORY=$(dirname "$(readlink -f "$0")") # 获取当前脚本文件的目录
default_personal_email="295060456@qq.com"
personal_ssh_dir="$HOME/.ssh"
personal_ssh_key="$personal_ssh_dir/id_rsa_personal"
work_email="olive@vgtech.org"
work_ssh_dir="$HOME/.ssh"
work_ssh_key="$work_ssh_dir/id_rsa_work"
# 通用打印方法
_JobsPrint() {
    local COLOR="$1"
    local text="$2"
    local RESET="\033[0m"
    echo -e "${COLOR}${text}${RESET}"
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
    _JobsPrint_Green "【MacOS】Setup_ssh_for_Github"
    _JobsPrint_Green "为私人账户生成 SSH 密钥"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 生成 SSH 密钥并添加到 ssh-agent
generate_ssh_key() {
    local email="$1"
    local key_path="$2"
    _JobsPrint_Green "为 $email 生成 SSH 密钥"
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$key_path" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$key_path"
    _JobsPrint_Green "你的 $email 账户的公钥是："
    cat "$key_path.pub"
}
# 获取用户输入的 personal_email
get_personal_email() {
    read -p "请输入个人邮箱 (默认: $default_personal_email): " personal_email
    if [[ -z "$personal_email" ]]; then
        personal_email="$default_personal_email"
    fi
    _JobsPrint_Green "$personal_email"
}
# 测试与 GitHub 和 GitLab 的 SSH 连接
test_ssh_connection() {
    read -p "按回车键继续，并测试与 GitHub 的 SSH 连接..."
    ssh -T git@github.com
    ssh -T git@git.131j.com
    _JobsPrint_Green " SSH 设置完成！"
}
# 主函数
main() {
    jobs_logo
    self_intro
    personal_email=$(get_personal_email)
    generate_ssh_key "$personal_email" "$personal_ssh_key"
    generate_ssh_key "$work_email" "$work_ssh_key"
    test_ssh_connection
}
# 执行主函数
main
