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

echo "先关闭mysql的服务"
brew services stop mysql
read -p "是否先清理后安装brew_mysql?回车跳过:" cleanUp
# 输入非回车，进行清理安装
if [[ $cleanUp -ne "" ]];then
    brew uninstall mysql
    brew cleanup
fi

echo "通过brew安装mysql"
brew install mysql

echo "mysql的安装信息"
brew info mysql

echo "查询本机的MySql的安装路径"
whereis mysql

echo "查询本机的MySql的安装目录"
brew list mysql

# 定位📌到brew_mysql的根目录
cd /opt/homebrew/Cellar/mysql/8.0.32

# 没有才添加，有就不加
grep skip-grant-tables .bottle/etc/my.cnf
if [ $? -ne 0 ] ;then
    # 编辑`.bottle/etc/my.cnf`，在其末尾增添一句话：`skip-grant-tables`
    echo "skip-grant-tables" >> .bottle/etc/my.cnf
fi

# 复制`.bottle/etc/my.cnf  `→ `/etc  `
cp /opt/homebrew/Cellar/mysql/8.0.32/.bottle/etc/my.cnf /etc  

# 重启mysql服务
mysql.server start

echo "查询本机的MySql的PID"
lsof -nP -i | grep mysql 

echo "进入root用户（无密码）"
mysql -uroot -p