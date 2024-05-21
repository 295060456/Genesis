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

clear
BLACK="\033[0;30m"  
DARK_GRAY="\033[1;30m"  
BLUE="\033[0;34m"  
LIGHT_BLUE="\033[1;34m"  
GREEN="\033[0;32m"  
LIGHT_GREEN="\033[1;32m"  
CYAN="\033[0;36m"  
LIGHT_CYAN="\033[1;36m"  
RED="\033[0;31m"  
LIGHT_RED="\033[1;31m"  
PURPLE="\033[0;35m"  
LIGHT_PURPLE="\033[1;35m"  
BROWN="\033[0;33m"  
YELLOW="\033[0;33m"  
LIGHT_GRAY="\033[0;37m"  
WHITE="\033[1;37m" 
NC="\033[0m"

echo ""

echo ""
echo -e "${LIGHT_CYAN}Mac ${NC} - 软件、技巧、教程分享"

parentPath=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parentPath"
appPath=$( find "$parentPath" -name '*.app' -maxdepth 1)
appName=${appPath##*/}
appBashName=${appName// /\ }
appDIR="/Applications/${appBashName}"
echo ""
echo ""
echo -e "『${appBashName} 已损坏，无法打开/ 来自身份不明的开发者』等问题修复工具"
echo ""
#未安装APP时提醒安装，已安装绕过公证
if [ ! -d "$appDIR" ];then
  echo ""
  echo -e "执行结果：${RED}您还未安装 ${appBashName} ，请先安装${NC}"
  else
  #绕过公证
  echo -e "${YELLOW}请输入开机密码，输入完成后按下回车键（输入过程中密码是看不见的）${NC}"
  sudo spctl --master-disable
  sudo xattr -rd com.apple.quarantine /Applications/"$appBashName"
  sudo codesign --sign - --force --deep /Applications/"$appBashName"
  echo ""
  echo ""
  echo -e "执行结果：${GREEN}修复成功！${NC}您现在可以正常运行 ${appBashName} 了。更多精品Mac软件尽在${BLUE}Mac下载${NC}"
fi
echo ""
echo ""
echo -e "本窗口可以关闭啦！"



# 1、可以通过命令行 sh 本文件拖进去（全路径）去运行
# 2、也可以sudo chmod a+x 本文件拖进去（全路径）去运行