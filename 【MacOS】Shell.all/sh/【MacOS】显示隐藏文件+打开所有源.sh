#!/bin/bash

# 显示Mac OS X上的隐藏文件和文件夹
defaults write com.apple.Finder AppleShowAllFiles YES
# 允许从任何来源打开应用（需要管理员权限）
sudo spctl --master-disable
