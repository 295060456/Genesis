# 配置Homebrew环境
export PATH="/opt/homebrew/bin:$PATH"

# 配置rbenv环境
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" # 初始化 rbenv

# 设置 Ruby 环境变量
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# 配置 JDK 环境变量
# export JAVA_HOME=/Users/$(whoami)/Library/Java/JavaVirtualMachines/corretto-20.0.2.1/Contents/Home
export JAVA_HOME=/Users/$(whoami)/Library/Java/JavaVirtualMachines/corretto-18.0.2/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
# 配置 OpenJDK 环境变量
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# 配置Android环境
export ANDROID_HOME=/Users/$(whoami)/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH # Android 模拟器
# 配置 Gradle 环境变量
export PATH="/Users/$(whoami)/Documents/Gradle/gradle-8.7/bin:$PATH"

# 配置Flutter环境
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

# 配置TeX环境
export PATH="/Library/TeX/texbin:$PATH"

# 配置mongodb环境
export PATH=/usr/local/mongodb/bin:$PATH

# 配置Go环境
export GOPATH=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# 每次打开Mac终端的时候，默认定位📌当前路径为系统桌面
#【❤️细节处理❤️】cd ~/Desktop 这么写的话，虽然新开的Mac终端定位📌于系统桌面，但是VSCode这个IDE里面的终端路径定位📌就不是工程当前目录
cd ./Desktop

# source ~/.bash_profile


