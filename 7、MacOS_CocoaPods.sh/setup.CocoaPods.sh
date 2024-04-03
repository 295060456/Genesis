#!/bin/bash

prepare_environment() {
    echo "先做一些准备工作..."
    # 显示Mac OS X上的隐藏文件和文件夹
    defaults write com.apple.Finder AppleShowAllFiles YES
    # 允许从任何来源打开应用（需要管理员权限）
    sudo spctl --master-disable
}

check_xcode_and_tools() {
    # 检查是否安装了完整版的 Xcode 和 Xcode Command Line Tools
    if ! command -v xcodebuild &> /dev/null; then
        echo "Xcode 未安装，正在前往 App Store 下载并安装 Xcode，请按照提示进行安装。"
        # 打开 App Store 下载页面
        open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"
        exit 1
    fi

    # 检查是否安装了 Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null; then
        echo "Xcode Command Line Tools 未安装，正在尝试安装..."
        # 安装 Xcode Command Line Tools
        xcode-select --install
        echo "请按照提示进行安装，安装完成后再次运行此脚本。"
        exit 1
    fi

    echo "🍺🍺🍺Xcode 和 Xcode Command Line Tools 均已安装。"
}

check_homebrew() {
    # 检测是否已经安装了 Homebrew
    if ! command -v brew &> /dev/null; then
        echo "brew 未安装，开始安装..."
        open https://brew.sh/
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew 已经安装，跳过安装步骤。"
        echo "检查更新 Homebrew..."
        brew update
        echo "升级 Homebrew 和由 Homebrew 管理的程序包..."
        brew upgrade
        echo "正在执行 Homebrew 清理工作..."
        sudo chown -R $(whoami) /usr/local/Cellar/
        sudo chown -R $(whoami) $(brew --prefix)/*
        brew cleanup
        echo "🍺🍺🍺完成更新和清理 Homebrew"
        brew doctor
        brew -v
    fi
}

setup_ruby_environment() {
    echo "Ruby环境变量设置"
    # 清除可能存在的旧配置
    sed -i '' '/ruby/d' ~/.bash_profile ~/.bashrc ~/.zshrc
    # 添加到 ~/.bash_profile
    echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    open ~/.bash_profile
    # 添加到 ~/.zshrc
    echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    open ~/.zshrc
}

check_ruby_environment() {
    # 检查当前Ruby环境是否是MacOS自带的
    if [[ $(which ruby) == "/usr/bin/ruby" ]]; then
        echo "当前Ruby环境为MacOS自带的Ruby环境（阉割版）"
        echo "利用 Homebrew 安装 Ruby环境（RVM）..."
        brew install ruby
        brew cleanup ruby
        echo "🍺🍺🍺Homebrew.Ruby安装成功"
    else
        echo "检测到您的系统上存在非系统自带的 Ruby 环境。"
        read -p "是否删除这些非系统 Ruby 环境？(按 Enter 键继续，输入任意字符删除并重新安装): " confirm_delete
        if [[ -n "$confirm_delete" ]]; then
            echo "正在删除非系统 Ruby 环境..."
            # 删除非系统 Ruby 环境
            brew uninstall --force ruby
            # 清理相关配置文件中与 RVM 相关的行
            sed -i '' '/rvm/d' ~/.bash_profile ~/.bashrc ~/.zshrc
            echo "非系统 Ruby 环境已删除。"
            # 安装 Ruby 环境
            setup_ruby_environment
        fi
    fi

    # 检查当前Ruby环境是否是通过HomeBrew安装的
    if brew list --formula | grep -q ruby; then
        echo "当前Ruby环境是通过HomeBrew安装的"
        echo "升级HomeBrew.ruby到最新版..."
        brew upgrade ruby
        brew cleanup ruby
    fi

    # 检查当前Ruby环境是否是通过RVM官方推荐的方式安装的
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        echo "当前Ruby环境是否是通过RVM官方推荐的方式安装的"
    fi

    echo "查看本机的ruby环境安装目录："
    which -a ruby
    echo "打印已安装的 Ruby 版本："
    rvm list
    echo "当前使用的 Ruby 版本："
    ruby -v
}

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

update_cocoapods() {
    echo "更新 CocoaPods 本地库..."
    pod repo update
    echo "CocoaPods 本地库已更新."
}

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
    pod search Masonry
}

prepare_environment
check_xcode_and_tools
check_homebrew
check_ruby_environment
check_and_setup_gem
echo "现在准备安装CocoaPods..."
check_and_setup_cocoapods

