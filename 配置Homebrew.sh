#! /bin/sh

# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh

echo "正在安装Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "安装一些插件"
brew install tree
brew install carthage
brew install php
brew install mysql
brew install tomcat
brew install maven
brew install java
brew install -g node
brew install nvm
brew install docker
brew install python3
brew install openssl
brew install wget
brew install heroku
brew install git
brew install autojump
brew install Mongodb
brew install Nginx
brew install iTerm2
brew install xz
brew install pkg-config
brew install readline
brew install coreutils
brew install lrzsz
brew install clang-format
brew install git-flow
brew install Autojump
brew install caskroom/cask/brew-cask
brew install tomcat
brew install ruby
brew install ffmpeg
brew install watchman
brew install gnupg
brew install oclint
brew install yarn # 或者 brew install yarn --without-node 如果您使用 nvm 或类似的东西，您应该排除安装 Node.js 以便使用 nvm 的 Node.js 版本

brew install cask
brew cask install cakebrew
brew cask install launchrocket
