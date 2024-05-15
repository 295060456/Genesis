#!/bin/bash

# 资料来源
# https://segmentfault.com/a/1190000025190788

# 当要 cd 到多层的上级目录时,需要输入 cd ../../../ 等等多个 "../".
# 为了简化输入,当前脚本可以处理一个整数参数,指定返回到几层的上级目录.
# 例如 source cdup.sh 3 等价于 cd ../../../
# 为了让脚本执行结束后,还保持在 cd 后的目录,需要用 source 命令
# 来执行该脚本. 可以在 ~/.bashrc 文件中添加如下别名来方便执行:
#   alias up='source cdup.sh'
# 后续执行 up 3 命令,就等价于 cd ../../../
# 这里假设 cdup.sh 脚本放在 PATH 指定的寻址目录下.例如 /usr/bin 目录.
# 如果 cdup.sh 脚本没有放在默认的寻址目录下,请指定完整的绝对路径.

cdup_show_help()
{
printf "USAGE
    source cdup.sh number
OPTIONS
    number: 指定要返回到几层的上级目录.
    例如 source cdup.sh 3 等价于 cd ../../../
NOTE
    可以使用 alias up='source cdup.sh' 设置 up 别名来方便执行.
"
}

if [ $# -ne 1 ]; then
    cdup_show_help
    # 当前脚本预期通过 source 命令来调用,不能执行 exit 命令,
    # 否则会退出调用该脚本的 shell.下面通过 return 命令来返回.
    return 1
fi

UPDIR_PATH="../"

# 根据传入的数字参数,计算要返回到几层上级目录,并将结果写到标准输出
count_updirs()
{
    # 所给的第一个参数指定要返回到几层上级目录
    local count=$1

    local updirs=""
    while ((--count >= 0)); do
        # 没有使用算术扩展时, bash 的 += 运算符默认会拼接字符串.
        # 下面语句会拼接多个 "../",得到类似于 "../../../" 的效果.
        updirs+=${UPDIR_PATH}
    done
    echo ${updirs}
}

target_dir="$(count_updirs $1)"
# 使用 \cd 来指定不使用 alias 别名,执行原始的 cd 命令.
\cd "${target_dir}"

return