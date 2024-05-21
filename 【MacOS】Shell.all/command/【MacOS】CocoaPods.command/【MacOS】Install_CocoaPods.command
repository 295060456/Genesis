#!/bin/bash

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
# 更新 Oh.My.Zsh
update_OhMyZsh() {
    echo "检查是否有新版本..."
    cd ~/.oh-my-zsh || exit
    git fetch origin master
    
    if git rev-list --count HEAD..origin/master | grep -q '^0$' > /dev/null; then
        echo "已经是最新版本，无需更新。"
    else
        echo "发现新版本，正在升级 Oh.My.Zsh..."
        git pull origin master
    fi
}
# 检查并安装 Oh.My.Zsh
check_OhMyZsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "当前系统中未安装 Oh.My.Zsh，正在进行安装..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        return 1
    else
        echo "当前系统中已安装 Oh.My.Zsh，进行检查更新升级。"
        update_OhMyZsh
        return 0
    fi
}
# 准备前置环境
prepare_environment() {
    echo "先做一些准备工作..."
    # 显示Mac OS X上的隐藏文件和文件夹
    defaults write com.apple.Finder AppleShowAllFiles YES
    # 允许从任何来源打开应用（需要管理员权限）
    sudo spctl --master-disable
    # 检查并安装 Oh.My.Zsh
    check_OhMyZsh
}
# 检查 Xcode 和 Xcode Command Line Tools
check_xcode_and_tools() {
    if ! command -v xcodebuild &> /dev/null; then
        echo "Xcode 未安装，请安装后再运行此脚本。"
        open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"
        return 1
    fi

    if ! xcode-select -p &> /dev/null; then
        echo "Xcode Command Line Tools 未安装，请安装后再运行此脚本。"
        xcode-select --install
        echo "请按照提示进行安装，安装完成后再次运行此脚本。"
        return 0
    fi

    echo "🍺🍺🍺 Xcode 和 Xcode Command Line Tools 均已安装。"
}
# 安装 Homebrew
install_homebrew() {
    local choice
    while true; do
        read -p "请选择安装方式：1. 自定义脚本安装（可能不受官方支持） 2. 官方脚本安装（推荐）: " choice
        case $choice in
        1)
            echo "正在使用自定义脚本安装 Homebrew..."
            open https://gitee.com/ineo6/homebrew-install/
            /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
            ;;
        2)
            echo "正在使用官方脚本安装 Homebrew..."
            open https://brew.sh/
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            ;;
        *)
            echo "无效的选项，请输入 1 或 2。"
            ;;
        esac
        # 如果用户提供了有效的选项，则退出循环
        if [[ $choice == "1" || $choice == "2" ]]; then
            break
        fi
    done
}
# 检查并安装 Homebrew
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "brew 未安装，开始安装..."
        install_homebrew
        return 1
    else
        echo "Homebrew 已经安装，跳过安装步骤。"
        echo "检查更新 Homebrew..."
        brew update
        echo "升级 Homebrew 和由 Homebrew 管理的程序包..."
        brew upgrade
        echo "正在执行 Homebrew 清理工作..."
        sudo chown -R $(whoami) /usr/local/Cellar/
        sudo chown -R $(whoami) "$(brew --prefix)"/*
        brew cleanup
        echo "🍺🍺🍺完成更新和清理 Homebrew"
        brew doctor
        brew -v
        return 0
    fi
}
# 配置 Home.Ruby 环境变量
_brewRuby(){
    add_line_if_not_exists_bash_profile 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    add_line_if_not_exists_bashrc 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    add_line_if_not_exists_zshrc 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    
    # 初始化 rbenv
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 配置 Rbenv.Ruby 环境变量
_rbenRuby(){
    add_line_if_not_exists_bash_profile 'export PATH="$HOME/.rbenv/bin:$PATH"'
    add_line_if_not_exists_bashrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
    add_line_if_not_exists_zshrc 'export PATH="$HOME/.rbenv/bin:$PATH"'

    # 初始化 rbenv
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 检查并安装 Rbenv
check_Rbenv() {
    if ! command -v rbenv &> /dev/null; then
        echo "正在安装 Rbenv..."
        # 下载 Rbenv
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        # Rbenv的配置
        _rbenRuby
        echo "rbenv 安装完成."
        return 1
    else
        echo "检测到已安装 Rbenv，准备升级到最新版本..."
        echo "正在升级 Rbenv..."
        cd ~/.rbenv && git pull
        echo "Rbenv 升级完成."
        return 0
    fi
}
# 利用 Homebrew 安装 Ruby 环境
install_ruby_byBrew(){
    echo "利用 Homebrew 安装 Ruby环境（RVM）..."
    brew install ruby
    brew cleanup ruby
}
# 检测当前通过 Rbenv 安装的 Ruby 环境
check_rbenv_version(){
    echo '列出当前系统上安装的所有 Ruby 版本'
    rbenv versions
    echo '显示当前全局生效的 Ruby 版本'
    rbenv version
}
# 检测当前通过 HomeBrew 安装的 Ruby 环境
check_homebrew_version(){
    brew info ruby
}
# ❤️ Rbenv 是一个 Ruby 版本管理工具，它允许你在同一台机器上安装和管理多个 Ruby 版本 ❤️
# ❤️ 这在开发环境中非常有用，因为不同的项目可能需要不同版本的 Ruby 运行环境 ❤️
install_ruby_byRbenv(){
    echo "打印可用的 Ruby 版本列表："
    rbenv install --list | grep -v -e "^[[:space:]]*$"
    # 提示用户输入所需的 Ruby 版本
    echo "请输入要安装的 Ruby 版本号，或者按回车键安装当前最新版本（未输入版本号，则安装当前最新版本）: "
    read version
    # 如果用户未输入版本号，则安装最新版本
    if [ -z "$version" ]; then
        echo "正在安装最新版本的 Ruby..."
        latest_version=$(rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1)
        rbenv install $latest_version
        rbenv local $latest_version
    else
        # 检查用户输入的版本号是否存在
        if rbenv install --list | grep -q "$version"; then
            echo "正在安装 Ruby $version..."
            rbenv install $version
            rbenv local $version
        else
            echo "版本号 $version 不存在，请重新输入。"
            exit 1
        fi
    fi
    # Rbenv的配置
    _rbenRuby
    # 是为了确保 Rbenv 能够找到新安装的 Ruby 版本所对应的可执行文件。通常，这个命令在安装新的 Ruby 版本后会自动执行，但是如果遇到问题，可以手动执行一次。
    rbenv rehash
    check_rbenv_version
}
# 官方推荐安装的 Ruby 方式
install_ruby_byRVM(){
    open https://get.rvm.io
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
}

check_ruby_install_ByHomeBrew(){
    if brew list --formula | grep -q ruby; then
        echo "当前 Ruby 环境是通过 HomeBrew 安装的"
        echo "升级 HomeBrew.Ruby 到最新版..."
        brew upgrade ruby
        brew cleanup ruby
        return 1
    else
        echo "当前 Ruby 环境不是通过 HomeBrew 安装的"
        return 0
    fi
}

check_ruby_install_ByRbenv(){
    if check_rbenv_installed_ruby; then
        upgrade_current_rbenv_ruby
        echo "当前 Ruby 环境是通过 Rbe"
        return 1
    else
        echo "当前 Ruby 环境不是通过 Rbenv 安装的，无法升级"
        return 0
    fi
}

check_ruby_install_ByRVM(){
    # 检查当前Ruby环境是否是通过RVM官方推荐的方式安装的
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        echo "当前 Ruby 环境是否是通过RVM官方推荐的方式安装的"
        return 1
    else
        echo "当前 Ruby 环境不是否是通过RVM官方推荐的方式安装的"
        return 0
    fi
}

check_ruby_environment() {
    # 检查当前Ruby环境是否是MacOS自带的
    if [[ $(which ruby) == "/usr/bin/ruby" ]]; then
        echo "当前Ruby环境为MacOS自带的Ruby环境（阉割版）"
    else
        echo "检测到您的系统上存在非系统自带的 Ruby 环境。"
        check_rbenv_version
        check_homebrew_version
        read -p "是否删除这些非系统 Ruby 环境？(按 Enter 键继续，输入任意字符删除并重新安装): " confirm_delete
        if [[ -n "$confirm_delete" ]]; then
            echo "正在删除非系统 Ruby 环境..."
            uninstall_Ruby
        fi
    fi
    # 提示用户选择安装方式
    setup_ruby_environment
    # 检查当前Ruby环境是否是通过RVM官方推荐的方式安装的
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        echo "当前Ruby环境是否是通过RVM官方推荐的方式安装的"
    fi

    echo "查看本机的 Ruby 环境安装目录："
    which -a ruby
    echo "打印已安装的 Ruby 版本："
    rvm list
    echo "当前使用的 Ruby 版本："
    ruby -v
}
# 提示用户选择安装 Ruby 的方式
setup_ruby_environment(){
    echo "请选择 Ruby 的安装方式："
    echo "1. 使用 Homebrew 安装"
    echo "2. 使用 rbenv 安装"
    echo "1 或 2 以外的则选用RVM官方推荐的方式进行安装"
    read -p "请输入选项的数字进行安装 Ruby 环境: " choice
    # 根据用户选择执行相应的安装函数
    case $choice in
    1)
        install_ruby_byBrew
        echo "🍺🍺🍺 Homebrew.Ruby安装成功"
        # 检查当前Ruby环境是否是通过 HomeBrew 安装的
        check_ruby_install_ByHomeBrew
        ;;
    2)
        install_ruby_byRbenv
        echo "🍺🍺🍺 Rbenv.Ruby安装成功"
        # 检查当前Ruby环境是否是通过 Rbenv 安装的
        check_ruby_install_ByRbenv
        ;;
    *)
        install_ruby_byRVM
        echo "🍺🍺🍺 RVM.Ruby安装成功"
        check_ruby_install_ByRVM
        ;;
    esac
}
# 删除指定版本的 Ruby 环境
remove_ruby_environment() {
    local version=$1
    echo "开始删除 Ruby 环境：$version"
    
    # 删除 Homebrew 相关的 Ruby 环境
    if check_ruby_install_ByHomeBrew; then
        brew uninstall --force ruby
        # 清理 brew 相关配置文件中与 RVM 相关的行
        sudo sed -i '' '/rvm/d' ~/.bash_profile ~/.bashrc ~/.zshrc
    fi

    # 删除 Rbenv 相关的 Ruby 环境
    if check_ruby_install_ByRbenv; then
        sudo rbenv uninstall -f $version
    fi
    
    # 删除 RVM 官方推荐安装的 Ruby 环境
    if check_ruby_install_ByRVM ; then
        # Uninstall RVM
        echo "Uninstalling RVM..."
        rvm implode
        echo "Removing any remaining RVM-related directories..."
        rm -rf ~/.rvm
        # If you want to remove specific Ruby versions installed by RVM, you can add those commands here
        # Example: rvm remove ruby_version
        echo "Uninstallation complete."
    fi

    echo "Ruby 环境 $version 删除完成"
}
# 删除所有已安装的 Ruby 环境
remove_all_ruby_environments() {
    echo "开始删除所有已安装的 Ruby 环境"
    for version in $(rbenv versions --bare); do
        remove_ruby_environment $version
    done
    echo "所有 Ruby 环境已删除"
}

uninstall_Ruby(){
    # 询问用户是否删除所有已安装的 Ruby 环境
    read -p "是否删除所有已安装的 Ruby 环境？(y/n): " choice
    case $choice in
        [Yy]* )
            remove_all_ruby_environments
            ;;
        [Nn]* )
            echo "取消删除 Ruby 环境"
            ;;
        * )
            echo "无效的选项，取消删除 Ruby 环境"
            ;;
    esac
}
# 检查当前 Ruby 环境是否是通过 Rbenv 安装的
check_rbenv_installed_ruby() {
    local version=$(ruby -v | awk '{print $2}')
    local rbenv_version=$(rbenv version | awk '{print $1}')
    if [ "$version" == "$rbenv_version" ]; then
        echo "当前 Ruby 环境是通过 Rbenv 安装的"
        return 0
    else
        echo "当前 Ruby 环境不是通过 Rbenv 安装的"
        return 1
    fi
}
# 升级当前 Rbenv.Ruby 环境
upgrade_current_rbenv_ruby() {
    echo "开始升级当前 Ruby 环境"
    rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1 | xargs rbenv install -s
    echo "升级完成"
}
# 检查并安装 Gem
check_and_setup_gem() {
    # 检查是否已经安装 Gem
    if command -v gem &> /dev/null; then
        echo "Gem 已安装."
        # 询问用户是否卸载并重新安装 Gem
        read -p "是否卸载并重新安装 Gem? (按 Enter 键继续，输入任意字符则卸载并重新安装): " reinstall_gem
        if [[ -n "$reinstall_gem" ]]; then
            echo "正在卸载 Gem..."
            sudo gem uninstall --all --executables gem
            echo "Gem 已卸载."
            echo "正在重新安装 Gem..."
            brew install ruby
            echo "Gem 安装成功."
            echo "升级 Gem 到最新版本..."
            sudo gem update --system
            echo "Gem 已升级到最新版本."
            echo "更新 Gem 管理的所有包..."
            sudo gem update
            echo "🍺🍺🍺所有包已更新."
        else
            echo "不卸载 Gem，跳过安装步骤."
            echo "升级 Gem 到最新版本..."
            sudo gem update --system
            echo "Gem 已升级到最新版本."
            echo "更新 Gem 管理的所有包..."
            sudo gem update
            echo "🍺🍺🍺所有包已更新."
        fi
    else
        echo "Gem 未安装."
        echo "正在安装 Gem..."
        brew install ruby
        echo "Gem 安装成功."
        echo "升级 Gem 到最新版本..."
        sudo gem update --system
        echo "🍺🍺🍺 Gem 已升级到最新版本."
        echo "更新 Gem 管理的所有包..."
        sudo gem update
        echo "🍺🍺🍺所有 Gem 包已更新."
    fi
    # 检查本地当前的 IP 是否在中国大陆境内
    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        echo "本地当前的 IP 在中国大陆境内."
        echo "更换 Gem 源为 https://gems.ruby-china.com/ ..."
        gem sources --remove https://rubygems.org/
        gem sources --add https://gems.ruby-china.com/
        echo "Gem 源已更换."
        echo "更新 Gem 源列表缓存..."
        gem sources --update
        echo "Gem 源列表缓存已更新."
    else
        echo "本地当前的 IP 不在中国大陆境内，将移除 Gem 源 https://gems.ruby-china.com/ ..."
        gem sources --remove https://gems.ruby-china.com/
        echo "Gem 源已移除."
        echo "还原默认 Gem 源..."
        gem sources --add https://rubygems.org/
        echo "默认 Gem 源已还原."
        echo "更新 Gem 源列表缓存..."
        gem sources --update
        echo "Gem 源列表缓存已更新."
    fi

    echo "执行 Gem 清理工作..."
    sudo gem clean
    echo "Gem 清理工作已完成."
}
# 卸载 CocoaPods
remove_cocoapods() {
    echo "查看本地安装过的 CocoaPods 相关内容："
    gem list --local | grep cocoapods

    echo "确认删除 CocoaPods？确认请输入 'y'，取消请回车"
    read -n 1 sure

    if [[ $sure == "y" ]]; then
        echo "开始卸载 CocoaPods"
        # 使用正则表达式提取 gem list --local | grep cocoapods 输出的模块名
        for element in $(gem list --local | grep cocoapods | cut -d" " -f1)
        do
            echo "正在卸载 CocoaPods 子模块：$element ......"
            sudo gem uninstall $element
        done
    else
        echo "取消卸载 CocoaPods"
    fi
}
# 更新 CocoaPods 本地库
update_cocoapods() {
    echo "更新 CocoaPods 本地库..."
    pod repo update
    echo "CocoaPods 本地库已更新."
}
# 安装 CocoaPods
install_cocoapods() {
    # 询问用户是安装稳定版还是安装预览版
    read -p "是否安装稳定版 CocoaPods? (输入回车键安装稳定版，输入任意字符安装预览版): " install_stable
    if [[ -z "$install_stable" ]]; then
        echo "正在安装稳定版 CocoaPods..."
        sudo gem install cocoapods
    else
        echo "正在安装预览版 CocoaPods..."
        sudo gem install cocoapods --pre
    fi
    update_cocoapods
}
# 检查并安装 CocoaPods
check_and_setup_cocoapods() {
    # 检查用户 IP 是否在中国大陆境内
    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        echo "本地当前的 IP 在中国大陆境内."
        echo "选用清华大学的 CocoaPods 镜像..."
        pod repo remove master
        pod repo add master https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git
    else
        echo "本地当前的 IP 不在中国大陆境内，不需要更换 CocoaPods 镜像."
    fi
    
    # 检查是否已经安装 CocoaPods
    if command -v pod &> /dev/null; then
        remove_cocoapods
    else
        echo "CocoaPods 未安装."
    fi
    
    echo "开始安装 CocoaPods..."
    install_cocoapods

    # 检查 CocoaPods 的安装是否成功
    echo "检查 CocoaPods 的安装是否成功..."
    gem which cocoapods
    pod search Masonry
}
# 主流程
prepare_environment
check_xcode_and_tools
check_homebrew
check_Rbenv
check_ruby_environment
check_and_setup_gem
check_and_setup_cocoapods
