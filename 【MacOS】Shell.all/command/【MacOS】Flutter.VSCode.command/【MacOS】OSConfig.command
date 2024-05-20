#! /bin/sh

# 格式化打印输出
print() {
    local mainMessage=$1
    local subMessage=$2
    echo "\033[1m${mainMessage}\033[0m"
    echo "\033[31m${subMessage}\033[0m"
}

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory

print "当前系统所使用的FLUTTER_STORAGE_BASE_URL为：" "$FLUTTER_STORAGE_BASE_URL"
print "当前系统所使用的PUB_HOSTED_URL为：" "$PUB_HOSTED_URL"

# 打开主目录和 .bash_profile 文件
open ~/
open ~/.bash_profile

# 重新加载 .bash_profile
source ~/.bash_profile
