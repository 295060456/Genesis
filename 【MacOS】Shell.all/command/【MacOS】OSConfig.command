#! /bin/sh

# 格式化打印输出
print_flutter_storage_base_url() {
    local prompt_message=$1
    local flutter_storage_base_url=$2
    echo "\033[1m${prompt_message}\033[0m"
    echo "\033[31m${flutter_storage_base_url}\033[0m"
}

# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
echo $current_directory

print_flutter_storage_base_url "当前系统所使用的FLUTTER_STORAGE_BASE_URL为：" "$FLUTTER_STORAGE_BASE_URL"
print_flutter_storage_base_url "当前系统所使用的PUB_HOSTED_URL为：" "$PUB_HOSTED_URL"

# 打开主目录和 .bash_profile 文件
open ~/
open ~/.bash_profile

# 重新加载 .bash_profile
source ~/.bash_profile
