#!/bin/bash

# 为私人账户生成 SSH 密钥
echo "为私人账户生成 SSH 密钥"
personal_email="295060456@qq.com"
personal_ssh_dir="$HOME/.ssh"
personal_ssh_key="$personal_ssh_dir/id_rsa_personal"

# 生成 SSH 密钥
# 在 ssh-keygen 命令中，-N 选项用于设置密钥的密码。如果你不希望为密钥设置密码，可以将 -N 选项后面的值留空
ssh-keygen -t rsa -b 4096 -C "$personal_email" -f "$personal_ssh_key" -N ""

# 在后台启动 ssh-agent
eval "$(ssh-agent -s)"

# 将 SSH 密钥添加到 ssh-agent
ssh-add "$personal_ssh_key"

# 输出公钥
echo "你的私人账户的公钥是："
cat "$personal_ssh_key.pub"
# ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️
# 为工作账户生成 SSH 密钥
echo "为工作账户生成 SSH 密钥"
work_email="olive@vgtech.org"
work_ssh_dir="$HOME/.ssh"
work_ssh_key="$work_ssh_dir/id_rsa_work"

# 生成 SSH 密钥
ssh-keygen -t rsa -b 4096 -C "$work_email" -f "$work_ssh_key" -N ""

# 将 SSH 密钥添加到 ssh-agent
ssh-add "$work_ssh_key"

# 输出公钥
echo "你的工作账户的公钥是："
cat "$work_ssh_key.pub"

# 提示用户按回车键继续
read -p "按回车键继续，并测试与 GitHub 的 SSH 连接..."
# ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️ ❤️
# 测试与 GitHub 的 SSH 连接
ssh -T git@github.com
# 测试与 GitLab 的 SSH 连接
ssh -T git@git.131j.com

echo " SSH 设置完成！"
