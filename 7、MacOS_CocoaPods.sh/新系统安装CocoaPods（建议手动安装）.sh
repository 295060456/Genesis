#! /bin/sh
# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh

<<'COMMENT'
资料来源

https://www.jianshu.com/p/e36c0a1c6b49
https://www.jianshu.com/p/00ef52c4cd3f
https://blog.csdn.net/u014163312/article/details/124784377
https://juejin.cn/post/6950518188798902286
https://www.jianshu.com/p/c459ecfaf9db
https://www.jianshu.com/p/f3e4ae8e14a6
https://mac.install.guide/ruby/index.html
https://mac.install.guide/faq/do-not-use-mac-system-ruby/index.html
https://www.jianshu.com/p/6ddeade2c565
https://www.shuzhiduo.com/A/qVdeEK1gdP/
https://blog.csdn.net/shentian885/article/details/113548167
COMMENT

# Mac安装Ruby版本管理器（RVM）
echo "安装流程： Command Line Tools->Brew->Ruby->Gem->CocoaPods \n"

echo "============================= 一些准备工作 =============================\n"
echo "显示Mac OS X上的隐藏文件和文件夹"
defaults write com.apple.Finder AppleShowAllFiles YES
echo "安装Xcode Command Line Tools"
xcode-select —install
echo "Mac OS 打开任何来源"
sudo spctl --master-disable
echo "============================ 升级和安装 Command Line Tools ============================\n"
echo "方式1：更新"
echo "查看软件更新列表"
softwareupdate --list
echo "安装所有更新"
softwareupdate --install -a
# echo "方式2：删除后重新下载"
echo "亦可前往👉🏻苹果官网手动下载：https://developer.apple.com/download/more/ 【个别地区如柬埔寨，是禁止对其进行访问，此时需要开启VPN，将IP置于美国，方可访问】"
# sudo rm -rf /Library/Developer/CommandLineTools
# xcode-select --install
echo "查看当前 Command Line Tools 的版本"
llvm-gcc --version
echo "============================正在安装Homebrew...============================\n"
# 检测是否已经安装了brew
if ! command -v brew &> /dev/null
then
    echo "brew 未安装，开始安装..."
    open https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ## brew环境变量设置
    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    # open /Users/$(whoami)/.zprofile
    # eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "brew 已经安装，跳过安装步骤。"
    ## brew 升级
    brew update
    brew doctor
    brew -v
fi

echo "安装一些由brew管理的包"
brew install llvm
brew install wget
brew install cake
#brew install clang-format
#brew install docker
#brew install git
#brew install maven
#brew install openjdk
#brew install tomcat
#brew install yarn
#...
echo "============================ ❤️开始安装RVM❤️ ============================\n"
echo "开始安装mpapis公钥。但是，正如安装页面所记录的，您可能需要gpg。Mac OS X不附带gpg，因此在安装公钥之前，需要安装gpg。这里用Homebrew安装了gpg"
brew install gnupg
echo "安装完gpg之后、正在安装mpapis公钥..."

# 解决 gpg: command not found
brew uninstall gpg gnupg gnupg2
echo "正在删除 /usr/local/etc/gnupg"
rm -rf /usr/local/etc/gnupg
echo "正在删除 /usr/local/etc/gnupg/scdaemon.conf"
rm -rf /usr/local/etc/gnupg/scdaemon.conf
brew reinstall gpg #gpg、gnupg、gnupg2 是一样的
brew link gpg

# Homebrew 不会自动移除旧版本的软件包,它会帮你释放出来的磁盘空间
brew cleanup

echo "============================ RVM的前导工作 ============================\n"
open -a "/Applications/Safari.app" https://rvm.io/rvm/security
echo "详情请参阅：https://rvm.io/rvm/security \n
在 RVM，我们非常重视安全性，并对1.26.0所有版本和rvm-installer脚本进行加密签名（自版本以来），以确保其来自真实来源。\n
我们使用 GPG 进行签名，两者都gpg应该gpg2没问题。\n
有时gpg从远程服务器下载密钥时会出现问题，gpg2如果它可用于您的系统，则使用它可能会更好。\n
然而据报道，gpg2在 2.1.17 版本中也受到此类问题的影响。我们建议您将其降级或升级到较新的版本。\n
409B6B1796C275462A1703113804BB82D39DC0E3 # mpapis \n
409B6B1796C275462A1703113804BB82D39DC0E3 # mpapis \n
7D2BAF1CF37B13E2069D6956105BD0E739499BDB # pkuczynski \n
作为第一步，在尝试安装 RVM 之前，您应该安装gpg2并导入以上👆🏻这些密钥: \n
如果密钥服务器遇到问题，有下列👇🏻服务器进行替换方案 \n
hkp://ipv4.pool.sks-keyservers.net(官网推荐) \n
hkp://pgp.mit.edu(官网推荐) \n
hkp://keyserver.pgp.com(官网推荐) \n
hkp://pool.sks-keyservers.net(官网推荐) \n
hkp://keys.gnupg.net \n"

gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg --keyserver hkp://keyserver.pgp.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

echo "防火墙问题 \n
如果导入 gpg 密钥永远挂起，那可能是防火墙问题。如果您位于防火墙后面，请确保打开传出端口 11371 (TCP)。\n
IPv6 问题 \n
已知问题是，如果您的主机未启用 IPv6（通常发生在 docker 容器中），某些关键服务器可能无法连接。 \n
您可以通过将以下行添加到以下行来禁止 gpg 的内部dirmngr使用 IPv6 ~/.gnupg/dirmngr.conf：禁用 IPv6 \n
确保没有现有dirmngr进程仍在运行（如果有，则将其杀死），然后gpg --recv-keys按照最初指定的方式再次尝试命令，它应该可以工作。\n
请注意，这里的风险是，如果您稍后确实需要 IPv6，您可能会忘记此设置，但对于大多数人来说，这不太可能。\n"

