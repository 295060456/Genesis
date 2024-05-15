#!/bin/bash

# 参考资料
## https://getgrav.org/blog/macos-monterey-apache-multiple-php-versions
## https://www.cnblogs.com/ice5/p/15783811.html

# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh
filePath=$(dirname $0)/$(basename $0)
echo "我在这里：$filePath" 

# 定位📌于该文件的垂直文件夹
folderPath=$(dirname $0)
cd folderPath
# 加权限
fileFullName=$(basename $0)
chmod u+x $fileFullName

if brew -v;then
    echo "The package is installed"
    brew update
    brew doctor
    brew -v
else
    echo "The package is not installed"
    open https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ### brew环境变量设置
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install php
brew install openssl
brew install httpd
brew services start httpd
brew tap shivammathur/php

open http://localhost:8080/


#sudo su //切到root帐号
#配置文件与网站根目录默认所在位置
#/etc/apache2/httpd.conf //配置文件
#/Library/WebServer/Documents //网站根目录

#sudo apachectl start // 开启Apache
#sudo apachectl stop // 关闭Apache
#sudo apachectl restart // 重启Apache


# 故障排除提示
## 如果您收到浏览器无法连接到服务器的消息,请首先检查以确保服务器已启动
ps -aef | grep httpd

## 如果 Apache 已启动并正在运行,您应该会看到一些 httpd 进程
## 尝试使用以下命令重新启动 Apache
brew services restart httpd

open https://getgrav.org/blog/macos-monterey-apache-multiple-php-versions

echo "在最新版本的 Brew 中,您必须手动将侦听端口从默认设置8080为80,因此我们需要编辑 Apache 的配置文件/opt/homebrew/etc/httpd/httpd.conf"
vim /opt/homebrew/etc/httpd/httpd.conf

Listen 8080 更改为 Listen 80

