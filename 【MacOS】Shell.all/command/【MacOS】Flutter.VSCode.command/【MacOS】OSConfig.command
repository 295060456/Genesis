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

# 检查 ~/.bash_profile 文件是否存在，如果不存在则创建
if [ ! -f ~/.bash_profile ]; then
    touch ~/.bash_profile
    print "~/.bash_profile 文件" "已创建"
fi

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

# 添加各行配置到 ~/.bash_profile
# 配置FVM环境
add_line_if_not_exists "$HOME/.bash_profile" "export PATH="$PATH":"$HOME/.pub-cache/bin""
# 配置VSCode环境
add_line_if_not_exists "$HOME/.bash_profile" "export PATH="$PATH":/usr/local/bin"
add_line_if_not_exists "$HOME/.bash_profile" "export PATH="$PATH":/usr/local/bin/code"

# 添加 Android 环境变量配置
add_line_if_not_exists "$HOME/.bash_profile" "export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk"
add_line_if_not_exists "$HOME/.bash_profile" "export PATH=${PATH}:${ANDROID_HOME}/platform-tools"
add_line_if_not_exists "$HOME/.bash_profile" "export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"

# 添加 Flutter 环境变量配置
add_line_if_not_exists "$HOME/.bash_profile" "export PATH="$PATH:`pwd`/flutter/bin""
add_line_if_not_exists "$HOME/.bash_profile" "# 这里的路径即为Dart.Flutter.SDK名下的为bin目录（主要取决于你下载的SDK的绝对路径）"
add_line_if_not_exists "$HOME/.bash_profile" "export PATH=/Users/$(whoami)/Documents/Github/Flutter.sdk/Flutter.sdk_last/bin:$PATH"
add_line_if_not_exists "$HOME/.bash_profile" "#【相关阅读：Flutter切换源】https://juejin.cn/post/7204285137047257148"
add_line_if_not_exists "$HOME/.bash_profile" "# 防止域名在中国大陆互联网环境下的被屏蔽"
add_line_if_not_exists "$HOME/.bash_profile" "# export PUB_HOSTED_URL=https://pub.flutter-io.cn # 告诉了 Dart.Flutter 和 Dart 的包管理器 pub 在执行 pub get 或 pub upgrade 命令时使用备用仓库而不是默认的官方仓库。"
add_line_if_not_exists "$HOME/.bash_profile" "# Flutter官方正版源（温馨提示：海外IP访问大陆源，不开VPN会拉取失败）"
add_line_if_not_exists "$HOME/.bash_profile" "export PUB_HOSTED_URL=https://pub.dartlang.org"
add_line_if_not_exists "$HOME/.bash_profile" "# FLUTTER_STORAGE_BASE_URL 告诉了 Dart.Flutter SDK 在需要下载二进制文件或工具时从备用存储库获取，而不是从默认的 Google 存储库获取。"
add_line_if_not_exists "$HOME/.bash_profile" "# export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn # Flutter中国（七牛云）"
add_line_if_not_exists "$HOME/.bash_profile" "export FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com # Flutter官方的 Google Cloud 存储库地址"
# 配置终端打开的路径
add_line_if_not_exists "$HOME/.bash_profile" "cd ./Desktop"

# 检查并添加 # source ~/.bash_profile
if ! grep -qF '#source ~/.bash_profile' ~/.bash_profile; then
    echo '' >> ~/.bash_profile # 写入之前，先进行提行
    echo '#source ~/.bash_profile' >> ~/.bash_profile
    print "添加到.bash_profile：" '#source ~/.bash_profile'
else
    print ".bash_profile中已存在" '#source ~/.bash_profile'
fi

# 打开主目录和 .bash_profile 文件
open ~/
open ~/.bash_profile

add_line_if_not_exists_zshrc

# 重新加载 ~/.bash_profile
echo "重新加载 ~/.bash_profile"
source ~/.bash_profile
