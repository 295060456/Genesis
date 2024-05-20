#! /bin/sh

# 使用方法：直接将本脚本文件拖动到终端即可
# 如果没有执行权限： chmod +u+x xxx.sh 或者 chmod 777 xxx.sh

# 获取当前的相对路径
basedir=`cd $(dirname $0); pwd -P`
echo "当前项目的绝对路径为: $basedir"

# 遍历该文件夹下所有的文件（不递归），并且对文件类型加执行权限
for file in $basedir/*
do
    # 参数f是文件、d是文件夹
    if test -f $file
    then
        echo $file 是文件
        chmod +u+x $file
    fi
done

echo $"当前项目的目录名："${basedir##*/}
file_extension="xcodeproj"
echo $"需要选取后缀名为："$file_extension$"的文件"
# 取当前目录下，后缀名为xcodeproj的文件,不含后缀名的文件名
function getFileAtDirectory(){
    for element in `ls $1`
    do
        dir_or_file=$element
        # 取文件(夹)的全文件名：如果是单个文件则包含后缀名，如果是文件夹就没有后缀名
#        echo "dir_or_file: ${dir_or_file}"
        if [ ! -d $dir_or_file ];then
            # 取文件的后缀名
            file_extension=${dir_or_file##*.}
            if [ "$file_extension" == "$2" ];then
                # 取文件名，但是不带后缀名
                ProjName=${dir_or_file//.$file_extension/}
            fi
        fi
    done
}

getFileAtDirectory $basedir $file_extension

echo $"当前工程名称为："$ProjName

Proj_xcworkspace_filePath=$basedir"/"${basedir##*/}$Proj_Name$".xcworkspace"
Proj_Pods_folderPath=$basedir"/"$"Pods"
Proj_PodfileLock_filePath=$basedir"/"$"Podfile.lock"

#1、删除 x.xcworkspace
echo $"正在删除："$Proj_xcworkspace_filePath
rm -rf $Proj_xcworkspace_filePath
#2、删除Pods文件夹
echo $"正在删除："$Proj_Pods_folderPath
rm -rf $Proj_Pods_folderPath
#3、删除Podfile.lock
echo $"正在删除："$Proj_PodfileLock_filePath
rm -f $Proj_PodfileLock_filePath
echo $"项目工程："$ProjName$"的老旧陈,删除完毕"
echo $"下面进入reinstall环节"

# 如果要在终端上更改盘符，需要在终端执行 source xxx.sh 操作
cd $basedir
pod install
pod setup
#pod update
pod repo update --verbose # 详细显示进行的步骤

#-r 就是向下递归，不管有多少级目录，一并删除；
#-f 就是直接强行删除，不作任何提示的意思。
