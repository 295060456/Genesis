#!/bin/zsh

# 检查并添加行到./bash_profile
add_line_if_not_exists_bash_profile() {
    local line=$1
    if ! grep -qF "$line" ~/.bash_profile; then
        echo '' >> ~/.bash_profile # 写入之前，先进行提行
        echo "$line" >> ~/.bash_profile
        print "添加到.bash_profile：" "$line"
    else
        print ".bash_profile中已存在" "$line"
    fi
}
# 检查并添加行到./bashrc
add_line_if_not_exists_bashrc() {
    local line=$1
    if ! grep -qF "$line" ~/.bashrc; then
        echo '' >> ~/.bashrc # 写入之前，先进行提行
        echo "$line" >> ~/.bashrc
        print "添加到.bashrc：" "$line"
    else
        print ".bashrc中已存在" "$line"
    fi
}
# 检查并添加行到./zshrc
add_line_if_not_exists_zshrc() {
    local line=$1
    if ! grep -qF "$line" ~/.zshrc; then
        echo '' >> ~/.zshrc # 写入之前，先进行提行
        echo "$line" >> ~/.zshrc
        print "添加到.zshrc：" "$line"
    else
        print ".zshrc中已存在" "$line"
    fi
}
# 获取当前脚本文件的目录
current_directory=$(dirname "$(readlink -f "$0")")
cd $current_directory
# 检查是否已安装 FVM
if ! command -v fvm &> /dev/null; then
    echo "FVM is not installed. Installing now..."
    # 安装 FVM
    dart pub global activate fvm
    # 将 FVM 添加到 PATH
    add_line_if_not_exists_bash_profile 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    add_line_if_not_exists_bashrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    add_line_if_not_exists_zshrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile

    echo "FVM installed successfully."
else
    echo "FVM is already installed."
fi
# 下载最新的fvm稳定版
fvm install stable
fvm install 3.7.12
# 此项目里面用的flutter的SDK版本，固定死就是3.7.12
fvm use 3.7.12
# 使用最新的fvm稳定版
#fvm use stable

flutter doctor -v
fvm flutter --version
fvm flutter pub get
flutter precache
