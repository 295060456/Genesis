#!/bin/bash

# 向目标文件内写入自定义字符串
# 要求目标字符串没有被"#"所注释

# 定义函数，参数为文件路径和要检查的字符串
add_string_if_unique() {
    local FILE_PATH="$1"
    local STRING="$2"
    local UNIQUE=true
    
    # 检查文件是否存在，如果不存在则创建它
    if [ ! -f "$FILE_PATH" ]; then
        touch "$FILE_PATH"
    fi
    
    # 逐行读取文件内容
    while IFS= read -r line; do
        # 检查行中是否包含指定字符串
        if [[ "$line" =~ $STRING ]]; then
            # 如果字符串前面没有 # 或者 # 和字符串之间没有其他字符
            if ! [[ "$line" =~ ^[[:space:]]*# ]]; then
                UNIQUE=false
                break
            fi
        fi
    done < "$FILE_PATH"
    
    # 如果文件中没有符合条件的字符串，则写入字符串
    if $UNIQUE; then
        echo "$STRING" >> "$FILE_PATH"
        echo "字符串 '$STRING' 已添加到文件 $FILE_PATH"
    else
        echo "文件 $FILE_PATH 已经包含字符串 '$STRING'"
    fi
}

# 使用示例
add_string_if_unique "$HOME/.bash_profile" "SSS"

#为什么add_string_if_unique "/Users/admin/ddd" "SSS"写入成功，
#add_string_if_unique "~/ddd" "SSS"写入失败？
#
#在 Bash 中，~ 符号是一个特殊的表示法，用于表示当前用户的主目录。但是，它只有在它是单独的一个词元时才会被扩展。如果 ~ 后面跟着其他字符，则不会被扩展成用户的主目录路径。
#所以，当你调用 add_string_if_unique "~/ddd" "SSS" 时，~ 后面跟着 /ddd，它不会被扩展成用户的主目录路径，而是被当作普通字符对待。因此，会尝试在当前目录下创建一个名为 ~ 的文件，然后写入字符串。这就是为什么它失败的原因。
#要正确地使用主目录路径，你可以使用 $HOME 环境变量，它表示当前用户的主目录。即，
#add_string_if_unique "$HOME/.bash_profile" "SSS"
