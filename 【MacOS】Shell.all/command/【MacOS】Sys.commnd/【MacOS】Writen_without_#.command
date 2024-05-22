#!/bin/bash

# 向目标文件内写入自定义字符串
# 要求目标字符串没有被"#"所注释

# 定义要检查的字符串
STRING="RRR"

# 定义文件路径
FILE_PATH="/Users/admin/Desktop/qqq"

# 检查文件是否存在，如果不存在则创建它
if [ ! -f "$FILE_PATH" ]; then
  touch "$FILE_PATH"
fi

# 定义标志变量，默认设置为唯一
UNIQUE=true

# 逐行读取文件内容
while IFS= read -r line; do
  # 检查行中是否包含 "RRR"
  if [[ "$line" =~ RRR ]]; then
    # 如果 "RRR" 前面没有 # 或者 # 和 "RRR" 之间没有其他字符
    if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
      UNIQUE=false
      break
    fi
  fi
done < "$FILE_PATH"

# 如果文件中没有符合条件的 "RRR"，则写入字符串
if $UNIQUE; then
  echo "$STRING" >> "$FILE_PATH"
  echo "字符串 '$STRING' 已添加到文件 $FILE_PATH"
else
  echo "文件 $FILE_PATH 已经包含字符串 '$STRING'"
fi
