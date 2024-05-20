#! /bin/sh

# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh
# 参考资料：https://juejin.cn/post/6844903951473754126

echo "查看本地安装过的cocopods相关东西"
gem list --local | grep cocoapods

echo "确认删除CocoaPods？确认请回车" # 参数-n的作用是不换行，echo默认换行
read sure                           # 把键盘输入放入变量sure

if [[ $sure = "" ]];then
echo "开始卸载CocoaPods"
#sudo gem uninstall cocoapods

for element in `gem list --local | grep cocoapods`
    do
        echo $"正在卸载CocoaPods子模块："$element$"......"
        # 使用命令逐个删除
        sudo gem uninstall $element
    done
else
    echo "取消卸载CocoaPods"
fi

exit 0

# 注:如果出现root用户没有/user/bin权限,那是由于系统启用了SIP（System Integerity Protection）导致root用户也没有修改权限，所以我们需要屏蔽掉这个功能
# 1.重启电脑
# 2.command + R 进入recover模式
# 3.点击最上方菜单使用工具，选择终端
# 4.运行命令csrutil disable
# 5.重新启动电脑
