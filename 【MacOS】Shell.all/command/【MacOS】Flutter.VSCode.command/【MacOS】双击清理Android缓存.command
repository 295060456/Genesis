#!/bin/bash

# 获取当前用户名
current_user=$(whoami)

# 检查是否为admin用户，避免误删其他用户的 .gradle 目录
if [ "$current_user" != "admin" ]; then
    echo "Error: You must be the admin user to run this script."
    exit 1
fi

# 删除 .gradle 目录
rm -rf "/Users/$current_user/.gradle"

echo "The .gradle directory for user $current_user has been deleted."
