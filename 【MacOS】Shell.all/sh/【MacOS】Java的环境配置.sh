#!/bin/bash

<<'COMMENT'
在MacOS平台上，用shell脚本，实现对java环境JDK的一键配置。包括如下细节：

1、联网更新目前已有的JDK版本，并打印到屏幕，让用户选择性输入。如果用户只输入回车，那么默认下载并配置JDK8;
2、让用户选择是以curl或者wget哪种方式下载JDK;
3、选择下载方式以后，进行检查系统是否已经安装了已经选择的下载方式;
    3.1、如果没有安装curl则下载安装curl;
    3.2、如果没有安装wget则下载安装wget;
4、下载JDK的时候，打开JDK的官网;
5、下载完成以后，打开这个下载文件夹;
6、安装的时候，屏幕打印JDK的安装路径，并打开JDK的安装路径;
7、配置JDK环境变量的时候，打开记录JDK环境变量的文件;
COMMENT

# 1、联网获取目前已有的JDK版本，并打印到屏幕，让用户选择性输入。如果用户只输入回车，那么默认下载并配置JDK8
## 获取当前JDK列表
jdk_list=$(curl -s http://jdk.java.net/)
## 正则匹配找到所有JDK版本号
jdk_versions=$(echo $jdk_list | grep -oP 'JDK-\d+\.\d+\.\d+')
## 打印可供选择的JDK版本
echo "Available JDK Versions:"
echo $jdk_versions
## 获取用户输入的JDK版本号
read -p "Please input the JDK version you want to download (default: JDK8): " jdk_version
## 如果用户未输入版本号，则默认下载JDK8
jdk_version=${jdk_version:-JDK8}
echo "You choose to download JDK $jdk_version."

# 2、让用户选择是以 curl 或者 wget 哪种方式下载 JDK
## 获取用户希望使用的下载工具
read -p "Please choose download tool (curl/wget, default: curl): " download_tool
## 如果用户未输入下载工具，则默认使用curl
download_tool=${download_tool:-curl}
echo "You choose to use $download_tool."

# 3、选择下载方式以后，进行检查系统是否已经安装了已经选择的下载方式
## 检测是否已经安装了brew
if ! command -v brew &> /dev/null
then
    echo "brew 未安装，开始安装..."
    open https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ## brew环境变量设置
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    open /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "brew 已经安装，跳过安装步骤。"
    ## brew 升级
    brew update
    brew doctor
    brew -v
fi
## 检查系统是否已经安装指定的下载工具，如果没有则先安装
if [[ $download_tool == "curl" && ! $(which curl) ]]; then
    echo "curl not found, installing curl..."
    brew install curl
elif [[ $download_tool == "wget" && ! $(which wget) ]]; then
    echo "wget not found, installing wget..."
    brew install wget
fi
# 4、下载 JDK 的时候，打开 JDK 的官网
## 在浏览器中打开JDK官网
open http://jdk.java.net/$jdk_version/
##下载 JDK
if [[ $download_tool == "curl" ]]; then
    curl -L -O http://jdk.java.net/$jdk_version/
else
    wget http://jdk.java.net/$jdk_version/
fi

# 5、下载完成以后，打开这个下载文件夹
## 打开下载文件夹
open .

# 6、安装的时候，屏幕打印 JDK 的安装路径，并打开 JDK 的安装路径
## 安装JDK并打印安装路径
if [[ $download_tool == "curl" ]]; then
    hdiutil mount jdk-$jdk_version*.dmg
else
    hdiutil mount `ls | grep "jdk.*\.dmg"`
fi
pkg_path=$(ls /Volumes | grep "JDK")
sudo installer -pkg /Volumes/$pkg_path/*.pkg -target /
jdk_path="/Library/Java/JavaVirtualMachines/$jdk_version.jdk/Contents/Home"
echo "JDK has been installed in $jdk_path."
## 打开JDK的安装路径
open $jdk_path

# 7、配置 JDK 环境变量的时候，打开记录 JDK 环境变量的文件
## 在 ~/.bash_profile 中设置环境变量
echo "export JAVA_HOME=$jdk_path" >> ~/.bash_profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bash_profile
## source ~/.bash_profile 使配置立即生效
source ~/.bash_profile
## 在TextEdit中打开环境变量文件
open ~/.bash_profile