echo "【定期刷新Key】定期刷新密钥状态以确保它们都没有被撤销是一种很好的做法。\n
您也可以将其添加到 cron。\n"
gpg --refresh-keys
echo "删除rvm"
rvm implode

echo "============================ 关于Ruby环境 ============================ \n"
echo "RVM是一个命令行工具，它允许您轻松地安装，管理和使用从解释器到多组宝石的多个Ruby环境。\n
使用Ruby原因：\n
1、虽然 macOS 自带了一个 Ruby 环境，但是是系统自己使用的，所以权限很小，只有 system; \n
2、而/Library 目录是 root 权限,所以很多会提示无权限; \n
3、使用自带Ruby更新,管理不方便; \n
4、一系列无原因的报错""; \n

### MacOS Monterey 中的系统 Ruby 是 Ruby 2.6.8(相对较老的版本); ###
### 如果您刚开始使用 Ruby，请使用 Homebrew 安装并使用 Ruby 最新版 进行项目; ###
### 当您开始构建另一个项目时，可能是时候安装一个版本管理器，以便您可以使用不同的 Ruby 版本来处理项目; ###
### 在您安装了另一个版本的 Ruby 之后，将系统 Ruby 留在原处。不要试图删除它。某些应用程序（或 Apple 的系统软件）可能希望找到它; ###
### Mac OS 自带 Gem; ###
"

echo "https://mac.install.guide/ruby/13.html"
open "https://mac.install.guide/ruby/13.html"
brew install ruby

echo "安装最新版本的Ruby的RVM。如果安装失败则参考👉🏻https://ruby-china.org/topics/40922"
open "https://ruby-china.org/topics/40922"
echo "自动安装 RVM"
\curl -sSL https://get.rvm.io | bash -s stable --ruby --auto-dotfiles
#curl -L get.rvm.io | bash -s stable --ruby --auto-dotfiles
echo "手动安装 RVM"
echo "解决：[zsh: command not found: RVM]\n
参考文献：https://blog.csdn.net/shentian885/article/details/113548167
"
echo "下载RVM"
git clone https://github.com/rvm/rvm.git
echo "安装RVM \n
打开rvm/bin文件夹，双击rvm-installer \n"
open rvm/bin
echo "启用RVM指令 \n"
source ~/.rvm/scripts/rvm
open ~/.rvm/scripts/rvm

echo "通过手动输入版本号来切换ruby"
echo "检查使用哪个版本的Ruby OS X"
ruby -v
rvm automount
echo "查看当前已安装 ruby 版本，检查是否上述动作安装成功"
rvm list
echo "检查使用的是否是系统自带的Ruby还是我们自定义的Ruby环境"
echo "查看本机的ruby环境安装目录"
which -a ruby
echo "如果您使用的是Mac OS系统自带的Ruby环境，OS X将回应： /usr/bin/ruby  || 如果您使用的是Gem环境安装的Ruby环境，OS X将回应： /usr/local/opt/ruby/bin/ruby"
which ruby
# 某些时候因使用 brew 安装工具导致 ruby 环境错乱，执行 pod install 时报错提示找不到 gem 可执行文件的解决方案👇🏻
echo "重新安装（升级） Ruby 环境（默认安装最新版本）"
rvm reinstall ruby --disable-binary
# Ruby环境变量设置
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

open ~/.bash_profile
open ~/.zshrc

brew cleanup ruby
echo "============================ 在Ruby环境下安装 Gem =============================\n"
echo "ruby 是一种语言，是某些软件包代码的执行环境。而Gem是管理这些基于ruby程序的程序。"
echo "Mac OS 自带Gem"
echo "列出安装源"
gem sources -l
# 如果人在国内那么就需要更换Gem源
# gem sources --remove https://rubygems.org/
# gem sources --add https://gems.ruby-china.com/
echo "更新安装源缓存"
gem sources -u
echo "更新Gem本身"
#sudo gem update --system
sudo gem update --system -n /usr/local/bin
sudo gem install -n /usr/local/bin rubygems-update
echo "查看下目前的Gem的版本"
gem -v
echo "更新所有程序包"??
gem update
echo "清理gem"
sudo gem clean
echo "============================ 使用Gem安装CocoaPods ============================\n"
sudo gem install cocoapods -n /usr/local/bin
#sudo gem install cocoapods --pre # 如果你要选择预览版CocoaPods，请使用这一句
echo "如果安装了多个Xcode使用下面的命令选择（一般需要选择最近的Xcode版本）"
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
echo "============================ 安装CocoaPods本地库 =============================\n"
git clone https://github.com/CocoaPods/Specs.git ~/.cocoapods/repos/trunk
# 如果在国内那么就选用清华大学的镜像地址
## git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git  ~/.cocoapods/repos/trunk
pod repo update
echo "☕️检查一下安装的成果☕️"
pod search Masonry
# 手动安装
# cocoapod文件：https://github.com/CocoaPods/Specs 把下载的文件文件夹名改为trunk，并放在路径~/.cocoapods/repos下
# git隐藏文件夹：https://github.com/ShaeZhuJiu/CocoaPadHiddenFileGit.git 把.git.zip解压缩然后将.git隐藏文件放在~/.cocoapods/repos/trunk路径下
