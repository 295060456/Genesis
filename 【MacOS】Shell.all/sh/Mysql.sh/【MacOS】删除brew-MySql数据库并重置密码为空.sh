#!/bin/bash

echo '关闭本机通过 brew 方式安装的 MySql 服务'
brew services stop mysql
mysql.server stop
echo '彻底删除本机通过 brew 方式安装的 MySql'
brew uninstall mysql
# brew cleanup

open /opt/homebrew/var/mysql
read -p "是否删除本地 mysql 的 database？回车删除，其他任意字符不删除" delMysqlDB
if [[ $delMysqlDB = "" ]];then
    mySqlDBPATH=$"/opt/homebrew/var/mysql"
    rm -r $mySqlDBPATH
fi

echo '本机重新通过 brew 形式安装 MySql'
brew install mysql
echo '本机通过 brew 形式安装的 MySql 安装目录'
brew list mysql
# 不出意外，会对外输出 /opt/homebrew/Cellar/mysql
mysql --version

# 字符串截取 mysql 的版本号
mysqlVersion=$(mysql --version | awk -F 'Ver ' '{ print $2 }' | awk -F ' for' '{ print $1 }')
fileCopy_fullname=$"/opt/homebrew/Cellar/mysql/"${mysqlVersion}"/.bottle/etc/my.cnf"
echo "fileCopy_fullname:"$fileCopy_fullname

grep skip-grant-tables $fileCopy_fullname
if [ $? -ne 0 ] ;then
cat>>${fileCopy_fullname}<<EOF
# skip-grant-tables // 放开这句，Mysql 的端口将为 0。且强行定义端口都始终为0
EOF
fi

code $fileCopy_fullname
sudo cp $fileCopy_fullname /etc/my.cnf
code /etc/my.cnf
brew services restart mysql 