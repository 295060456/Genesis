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
# 自诉信息
self_intro() {
    _JobsPrint_Green "安装Cocoapods"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 检查并添加行到 ./bash_profile
add_line_if_not_exists_bash_profile() {
    local line=$1
    if ! grep -qF "$line" ~/.bash_profile; then
        echo '' >> ~/.bash_profile # 写入之前，先进行提行
        echo "$line" >> ~/.bash_profile
        _JobsPrint_Green "添加到.bash_profile：$line"
    else
        _JobsPrint_Red ".bash_profile中已存在 $line"
    fi
}
# 检查并添加行到 ./bashrc
add_line_if_not_exists_bashrc() {
    local line=$1
    if ! grep -qF "$line" ~/.bashrc; then
        echo '' >> ~/.bashrc # 写入之前，先进行提行
        echo "$line" >> ~/.bashrc
        _JobsPrint_Green "添加到.bashrc：$line"
    else
        _JobsPrint_Red ".bashrc中已存在 $line"
    fi
}
# 检查并添加行到 ./zshrc
add_line_if_not_exists_zshrc() {
    local line=$1
    if ! grep -qF "$line" ~/.zshrc; then
        echo '' >> ~/.zshrc # 写入之前，先进行提行
        echo "$line" >> ~/.zshrc
        _JobsPrint_Green "添加到.zshrc：$line"
    else
        _JobsPrint_Red ".zshrc中已存在 $line"
    fi
}
# 更新 Oh.My.Zsh
update_OhMyZsh() {
    _JobsPrint_Green "检查是否有新版本..."
    cd ~/.oh-my-zsh || exit
    git fetch origin master
    if git rev-list --count HEAD..origin/master | grep -q '^0$' > /dev/null; then
        _JobsPrint_Green "已经是最新版本，无需更新。"
    else
        _JobsPrint_Green "发现新版本，正在升级 Oh.My.Zsh..."
        git pull origin master
    fi
}
# 检查并安装 Oh.My.Zsh
check_OhMyZsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        _JobsPrint_Green "当前系统中未安装 Oh.My.Zsh，正在进行安装..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        return 1
    else
        _JobsPrint_Green "当前系统中已安装 Oh.My.Zsh，进行检查更新升级。"
        update_OhMyZsh
        return 0
    fi
}
# 准备前置环境
prepare_environment() {
    _JobsPrint_Green "先做一些准备工作..."
    # 显示Mac OS X上的隐藏文件和文件夹
    defaults write com.apple.Finder AppleShowAllFiles YES
    # 允许从任何来源打开应用（需要管理员权限）
    sudo spctl --master-disable
    # 检查并安装 Oh.My.Zsh
    check_OhMyZsh
    # 安装 Rosetta 2:在 Apple Silicon 上安装和运行某些工具时，可能需要使用 Rosetta 2 来确保兼容性
    softwareupdate --install-rosetta
    # 确认 Rosetta 2 安装成功
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
}
# 检查 Xcode 和 Xcode Command Line Tools
check_xcode_and_tools() {
    if ! command -v xcodebuild &> /dev/null; then
        _JobsPrint_Red "Xcode 未安装，请安装后再运行此脚本。"
        open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"
        return 1
    fi

    if ! xcode-select -p &> /dev/null; then
        _JobsPrint_Red "Xcode Command Line Tools 未安装，请安装后再运行此脚本。"
        xcode-select --install
        _JobsPrint_Green "请按照提示进行安装，安装完成后再次运行此脚本。"
        return 0
    fi
    _JobsPrint_Green "🍺🍺🍺 Xcode 和 Xcode Command Line Tools 均已安装。"
}
# 检查并安装/更新 fzf
check_and_update_fzf() {
    if ! command -v fzf &> /dev/null
    then
        _JobsPrint_Red "fzf没有安装，正在安装到最新版本"
        brew install fzf
    else
        _JobsPrint_Green "fzf 已被安装，正在检查更新..."
        brew upgrade fzf
        # 有更新才更新
        outdated_packages=$(brew outdated fzf)
        if [ -n "$outdated_packages" ]; then
            _JobsPrint_Green "升级 fzf..."
            brew upgrade fzf
        else
            _JobsPrint_Green "fzf 已经是最新版本"
        fi
    fi
}
# 安装 Homebrew
install_homebrew() {
    local choice
    choice=$(printf "1. 自定义脚本安装（可能不受官方支持）\n2. 官方脚本安装（推荐）" | fzf --prompt "请选择安装方式：")
    case $choice in
    "1. 自定义脚本安装（可能不受官方支持）")
        _JobsPrint_Green "正在使用自定义脚本安装 Homebrew..."
        open https://gitee.com/ineo6/homebrew-install/
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
        ;;
    "2. 官方脚本安装（推荐）")
        _JobsPrint_Green "正在使用官方脚本安装 Homebrew..."
        open https://brew.sh/
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_homebrew
        ;;
    esac
}
# 检查并安装 Homebrew
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        _JobsPrint_Red "brew 未安装，开始安装..."
        install_homebrew
        return 1
    else
        _JobsPrint_Green "Homebrew 已经安装，跳过安装步骤。"
        _JobsPrint_Green "检查更新 Homebrew..."
        brew update
        _JobsPrint_Green "升级 Homebrew 和由 Homebrew 管理的程序包..."
        brew upgrade
        _JobsPrint_Green "正在执行 Homebrew 清理工作..."
  
        if [ -d "/usr/local/Cellar/" ]; then
            sudo chown -R $(whoami) /usr/local/Cellar/
        fi
        if [ -d "$(brew --prefix)" ]; then
            sudo chown -R $(whoami) "$(brew --prefix)"/*
        fi
        brew cleanup
        _JobsPrint_Green "🍺🍺🍺完成更新和清理 Homebrew"
        brew doctor
        brew -v
        return 0
    fi
}
# 检查并安装 zsh
check_and_install_zsh() {
    if command -v zsh >/dev/null 2>&1; then
        _JobsPrint_Green "zsh 已经安装，不需要执行任何操作。"
    else
        _JobsPrint_Red "zsh 未安装，正在通过 Homebrew 安装 zsh..."
        check_homebrew
        brew install zsh
    fi
}
# 配置 Home.Ruby 环境变量
_brewRuby(){
    add_line_if_not_exists_bash_profile 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    add_line_if_not_exists_bashrc 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    add_line_if_not_exists_zshrc 'export PATH="/usr/local/opt/ruby/bin:$PATH"'
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 检查并修复 RVM 路径
fix_rvm_path() {
    if [[ ":$PATH:" != *":$HOME/.rvm/bin:"* ]]; then
        export PATH="$HOME/.rvm/bin:$PATH"
        _JobsPrint_Green "修复 RVM 路径设置。"
    fi
}
# 配置 Rbenv.Ruby 环境变量
_rbenRuby(){
    add_line_if_not_exists_bash_profile 'export PATH="$HOME/.rbenv/bin:$PATH"'
    add_line_if_not_exists_bashrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
    add_line_if_not_exists_zshrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 安装 ruby-build 插件
install_ruby_build() {
    if [ ! -d "$(rbenv root)"/plugins/ruby-build ]; then
        _JobsPrint_Green "正在安装 ruby-build 插件..."
        git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    else
        _JobsPrint_Green "ruby-build 插件已安装。"
    fi
}
# 检查并安装 Rbenv
check_Rbenv() {
    if ! command -v rbenv &> /dev/null; then
        _JobsPrint_Green "正在安装 Rbenv..."
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        _rbenRuby
        _JobsPrint_Green "rbenv 安装完成."
        install_ruby_build
        return 1
    else
        _JobsPrint_Green "检测到已安装 Rbenv，准备升级到最新版本..."
        _JobsPrint_Green "正在升级 Rbenv..."
        cd ~/.rbenv && git pull
        _JobsPrint_Green "Rbenv 升级完成."
        install_ruby_build
        return 0
    fi
}
# 利用 Homebrew 安装 Ruby 环境
install_ruby_byBrew(){
    _JobsPrint_Green "利用 Homebrew 安装 Ruby环境（RVM）..."
    brew install ruby
    brew cleanup ruby
}
# 检测当前通过 Rbenv 安装的 Ruby 环境
check_rbenv_version(){
    _JobsPrint_Green '列出当前系统上安装的所有 Ruby 版本'
    rbenv versions
    _JobsPrint_Green '显示当前全局生效的 Ruby 版本'
    rbenv version
}
# 检测当前通过 HomeBrew 安装的 Ruby 环境
check_homebrew_version(){
    brew info ruby
}

install_ruby_byRbenv(){
    _JobsPrint_Green "打印可用的 Ruby 版本列表："
    rbenv install --list | grep -v -e "^[[:space:]]*$"
    read "version?请输入要安装的 Ruby 版本号，或者按回车键安装当前最新版本（未输入版本号，则安装当前最新版本）: "
    if [ -z "$version" ]; then
        _JobsPrint_Green "正在安装最新版本的 Ruby..."
        latest_version=$(rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1)
        rbenv install $latest_version
        rbenv local $latest_version
    else
        if rbenv install --list | grep -q "$version"; then
            _JobsPrint_Green "正在安装 Ruby $version..."
            rbenv install $version
            rbenv local $version
        else
            _JobsPrint_Red "版本号 $version 不存在，请重新输入。"
            exit 1
        fi
    fi
    _rbenRuby
    rbenv rehash
    check_rbenv_version
}

install_ruby_byRVM(){
    open https://get.rvm.io
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
}

check_ruby_install_ByHomeBrew(){
    if brew list --formula | grep -q ruby; then
        _JobsPrint_Green "当前 Ruby 环境是通过 HomeBrew 安装的"
        _JobsPrint_Green "升级 HomeBrew.Ruby 到最新版..."
        brew upgrade ruby
        brew cleanup ruby
        return 1
    else
        _JobsPrint_Red "当前 Ruby 环境不是通过 HomeBrew 安装的"
        return 0
    fi
}

check_ruby_install_ByRbenv(){
    if check_rbenv_installed_ruby; then
        upgrade_current_rbenv_ruby
        _JobsPrint_Green "当前 Ruby 环境是通过 Rbenv 安装的"
        return 1
    else
        _JobsPrint_Red "当前 Ruby 环境不是通过 Rbenv 安装的，无法升级"
        return 0
    fi
}

check_ruby_install_ByRVM(){
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        _JobsPrint_Green "当前 Ruby 环境是通过RVM官方推荐的方式安装的"
        return 1
    else
        _JobsPrint_Red "当前 Ruby 环境不是通过RVM官方推荐的方式安装的"
        return 0
    fi
}

check_ruby_environment() {
    if [[ $(which ruby) == "/usr/bin/ruby" ]]; then
        _JobsPrint_Red "当前Ruby环境为MacOS自带的Ruby环境（阉割版）"
    else
        _JobsPrint_Red "检测到您的系统上存在非系统自带的 Ruby 环境。"
        check_rbenv_version
        check_homebrew_version
        read "confirm_delete?是否删除这些非系统 Ruby 环境？(按 Enter 键继续，输入任意字符删除并重新安装): "
        if [[ -n "$confirm_delete" ]]; then
            _JobsPrint_Red "正在删除非系统 Ruby 环境..."
            uninstall_Ruby
        fi
    fi
    setup_ruby_environment
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        _JobsPrint_Green "当前Ruby环境是通过RVM官方推荐的方式安装的"
    fi

    _JobsPrint_Green "查看本机的 Ruby 环境安装目录："
    which -a ruby
    _JobsPrint_Green "打印已安装的 Ruby 版本："
    rvm list
    _JobsPrint_Green "当前使用的 Ruby 版本："
    ruby -v
    
    _JobsPrint_Green "清理 RVM 环境..."
    rvm cleanup all
    _JobsPrint_Green "RVM 环境清理完成。"
}

setup_ruby_environment(){
    choice=$(printf "1. 使用 Homebrew 安装\n2. 使用 rbenv 安装\n3. 使用 RVM 官方推荐的方式进行安装" | fzf --prompt "请选择 Ruby 的安装方式：")
    case $choice in
    "1. 使用 Homebrew 安装")
        install_ruby_byBrew
        _JobsPrint_Green "🍺🍺🍺 Homebrew.Ruby安装成功"
        check_ruby_install_ByHomeBrew
        ;;
    "2. 使用 rbenv 安装")
        install_ruby_byRbenv
        _JobsPrint_Green "🍺🍺🍺 Rbenv.Ruby安装成功"
        check_ruby_install_ByRbenv
        ;;
    "3. 使用 RVM 官方推荐的方式进行安装")
        install_ruby_byRVM
        _JobsPrint_Green "🍺🍺🍺 RVM.Ruby安装成功"
        check_ruby_install_ByRVM
        if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
            _JobsPrint_Green "正在使用 rvm get stable --auto-dotfiles 修复 PATH 设置..."
            rvm get stable --auto-dotfiles
        fi
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新输入。"
        setup_ruby_environment
        ;;
    esac
}
# 删除指定版本的 Ruby 环境
remove_ruby_environment() {
    local version=$1
    _JobsPrint_Red "开始删除 Ruby 环境：$version"

    if check_ruby_install_ByHomeBrew; then
        brew uninstall --force ruby 2>/dev/null || true
        sudo sed -i '' '/rvm/d' ~/.bash_profile ~/.bashrc ~/.zshrc 2>/dev/null || true
    fi

    if check_ruby_install_ByRbenv; then
        sudo rbenv uninstall -f $version 2>/dev/null || true
    fi

    if check_ruby_install_ByRVM; then
        _JobsPrint_Red "Uninstalling RVM..."
        rvm implode 2>/dev/null || true
        _JobsPrint_Red "Removing any remaining RVM-related directories..."
        rm -rf ~/.rvm 2>/dev/null || true
        _JobsPrint_Green "Uninstallation complete."
    fi

    _JobsPrint_Green "Ruby 环境 $version 删除完成"
}

remove_all_ruby_environments() {
    _JobsPrint_Red "开始删除所有已安装的 Ruby 环境"
    for version in $(rbenv versions --bare); do
        remove_ruby_environment $version
    done
    _JobsPrint_Green "所有 Ruby 环境已删除"
}

uninstall_Ruby(){
    read "choice?是否删除所有已安装的 Ruby 环境？(y/n): "
    case $choice in
        [Yy]* )
            remove_all_ruby_environments
            ;;
        [Nn]* )
            _JobsPrint_Red "取消删除 Ruby 环境"
            ;;
        * )
            _JobsPrint_Red "无效的选项，取消删除 Ruby 环境"
            ;;
    esac
}
# 检查当前 Ruby 环境是否是通过 Rbenv 安装的
check_rbenv_installed_ruby() {
    local version
    local rbenv_version

    version=$(ruby -v 2>/dev/null | awk '{print $2}' || true)
    rbenv_version=$(rbenv version 2>/dev/null | awk '{print $1}' || true)

    if [ -n "$version" ] && [ -n "$rbenv_version" ]; then
        if [ "$version" = "$rbenv_version" ]; then
            _JobsPrint_Green "当前 Ruby 环境是通过 Rbenv 安装的"
            return 0
        else
            _JobsPrint_Red "当前 Ruby 环境不是通过 Rbenv 安装的"
            return 1
        fi
    else
        _JobsPrint_Red "无法获取 Ruby 版本信息"
        return 1
    fi
}
# 升级当前 Rbenv.Ruby 环境
upgrade_current_rbenv_ruby() {
    _JobsPrint_Green "开始升级当前 Ruby 环境"
    rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1 | xargs rbenv install -s
    _JobsPrint_Green "升级完成"
}
# 检查并安装 Gem
check_and_setup_gem() {
    if command -v gem &> /dev/null; then
        _JobsPrint_Green "Gem 已安装."
        read "reinstall_gem?是否卸载并重新安装 Gem? (按 Enter 键继续，输入任意字符则卸载并重新安装): "
        if [[ -n "$reinstall_gem" ]]; then
            _JobsPrint_Green "正在卸载 Gem..."
            sudo gem uninstall --all --executables gem
            _JobsPrint_Green "Gem 已成功卸载."
            _JobsPrint_Green "正在重新安装 Gem..."
            brew install ruby
            _JobsPrint_Green "Gem 安装成功."
            _JobsPrint_Green "升级 Gem 到最新版本..."
            sudo gem update --system
            _JobsPrint_Green "Gem 已升级到最新版本."
            _JobsPrint_Green "更新 Gem 管理的所有包..."
            sudo gem update
            _JobsPrint_Green "🍺🍺🍺所有包已更新."
        else
            _JobsPrint_Green "不卸载 Gem，跳过安装步骤."
            _JobsPrint_Green "升级 Gem 到最新版本..."
            sudo gem update --system
            _JobsPrint_Green "Gem 已升级到最新版本."
            _JobsPrint_Green "更新 Gem 管理的所有包..."
            sudo gem update
            _JobsPrint_Green "🍺🍺🍺所有包已更新."
        fi
    else
        _JobsPrint_Red "Gem 未安装."
        _JobsPrint_Green "正在安装 Gem..."
        brew install ruby
        _JobsPrint_Green "Gem 安装成功."
        _JobsPrint_Green "升级 Gem 到最新版本..."
        sudo gem update --system
        _JobsPrint_Green "🍺🍺🍺 Gem 已升级到最新版本."
        _JobsPrint_Green "更新 Gem 管理的所有包..."
        sudo gem update
        _JobsPrint_Green "🍺🍺🍺所有 Gem 包已更新."
    fi

    _JobsPrint_Green "重建所有 Gem 扩展..."
    gem pristine --all
    _JobsPrint_Green "所有 Gem 扩展已重建。"

    _JobsPrint_Green "使用全局 gemset..."
    rvm gemset use global

    _JobsPrint_Green "安装 bundler..."
    gem install bundler

    _JobsPrint_Green "运行 bundle install..."
    bundle install

    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        _JobsPrint_Green "本地当前的 IP 在中国大陆境内."
        _JobsPrint_Green "更换 Gem 源为 https://gems.ruby-china.com/ ..."
        gem sources --remove https://rubygems.org/
        gem sources --add https://gems.ruby-china.com/
        _JobsPrint_Green "Gem 源已更换."
        _JobsPrint_Green "更新 Gem 源列表缓存..."
        gem sources --update
        _JobsPrint_Green "Gem 源列表缓存已更新."
    else
        _JobsPrint_Green "本地当前的 IP 不在中国大陆境内，将移除 Gem 源 https://gems.ruby-china.com/ ..."
        gem sources --remove https://gems.ruby-china.com/
        _JobsPrint_Green "Gem 源已移除."
        _JobsPrint_Green "还原默认 Gem 源..."
        gem sources --add https://rubygems.org/
        _JobsPrint_Green "默认 Gem 源已还原."
        _JobsPrint_Green "更新 Gem 源列表缓存..."
        gem sources --update
        _JobsPrint_Green "Gem 源列表缓存已更新."
    fi

    _JobsPrint_Green "执行 Gem 清理工作..."
    sudo gem clean
    _JobsPrint_Green "Gem 清理工作已完成."
}
# 卸载 CocoaPods
remove_cocoapods() {
    _JobsPrint_Green "查看本地安装过的 CocoaPods 相关内容："
    gem list --local | grep cocoapods

    _JobsPrint_Red "确认删除 CocoaPods？确认请输入 'y'，取消请回车"
    read -n 1 sure

    if [[ $sure == "y" ]]; then
        _JobsPrint_Green "开始卸载 CocoaPods"
        for element in $(gem list --local | grep cocoapods | cut -d" " -f1)
        do
            _JobsPrint_Green "正在卸载 CocoaPods 子模块：$element ......"
            sudo gem uninstall $element
        done
    else
        _JobsPrint_Green "取消卸载 CocoaPods"
    fi
}
# 更新 CocoaPods 本地库
update_cocoapods() {
    _JobsPrint_Green "更新 CocoaPods 本地库..."
    pod repo update
    _JobsPrint_Green "CocoaPods 本地库已更新."
}
# 安装 CocoaPods
install_cocoapods() {
    choice=$(printf "1. 安装稳定版 CocoaPods\n2. 安装预览版 CocoaPods" | fzf --prompt "请选择安装方式：")
    case $choice in
    "1. 安装稳定版 CocoaPods")
        _JobsPrint_Green "正在安装稳定版 CocoaPods..."
        sudo gem install cocoapods
        ;;
    "2. 安装预览版 CocoaPods")
        _JobsPrint_Green "正在安装预览版 CocoaPods..."
        sudo gem install cocoapods --pre
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_cocoapods
        ;;
    esac
    gem install cocoapods-deintegrate cocoapods-downloader cocoapods-trunk cocoapods-try
    update_cocoapods
    pod cache clean --all
}
# 检查并安装 CocoaPods
check_and_setup_cocoapods() {
    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        _JobsPrint_Green "本地当前的 IP 在中国大陆境内."
        _JobsPrint_Green "选用清华大学的 CocoaPods 镜像..."
        pod repo remove master
        pod repo add master https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git
    else
        _JobsPrint_Green "本地当前的 IP 不在中国大陆境内，不需要更换 CocoaPods 镜像."
    fi
    if command -v pod &> /dev/null; then
        remove_cocoapods
    else
        _JobsPrint_Red "CocoaPods 未安装."
    fi
    _JobsPrint_Green "开始安装 CocoaPods..."
    install_cocoapods
    _JobsPrint_Green "检查 CocoaPods 的安装是否成功..."
    gem which cocoapods
    # 解决pod 命令只在特定的 Ruby 版本下可用
    # 设置 Ruby 版本为当前正在使用的版本
    rbenv global $(rbenv version-name)
    # 重新编译 rbenv
    rbenv rehash
    # 检查 pod 命令是否可用
    pod --version
    pod search Masonry
}
# 主流程
jobs_logo
self_intro
prepare_environment # 准备前置环境
check_xcode_and_tools # 检查 Xcode 和 Xcode Command Line Tools
check_and_update_fzf # 检查并安装/更新 fzf
check_homebrew # 检查并安装 Homebrew
check_and_install_zsh # 检查并安装 zsh
check_Rbenv # 检查并安装 Rbenv
check_ruby_environment
fix_rvm_path # 检查并修复 RVM 路径
check_and_setup_gem # 检查并安装 Gem
check_and_setup_cocoapods # 检查并安装 CocoaPods
