# 配置Homebrew环境
# ARM64
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
# x86_64
export PATH="/usr/local/bin:$PATH""
export PATH="/usr/local/sbin:$PATH""
eval "$(/bin/brew shellenv)"

# 在配置文件中同时配置 rbenv 和 rvm 的路径会产生冲突。
#rbenv 和 rvm 都是用于管理 Ruby 版本的工具，但它们的工作方式不同，并且在系统路径和环境变量的配置上会互相干扰。

# 设置 Ruby 环境变量

## 配置rbenv.Ruby环境
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" # 初始化 rbenv

## RVM.Ruby(不能与其他 Ruby 共存)
# export PATH="$HOME/.rvm/bin:$PATH"

## Homebrew.Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
## 确保在编译和链接依赖于 Ruby 库的程序时，链接器能够找到并使用 Homebrew.Ruby 库文件。
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include" # 设置 CPPFLAGS 环境变量，以指定编译器在预处理和编译 C 或 C++ 源代码时搜索头文件的目录
export CFLAGS="-I/opt/homebrew/opt/ruby/include" # 设置 CFLAGS 环境变量，以指定编译器在编译 C 或 C++ 源代码时搜索头文件的目录
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib" # 设置 LDFLAGS 环境变量，以指定链接器在编译和链接 C 或 C++ 程序时搜索库文件的目录
## 确保 pkg-config 工具在需要 Ruby 库的编译和链接信息时，能够找到 Homebrew.Ruby 的配置文件
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# 配置 JDK 环境变量
# export JAVA_HOME=/Users/$(whoami)/Library/Java/JavaVirtualMachines/corretto-20.0.2.1/Contents/Home
export JAVA_HOME=/Users/$(whoami)/Library/Java/JavaVirtualMachines/corretto-18.0.2/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
# 配置 OpenJDK 环境变量
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# 配置 Android 环境
export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH # Android 模拟器
# 配置 Gradle 环境变量
export PATH="/Users/$(whoami)/Documents/Gradle/gradle-8.7/bin:$PATH"

# 配置 Flutter 环境
# 这里的路径即为Dart.Flutter.SDK名下的为bin目录（主要取决于你下载的SDK的绝对路径）
export PATH=/Users/$(whoami)/Documents/GitHub/Flutter.SDK/flutter/bin:$PATH
#【相关阅读：Flutter切换源】https://juejin.cn/post/7204285137047257148
# 防止域名在中国大陆互联网环境下的被屏蔽
# export PUB_HOSTED_URL=https://pub.flutter-io.cn # 告诉了 Dart.Flutter 和 Dart 的包管理器 pub 在执行 pub get 或 pub upgrade 命令时使用备用仓库而不是默认的官方仓库。
# Flutter官方正版源（温馨提示：海外IP访问大陆源，不开VPN会拉取失败）
export PUB_HOSTED_URL=https://pub.dartlang.org
# FLUTTER_STORAGE_BASE_URL 告诉了 Dart.Flutter SDK 在需要下载二进制文件或工具时从备用存储库获取，而不是从默认的 Google 存储库获取。
# export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn # Flutter中国（七牛云）
export FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com # Flutter官方的 Google Cloud 存储库地址

# 配置 FVM 环境
export PATH="$PATH":"$HOME/.pub-cache/bin"

# 配置 TeX 环境
export PATH="/Library/TeX/texbin:$PATH"

# 配置 mongodb 环境
export PATH=/usr/local/mongodb/bin:$PATH

# 配置 Go 环境
export GOPATH=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# 每次打开Mac终端的时候，默认定位📌当前路径为系统桌面
#【❤️细节处理❤️】cd ~/Desktop 这么写的话，虽然新开的Mac终端定位📌于系统桌面，但是VSCode这个IDE里面的终端路径定位📌就不是工程当前目录
cd ./Desktop

# source ~/.bash_profile


