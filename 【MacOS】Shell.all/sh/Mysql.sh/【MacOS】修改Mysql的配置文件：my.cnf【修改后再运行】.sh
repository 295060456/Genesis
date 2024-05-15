# !/bin/bash

echo '关闭本机通过 brew 方式安装的 MySql 服务'
brew services stop mysql
mysql.server stop

echo '本机通过 brew 形式安装的 MySql 安装目录'
brew list mysql
# 不出意外，会对外输出 /opt/homebrew/Cellar/mysql
mysql --version

# 字符串截取 mysql 的版本号
mysqlVersion=$(mysql --version | awk -F 'Ver ' '{ print $2 }' | awk -F ' for' '{ print $1 }')
fileCopy_fullname=$"/opt/homebrew/Cellar/mysql/"${mysqlVersion}"/.bottle/etc/my.cnf"
echo "fileCopy_fullname:"$fileCopy_fullname

# 直接追加写入
cat>>${fileCopy_fullname}<<EOF
# 这里写入需要修改的配置信息
gtid_mode=ON  
log-slave-updates=1  
enforce-gtid-consistency=1  
# skip-grant-tables // 放开这句，Mysql 的端口将为 0。且强行定义端口都始终为0

EOF

code $fileCopy_fullname
read -p "检查完毕并保存:通过brew管理的Mysql配置文件【my.cnf】" 
sudo cp $fileCopy_fullname /etc/my.cnf
code /etc/my.cnf
brew services restart mysql 

echo "不需要验证密码，直接登录 mysql"
mysql -p   