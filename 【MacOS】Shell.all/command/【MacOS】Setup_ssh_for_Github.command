#!/bin/bash

# SSH 密钥注释的电子邮件
email="295060456@qq.com"

# SSH 密钥的目录和文件名
ssh_dir="$HOME/.ssh"
ssh_key="$ssh_dir/id_rsa"

# 生成 SSH 密钥
ssh-keygen -t rsa -b 4096 -C "$email" -f "$ssh_key" -N ""

# 在后台启动 ssh-agent
eval "$(ssh-agent -s)"

# 将 SSH 密钥添加到 ssh-agent
ssh-add "$ssh_key"

# 输出公钥
echo "你的公钥是："
cat "$ssh_key.pub"

# 提示用户按回车键继续
read -p "按回车键继续，并测试与 GitHub 的 SSH 连接..."

# 测试与 GitHub 的 SSH 连接
ssh -T git@github.com

echo "GitHub 的 SSH 设置完成！"
