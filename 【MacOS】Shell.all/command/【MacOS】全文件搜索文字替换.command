#!/bin/zsh

# 打印 "Jobs" logo
jobs_logo() {
    local logo="
JJJJJJJJ     oooooo    bb          SSSSSSSSSS
      JJ    oo    oo   bb          SS      SS
      JJ    oo    oo   bb          SS
      JJ    oo    oo   bbbbbbbbb   SSSSSSSSSS
J     JJ    oo    oo   bb      bb          SS
JJ    JJ    oo    oo   bb      bb  SS      SS
 JJJJJJ      oooooo     bbbbbbbb   SSSSSSSSSS
"
    _JobsPrint_Green "$logo"
}
# 全局变量声明
typeset -g script_dir
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
# 获取脚本目录
get_script_dir() {
    script_path="${(%):-%x}"
    script_dir=$(cd "$(dirname "$script_path")"; pwd)
    _JobsPrint_Green "当前脚本的执行目录：$script_dir"
}
# 自述信息
self_intro() {
    _JobsPrint_Green "对某文件进行全文搜索，以达到字符替换的功能"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 定义一个函数用于搜索和替换内容
search_and_replace() {
    local file_path="$1"
    local search_term="$2"
    local replace_term="$3"
    get_script_dir
    if [[ ! -f $file_path ]]; then
        _JobsPrint_Red "文件不存在"
        return 1
    fi
    if grep -q "$search_term" "$file_path"; then
        sed -i "" "s/$search_term/$replace_term/g" "$file_path"
        _JobsPrint_Green "内容已从 '$search_term' 替换为 '$replace_term'。"
    else
        _JobsPrint_Red "文件中没有找到 '$search_term'。"
    fi
    _JobsPrint_Green "脚本执行完毕。"
}
# 主脚本逻辑
main() {
    jobs_logo
    self_intro
    local DEFAULT_SEARCH="AAA"
    local DEFAULT_REPLACE="DDD"
    read "search_term?请输入要搜索的文本 (默认是 '$DEFAULT_SEARCH'): "
    local search_term=${search_term:-$DEFAULT_SEARCH}
    read "replace_term?请输入要替换的文本 (默认是 '$DEFAULT_REPLACE'): "
    local replace_term=${replace_term:-$DEFAULT_REPLACE}
    read "file_path?请拖放文件到此处: "
    search_and_replace "$file_path" "$search_term" "$replace_term"
}
# 调用主函数
main
