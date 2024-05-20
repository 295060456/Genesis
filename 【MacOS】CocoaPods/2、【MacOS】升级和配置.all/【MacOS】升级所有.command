#!/bin/bash
# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh

# 格式化打印输出
print() {
    local mainMessage=$1
    local subMessage=$2
    echo -e "\033[1;31m${mainMessage}\033[0m"
    echo -e "${subMessage}"
}

# 安装或更新 MacPorts
install_or_update_macports() {
    # 检查是否已经安装了 MacPorts
    if command -v port >/dev/null 2>&1; then
        print "MacPorts 已经安装，正在更新到最新版本..." ""
        sudo port -v selfupdate
    else
        # 如果未安装，则执行安装步骤
        print "未安装 MacPorts，正在执行安装步骤..." ""
        curl -O https://distfiles.macports.org/MacPorts/MacPorts.tar.gz && \
        tar xf MacPorts.tar.gz && \
        cd MacPorts-* && \
        ./configure && \
        make && \
        sudo make install && \
        sudo port -v selfupdate
    fi

    # 配置环境变量
    export PATH=/opt/local/bin:$PATH
    export PATH=/opt/local/sbin:$PATH

    # 提示安装或更新完成
    print "MacPorts 安装或更新完成，并已配置环境变量。" ""
}

# 定位于该文件的垂直文件夹
folderPath=$(dirname $0)
cd $folderPath
# 定位该文件
filePath=$(dirname $0)/$(basename $0)
print "当前脚本文件位于：" "$filePath"
# 获取当前脚本的文件名，去掉路径部分，只保留文件名（带后缀）
fileFullName=$(basename $0)
# 加权限
chmod u+x $fileFullName

echo "============================ MacOS.Git ============================"
# 查看系统当前的 Git
print "查看系统当前的 Git：" "$(git --version)"
# 打开MacOS 自带的 Git 可执行文件的路径
open /usr/bin/git
# 检查是否已经安装了 MacPorts
install_or_update_macports
# 利用MacPorts升级 MacOS 自带的 Git
sudo port install git
echo "============================ Homebrew.Git ============================"
# 查看通过 Homebrew 安装的 Git 的安装路径
print "查看通过 Homebrew 安装的 Git 的安装路径：" "$(brew list git)"
# 打开通过 brew 安装的 Git 的安装路径
open /opt/homebrew/Cellar/git
# 升级 brew 安装的 Git
brew upgrade git
echo "============================ Command Line Tools ============================"
print "查看软件更新列表：" "$(softwareupdate --list)"
print "安装所有更新：" "$(softwareupdate --install -a)"



#echo "============================ Homebrew ============================\n"
#brew update
#brew cleanup
#echo "============================ gem ============================\n"
#gem update
#gem clean
#echo "============================ pod 要进入podfile文件的同一层 ============================\n"
#pod update
#pod repo update --verbose # 详细显示进行的步骤
