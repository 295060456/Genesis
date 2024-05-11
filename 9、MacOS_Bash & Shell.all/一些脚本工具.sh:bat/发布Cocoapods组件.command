#!/bin/bash
echo "温馨提示：手动编辑 *.podspec 以后，再使用本工具。"
# 默认邮箱（用户名）、Token（密码）
default_email="295060456@qq.com"
default_token="YOUR_TOKEN"
# 声明全局变量 declare
declare -g current_directory="" # 当前文件夹路径
declare -ag podspec_files=() # 【数组】同一个文件夹下，可能有多个*.podspec文件
declare -g current_podspec="" # 当前*.podspec文件相对路径
declare -g current_podspec2="" # 当前*.podspec文件绝对路径
declare -g current_version=""  # 当前*.podspec文件里面的版本号
declare -g major="" # 主版本号
declare -g minor="" # 次版本号
declare -g patch="" # 补丁版本号
declare -g next_version="" # 最新的版本号
# 定位资源函数
location() {
    # 获取当前文件夹路径
    current_directory=$(dirname "$(realpath "$0")")
    cd "$current_directory"  # 切换到当前目录
    echo -ne "\033[1m当前文件夹路径为：\033[0m"
    echo -e "\033[31m$current_directory\033[0m"

    # 获取当前文件夹内后缀名为podspec的文件名列表，并存储到数组中
    podspec_files=()
    while IFS= read -r -d '' file; do
        podspec_files+=("$file")
    done < <(find . -maxdepth 1 -type f -name "*.podspec" -print0)

    if [ ${#podspec_files[@]} -eq 0 ]; then
        echo "在当前文件夹中，没有找到*.podspec文件。请检查！！！"
        exit
    fi

    if [ ${#podspec_files[@]} -eq 1 ]; then
        echo "在当前文件夹中，只找到了1个 *.podspec 文件。将会自动使用这个文件."
        chosen_index=0
    else
        echo "在当前文件夹中找到了 ${#podspec_files[@]} 个 *.podspec 文件。请手动选择要使用的文件。"
        echo -e "\033[1m当前文件夹路径里面的\033[0m\033[30m*.podspec\033[0m\033[1m文件的列表：\033[0m"
        for ((i=0; i<${#podspec_files[@]}; i++)); do
            echo "$(($i+1)): ${podspec_files[$i]}"
        done
        echo -n "请选择要使用的 *.podspec 文件编号："
        read -r choice
        # 确保用户输入为数字且在合法范围内
        if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#podspec_files[@]} ]; then
            echo "无效的输入。请输入：数字1~ ${#podspec_files[@]}."
            exit
        fi
        chosen_index=$(($choice - 1))
    fi

    echo -ne "\033[1m已选择的 *.podspec 文件的相对路径为：\033[0m"
    echo -e "\033[31m${podspec_files[$chosen_index]}\033[0m"
    current_podspec=("${podspec_files[$chosen_index]}")
    echo -ne "\033[1m已选择的 *.podspec 文件的绝对路径为：\033[0m"
    echo -e "\033[31m$current_directory${podspec_files[$chosen_index]#.}\033[0m"
    current_podspec2=$current_directory${podspec_files[$chosen_index]#.}
}
# 获取当前版本号的函数(核心)
get_current_version_core() {
    # 使用 grep 找到 Pod::Spec.new do |spec| 并提取其中的spec名称
    spec_name=$(grep -o 'Pod::Spec.new do |[^|]*|' "$current_podspec" | sed -e 's/Pod::Spec.new do |//' -e 's/|//') # spec
    # 输出带有${spec_name}.version整行的内容
    matched_line=$(grep "${spec_name}\.version\s*=" "$current_podspec")
    # 提取 matched_line 变量中的内容，该内容被单引号或双引号包裹
    current_version=$(echo "$matched_line" | grep -oE "'[^']+'|\"[^\"]+\"" | sed -e "s/'//g" -e 's/"//g')
}
# 获取当前版本号的函数
get_current_version() {
    if [ -z "$current_podspec" ]; then
        echo "未选择 *.podspec 文件。"
        exit
    fi
    get_current_version_core
    # 输出提取到的版本号
    echo -ne "\033[1m当前版本号为：\033[0m"
    echo -e "\033[31m${current_version}\033[0m"
    echo
}
# 对*.podspec文件的版本号进行替换
replace_version() {
    get_current_version_core
    # 替换 *.podspec 文件中的版本号字段为用户输入的下一个版本号
    # 在路径current_podspec下，将current_version替换成next_version
    sed -i.bak 's/'${current_version}'/'${next_version}'/g' "$current_podspec"
    # 删除生成的备份文件
    rm "${current_podspec}.bak"
}
# 内容输入过滤
pause_or_exit() {
    echo "按回车键继续，或者输入任意字符+回车，则终止操作:"
    read -r -s -n 1 response
    if [ -z "$response" ]; then
        echo "继续操作..."
    else
        echo "终止操作"
        exit 0
    fi
}
# 获取版本号
get_next_version() {
    # current_version=$(grep -E 's.version\s+=' "${1}" | cut -d '"' -f 2)
    # 将当前版本号按照点号进行分割，并提取第一个字段，即主版本号
    major=$(echo "${current_version}" | cut -d '.' -f 1)
    # 将当前版本号按照点号进行分割，并提取第二个字段，即次版本号
    minor=$(echo "${current_version}" | cut -d '.' -f 2)
    # 将当前版本号按照点号进行分割，并提取第三个字段，即补丁版本号
    patch=$(echo "${current_version}" | cut -d '.' -f 3)
}
# 提示用户选择定义版本号的方式
prompt_version_selection() {
    echo "当前版本号：$current_version"
    echo "1. 主版本号递增：$((major+1)).${minor}.${patch}"
    echo "2. 次版本号递增：${major}.$((minor+1)).${patch}"
    echo "3. 补丁版本号递增：${major}.${minor}.$((patch+1))"
    echo "4. 自定义版本号。版本号格式为: x.x.x "
    read -p "请选择版本号的递增方式（输入相应数字）: " selection
    case $selection in
        1) next_version="$((major+1)).${minor}.${patch}" ;;
        2) next_version="${major}.$((minor+1)).${patch}" ;;
        3) next_version="${major}.${minor}.$((patch+1))" ;;
        4) read -p "请输入自定义版本号: " next_version ;;
        *) echo "无效的选择" && exit 1 ;;
    esac
    
    echo -ne "\033[1m当前版本号为：\033[0m"
    echo -e "\033[31m${current_version}\033[0m"

    echo -ne "\033[1m下一个版本号为：\033[0m"
    echo -e "\033[31m${next_version}\033[0m"
}
# 发布CocoaPods
publish_cocoapods() {
    # 检查是否已注册成功。如果注册成功，是不需要点击邮箱验证
    if ! pod trunk me &> /dev/null; then
        # 输入邮箱（用户名）
        read -p "Enter email (default: $default_email): " email
        email=${email:-$default_email}

        # 输入Token（密码）
        read -p "Enter token (default: $default_token): " token
        token=${token:-$default_token}

        # 注册 CocoaPods Trunk
        pod trunk register "$email" "$token"
    else
        echo "已经注册 CocoaPods Trunk 。则跳过"
        # 执行pod spec lint命令，并在每个文件通过lint后推送到CocoaPods
        echo "Linting $podspec_file"
        if pod spec lint --allow-warnings --verbose "$podspec_file"; then
            echo "Pushing $podspec_file to CocoaPods"
            pod trunk push "$podspec_file" --allow-warnings
        else
            echo "Failed to lint $podspec_file. Skipping push to CocoaPods."
        fi

        # 添加本地提交代码操作
        echo -e "\n ------ 执行 git 本地提交代码操作 ------ \n"
        read -p "Enter commit message (default: 基础的配置): " git_commit_des
        git_commit_des=${git_commit_des:-"基础的配置"}  # 设置默认提交描述信息
        echo "git add ."
        git add .
        echo "git status"
        git status
        echo "git commit -m ${git_commit_des}"
        git commit -m "${git_commit_des}"

        # 添加打标签tag，并推送到远端
        echo -e "\n ------ 执行 git 打标签tag，并推送到远端 ------ \n"
        if [ -n "$next_version" ]; then
            if git rev-parse "refs/tags/${next_version}" >/dev/null 2>&1; then
                echo "Tag ${next_version} already exists. Cancelling tag push."
            else
                echo "git tag ${next_version}"
                git tag "${next_version}"
                echo "git push origin master --tags"
                git push origin master --tags
            fi
        fi
    fi
}

location # 打印目标资源路径并设置样式
get_current_version  # 获取当前版本号的函数
pause_or_exit # 按回车键继续，或者输入任意字符+回车，则终止操作
get_next_version # 获取版本号
prompt_version_selection  # 提示用户选择定义版本号的方式
replace_version # 对*.podspec文件的版本号进行替换
publish_cocoapods # 发布CocoaPods

:<<'COMMENT'
提交库成功以后，因为各个DNS节点的数据同步问题，可能不能马上搜索的到，也就是在 https://cocoapods.org/ 上可能无法立即搜索到已经发布成功的Pods库
COMMENT

:<<'COMMENT'
pod spec lint 和 pod lib lint 都是用于校验 CocoaPods 规范的命令，但它们的使用场景略有不同。

pod spec lint：
这个命令用于校验一个单独的 .podspec 文件的规范性，即一个 CocoaPods 组件的描述文件。
pod spec lint 命令会验证 .podspec 文件的语法、依赖关系、作者信息等是否符合 CocoaPods 的规范。

pod lib lint：
这个命令也用于校验一个 CocoaPods 组件，但它会在本地模拟建立一个空项目，并将该组件集成到项目中，然后执行一系列的检查。
pod lib lint 命令会检查组件是否可以正确地集成到一个项目中，包括编译、链接、资源文件等等。
区别主要在于两者的检查范围和深度：

pod spec lint 只是对 .podspec 文件本身进行静态分析，确保其符合规范。
pod lib lint 则会更适合确保一个 CocoaPods 组件可以正确地被集成到项目中，以及在项目中的行为是否符合预期。

所以，一般来说，pod spec lint 用于对单个 .podspec 文件的静态规范进行校验，
而 pod lib lint 则更适合确保一个 CocoaPods 组件可以正确地被集
COMMENT
