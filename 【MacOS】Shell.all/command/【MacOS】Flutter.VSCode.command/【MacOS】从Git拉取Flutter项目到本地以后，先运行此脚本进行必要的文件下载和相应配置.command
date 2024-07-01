#!/bin/zsh

# 定义全局变量
# Apple Silicon (M1/M2) 的默认 Homebrew 安装路径是 /opt/homebrew，
# Intel 芯片的默认路径是 /usr/local。
typeset -g HOMEBREW_PATH_1='export PATH="/opt/homebrew/bin:$PATH"' # HomeBrew 的环境变量（M系列芯片）
typeset -g HOMEBREW_PATH_2='export PATH="/opt/homebrew/sbin:$PATH"' # HomeBrew 的环境变量（M系列芯片）
typeset -g HOMEBREW_PATH_3='export PATH="/usr/local/bin:/usr/local/sbin:$PATH"' # HomeBrew 的环境变量（x86架构芯片）
typeset -g HOMEBREW_PATH_4='export PATH="/usr/local/bin:/usr/local/bin:$PATH"' # HomeBrew 的环境变量（x86架构芯片）
typeset -g CURRENT_DIRECTORY=$(dirname "$(readlink -f "$0")") # 获取当前脚本文件的目录
typeset -g FLUTTER_SDK_PATH="/Users/$(whoami)/Documents/GitHub/Flutter.sdk/last"
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
# 定义黄色加粗输出方法
_JobsPrint_Yellow() {
    _JobsPrint "\033[1;33m" "$1"
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
    _JobsPrint_Green "【MacOS】双击安装 CocoaPods"
    _JobsPrint_Red "按回车键继续..."
    read
}
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
# 文件夹授权
update_permissions_for_dir() {
    local dir=$1
    if [ -d "$dir" ]; then
        _JobsPrint_Green "目录存在：$dir，正在更新权限和所有权..."
        sudo chmod -R 777 "$dir"
        sudo chown -R $(whoami) "$dir"
    else
        _JobsPrint_Yellow "目录不存在：$dir，跳过权限和所有权更新。"
    fi
}
# 更新每个目录的权限和所有权
folder_authorization(){
    update_permissions_for_dir "/usr/local/etc"
    update_permissions_for_dir "/usr/local"
    update_permissions_for_dir "/usr/local/Cellar"
    update_permissions_for_dir "$(brew --prefix)/*"
}
# 删除 Homebrew 的残留目录
homebrew_residual_directory_deletion(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    _JobsPrint_Green "正在删除残留的目录..."
    _JobsPrint_Red "SIP（系统完整性保护）可能会导致某些目录删除失败"
    _JobsPrint_Red "运行 csrutil disable 并重启 Mac，关闭 SIP（系统完整性保护）"

    sudo rm -rf /usr/local/Caskroom
    sudo rm -rf /usr/local/Cellar
    sudo rm -rf /usr/local/Homebrew/
    sudo rm -rf /usr/local/bin/
    sudo rm -rf /usr/local/etc/
    sudo rm -rf /usr/local/lib/
    sudo rm -rf /usr/local/microsoft/
    sudo rm -rf /usr/local/share/
    sudo rm -rf /usr/local/texlive/
    sudo rm -rf /usr/local/var/
    sudo rm -rf /opt/homebrew
}
# 卸载 Homebrew
uninstall_homebrew() {
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    _JobsPrint_Green "检测 Homebrew 安装方式..."
    
    # 检查 Homebrew 是否安装
    if ! command -v brew >/dev/null 2>&1; then
        _JobsPrint_Red "Homebrew 未安装。"
        return
    fi
    
    # 检查 Homebrew 安装路径
    brew_path=$(brew --prefix)
    
    if [[ "$brew_path" == "/usr/local/Homebrew" ]]; then
        _JobsPrint_Green "检测到 Homebrew 是通过官方脚本安装的..."
        _JobsPrint_Green "正在卸载 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    elif [[ "$brew_path" == "/home/linuxbrew/.linuxbrew" || "$brew_path" == "/opt/homebrew" ]]; then
        _JobsPrint_Green "检测到 Homebrew 是通过自定义脚本安装的..."
        _JobsPrint_Green "正在卸载 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/uninstall.sh)"
    else
        _JobsPrint_Red "无法确定 Homebrew 的安装方式。"
        return
    fi
    
    folder_authorization # 更新每个目录的权限和所有权
    homebrew_residual_directory_deletion # 删除 Homebrew 的残留目录

    _JobsPrint_Green "残留目录删除完成。"
    _JobsPrint_Green "Homebrew 卸载完成。验证卸载..."
    
    check_homebrew # 检查安装 Homebrew
}
# 只是通过官方推荐方式安装 Homebrew（没有配置相关的环境变量）
install_Homebrew_githubusercontent(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    _x86_homebrew_install(){
        _JobsPrint_Green "检测到 Intel 芯片, 正在安装 Homebrew 的 x86_64 版本"
        arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    
    _x64_homebrew_install(){
        _JobsPrint_Green "检测到 Apple 芯片，正在安装 Homebrew 的 ARM64 版本"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" /opt/homebrew
    }
    _framework_do "_x64_homebrew_install" "_x86_homebrew_install"
}
# 只是通过第三方脚本方式安装 Homebrew（没有配置相关的环境变量）
install_Homebrew_gitee(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    _x86_homebrew_install(){
        _JobsPrint_Green "检测到 Intel 芯片, 正在安装 Homebrew 的 x86_64 版本"
#        arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        arch -x86_64 /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
    }
    
    _x64_homebrew_install(){
        _JobsPrint_Green "检测到 Apple 芯片，正在安装 Homebrew 的 ARM64 版本"
#        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" /opt/homebrew
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)" /opt/homebrew
    }
    _framework_do "_x64_homebrew_install" "_x86_homebrew_install"
}
# 配置 Home.Ruby 环境变量
_config_brew_ruby(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
#HOMEBREW_PATH_1='export PATH="/opt/homebrew/bin:$PATH"' # HomeBrew 的环境变量（M系列芯片）
#HOMEBREW_PATH_2='export PATH="/opt/homebrew/sbin:$PATH"' # HomeBrew 的环境变量（M系列芯片）
#HOMEBREW_PATH_3='export PATH="/usr/local/bin:/usr/local/sbin:$PATH"' # HomeBrew 的环境变量（x86架构芯片）
#HOMEBREW_PATH_4='export PATH="/usr/local/bin:/usr/local/bin:$PATH"' # HomeBrew 的环境变量（x86架构芯片）
    _home_ruby_env_x64(){
        add_line_if_not_exists ".bash_profile" "$HOMEBREW_PATH_1" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "$HOMEBREW_PATH_3" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "$HOMEBREW_PATH_3" # 检查并添加行到 ./zshrc
        
        add_line_if_not_exists ".bash_profile" "$HOMEBREW_PATH_2" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "$HOMEBREW_PATH_4" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "$HOMEBREW_PATH_4" # 检查并添加行到 ./zshrc

        # 双引号需要转意，否则出错
        add_line_if_not_exists ".bash_profile" "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" # 检查并添加行到 ./zshrc
    }
    
    _home_ruby_env_x86(){
        add_line_if_not_exists ".bash_profile" "$HOMEBREW_PATH_3" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "$HOMEBREW_PATH_1" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "$HOMEBREW_PATH_1" # 检查并添加行到 ./zshrc

        add_line_if_not_exists ".bash_profile" "$HOMEBREW_PATH_4" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "$HOMEBREW_PATH_2" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "$HOMEBREW_PATH_2" # 检查并添加行到 ./zshrc

        # 双引号需要转意，否则出错
        add_line_if_not_exists ".bash_profile" "eval \"\$(/usr/local/bin/brew shellenv)\"" # 检查并添加行到 ./bash_profile
#        add_line_if_not_exists ".bashrc" "eval \"\$(/usr/local/bin/brew shellenv)\"" # 检查并添加行到 ./bashrc
#        add_line_if_not_exists ".zshrc" "eval \"\$(/usr/local/bin/brew shellenv)\"" # 检查并添加行到 ./zshrc
    }
    _framework_do "_home_ruby_env_x64" "_home_ruby_env_x86"
    if ! command -v brew >/dev/null 2>&1; then
        # 重新加载配置文件
        source ~/.bash_profile
#        source ~/.bashrc
#        source ~/.zshrc
    fi
}
# 键盘输入的方式安装 Homebrew if ! command -v brew &> /dev/null; then
install_homebrew_normal() {
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    
    # 检查并安装 Homebrew
    _JobsPrint_Green "Apple Silicon (M1/M2) 的默认 Homebrew 安装路径是 /opt/homebrew"
    _JobsPrint_Green "Intel 芯片的默认安装路径是 /usr/local。"
    
    _JobsPrint_Green "请选择 Homebrew 安装方式："
    _JobsPrint_Green "1. 自定义脚本安装 Homebrew（可能不受官方支持）"
    _JobsPrint_Green "2. 官方脚本安装 Homebrew（推荐）"
    _JobsPrint_Green "请输入选项（1或2，按回车默认选择2）: "
    read choice

    # 如果没有输入任何内容，则默认设置为2
    if [ -z "$choice" ]; then
        choice=2
    fi

    case $choice in
    1)
        _JobsPrint_Green "正在使用自定义脚本安装 Homebrew..."
        open https://gitee.com/ineo6/homebrew-install/
        install_Homebrew_gitee
        _config_brew_ruby # 写环境变量
        _JobsPrint_Green "自定义脚本安装 Homebrew 完毕。验证安装..."
        check_homebrew # 检查安装 Homebrew
        ;;
    2)
        _JobsPrint_Green "正在使用官方脚本安装 Homebrew..."
        open https://brew.sh/
        install_Homebrew_githubusercontent
        _config_brew_ruby # 写环境变量
        _JobsPrint_Green "官方脚本安装 Homebrew 完毕。验证安装..."
        check_homebrew # 检查安装 Homebrew
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_homebrew_normal # 检查并安装 Homebrew
        ;;
    esac
    # 恢复已安装的 Homebrew 包：
    _framework_do "arch -arm64 xargs brew install < ~/brew-packages.txt" "xargs brew install < ~/brew-packages.txt"
}
# 检查安装 Homebrew
check_homebrew() {
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    install_and_update_homebrew_dependencies # 安装/更新 Homebrew 必要的依赖项
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v brew &> /dev/null; then
        _JobsPrint_Red "brew 未安装，开始安装..."
        install_homebrew_normal # 检查并安装 Homebrew
    else
        _JobsPrint_Green "Homebrew 已经安装，跳过安装步骤。"
        _JobsPrint_Green "检查更新 Homebrew..."
        _framework_do "_homebrew_update_arm64" "_homebrew_update_x86"
        _JobsPrint_Green "升级 Homebrew 和由 Homebrew 管理的程序包..."
        _JobsPrint_Green "正在执行 Homebrew 清理工作..."
        folder_authorization # 更新每个目录的权限和所有权
        brew cleanup
        _JobsPrint_Green "🍺🍺🍺完成更新和清理 Homebrew"
        brew doctor
        brew -v
    fi
}
# git clone 的方式 安装 Dart 环境
download_flutter_git(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 尝试使用SSH方式克隆
    git clone git@github.com:flutter/flutter.git "$FLUTTER_SDK_PATH" || {
        _JobsPrint_Red "SSH方式克隆失败，尝试使用HTTPS方式克隆..."
        git clone https://github.com/flutter/flutter.git "$FLUTTER_SDK_PATH"
    }
}
# 先检查 git clone 的下载路径
check_flutter_git(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 因为 flutter.sdk 里面有dart环境，所以就下载
    # 检查Flutter SDK路径是否存在
    if [ ! -d "$FLUTTER_SDK_PATH" ]; then
        _JobsPrint_Red "Flutter SDK文件夹不存在，创建文件夹并下载Flutter SDK..."
        mkdir -p "$FLUTTER_SDK_PATH"
        download_flutter_git # 因为 flutter.sdk 里面有dart环境，所以就下载
    else
        # 检查Flutter SDK文件夹是否为空
        if [ -z "$(ls -A "$FLUTTER_SDK_PATH")" ]; then
            _JobsPrint_Red "Flutter SDK文件夹为空，下载Flutter SDK..."
            download_flutter_git # 因为 flutter.sdk 里面有dart环境，所以就下载
        else
            _JobsPrint_Green "Flutter SDK文件夹存在且不为空，执行升级操作..."
            cd "$FLUTTER_SDK_PATH"
            git pull
        fi
    fi
}
# 利用 Homebrew 的方式，安装 Dart 环境
download_dart_brew(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    check_homebrew # 检查安装 Homebrew
    brew tap dart-lang/dart
    brew install dart
    brew cleanup
}
# 利用 Homebrew 的方式，安装 Flutter 环境
download_flutter_brew(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    check_homebrew # 检查安装 Homebrew
    brew install flutter
    brew cleanup
}
# 使用fzf选择安装 Dart 环境的方式
choose_install_method() {
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    local choice=$(printf "1. Git Clone\n2. Homebrew\n" | fzf +m --ansi --prompt="选择 Flutter 环境的安装方式： ")
    case "$choice" in
        "1. Git Clone")
            check_flutter_git
            ;;
        "2. Homebrew")
