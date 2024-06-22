#!/bin/zsh

# 提示用户选择操作类型
echo "请选择操作类型："
echo "1. 添加执行权限"
echo "2. 删除执行权限"
read "choice?请输入1或2："

# 检查用户输入的合法性
if [[ "$choice" != "1" && "$choice" != "2" ]]; then
    echo "无效的选择，请输入1或2。"
    exit 1
fi

# 提示用户将文件拖入终端
echo "请将要操作的文件拖入终端，然后按回车："

# 读取用户拖入的文件路径
read file_path

# 检查文件路径是否为空
if [[ -z "$file_path" ]]; then
    echo "未检测到文件路径，请重试。"
    exit 1
fi

# 检查文件是否存在
if [[ ! -f "$file_path" ]]; then
    echo "文件不存在，请检查路径并重试。"
    exit 1
fi

# 根据用户选择进行操作
if [[ "$choice" == "1" ]]; then
    chmod +x "$file_path"
    echo "已添加执行权限：$file_path"
else
    chmod -x "$file_path"
    echo "已删除执行权限：$file_path"
fi

