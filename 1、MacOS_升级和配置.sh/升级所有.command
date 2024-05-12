#!/bin/bash

# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh
filePath=$(dirname $0)/$(basename $0)
echo "我在这里：$filePath" 

# 定位📌于该文件的垂直文件夹
folderPath=$(dirname $0)
cd folderPath
# 加权限
fileFullName=$(basename $0)
chmod u+x $fileFullName

echo "============================ Command Line Tools ============================\n"
echo "查看软件更新列表"
softwareupdate --list
echo "安装所有更新"
softwareupdate --install -a
echo "============================ brew ============================\n"
brew update
brew cleanup
echo "============================ gem ============================\n"
gem update
gem clean
echo "============================ pod 要进入podfile文件的同一层 ============================\n"
pod update
pod repo update --verbose # 详细显示进行的步骤