#            download_dart_brew
            download_flutter_brew
            ;;
        *)
            _JobsPrint_Red "未选择有效的安装方式。"
            ;;
    esac
}
# 检查 Flutter 环境
check_flutter(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 检查 flutter 命令是否存在
    if ! command -v flutter &> /dev/null; then
        _JobsPrint_Red "Flutter 命令不存在..."
        choose_install_method # 使用fzf选择安装 Flutter 环境的方式
    else
        _JobsPrint_Green "Flutter 命令已存在，跳过操作。"
    fi
}
# 安装 FVM
install_fvm(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    check_flutter # 检查 flutter 环境
    dart pub global activate fvm
}
# 配置 FVM
config_fvm(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 将 FVM 添加到 PATH
    add_line_if_not_exists_bash_profile 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
#    add_line_if_not_exists_bashrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
#    add_line_if_not_exists_zshrc 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
    
#    source ~/.bashrc
#    source ~/.zshrc
    source ~/.bash_profile
    
    # 等待用户输入
    _JobsPrint_Green "配置已完成。按回车键继续，或者输入任意字符后按回车键以打开 ~/.bash_profile"
    read -r userInput
    if [ -n "$userInput" ]; then
#        open ~/.bashrc
#        open ~/.zshrc
        open ~/.bash_profile
    fi
}
# 检查安装 VS Code
check_vscode(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 检查是否已安装 VS Code
    if [ ! -d "/Applications/Visual Studio Code.app" ]; then
      _JobsPrint_Red "Visual Studio Code 未安装，请先安装 VS Code。"
      open https://code.visualstudio.com/
      read -r # 等待用户按回车键
      check_vscode # 检查安装 VS Code
    fi

    # 添加 VS Code 命令到 PATH
    if grep -q 'Visual Studio Code.app' ~/.zshrc; then
      _JobsPrint_Red "PATH 已经包含 VS Code 命令，无需重复添加。"
    else
        add_line_if_not_exists_bash_profile 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"'
#        add_line_if_not_exists_bashrc 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"'
#        add_line_if_not_exists_zshrc 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"'
        _JobsPrint_Green "已将 VS Code 命令添加到 PATH。请重启终端或运行 'source ~/.zshrc' 使更改生效。"
    fi
}
# 检查安装 FVM
check_install_FVM(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 检查是否已安装 FVM
    if ! command -v fvm &> /dev/null; then
        _JobsPrint_Red "FVM 没有安装，正在执行安装..."
        install_fvm # 安装 FVM
        config_fvm # 配置 FVM
        check_install_FVM
    else
        _JobsPrint_Green "FVM 已经被正确安装了"
    fi
}
# 使用 FVM
use_FVM(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    # 下载最新的fvm稳定版
    fvm install stable
    # fvm install 3.7.12
    # 此项目里面用的flutter的SDK版本，固定死就是3.7.12
    # fvm use 3.7.12
    # 使用最新的fvm稳定版
    fvm use stable
}
# 配置 flutter 工程
config_flutter(){
    _JobsPrint_Yellow "正在执行: ${funcstack[1]}()"
    flutter doctor -v
    fvm flutter --version
    fvm flutter pub get
    flutter precache
}
# 主流程
cd $CURRENT_DIRECTORY
jobs_logo # 打印 "Jobs" logo
self_intro # 自述信息
check_install_FVM # 检查安装 FVM
use_FVM # 使用 FVM
config_flutter # 配置 flutter 工程
