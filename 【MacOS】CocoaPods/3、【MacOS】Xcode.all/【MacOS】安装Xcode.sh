#!/bin/bash

echo $"打开Apple Develop官网下载页面"
open -a "/Applications/Safari.app" 
https://developer.apple.com/develop/
https://support.apple.com/zh_CN/downloads
https://developer.apple.com/

echo 安装xcode-install
sudo gem install -n /usr/local/bin xcode-install
echo 查看可以安装的Xcode列表
xcversion list
echo 输入需要安装的Xcode版本号
read name # 把键盘输入放入变量name
xcversion install $name
echo 查看可以安装的模拟器列表
xcversion simulators
read name # 把键盘输入放入变量name
echo 输入需要安装的Xcode模拟器版本号
simulators_setup=$"xcversion simulators --install="$"iOS "$name
eval $simulators_setup
