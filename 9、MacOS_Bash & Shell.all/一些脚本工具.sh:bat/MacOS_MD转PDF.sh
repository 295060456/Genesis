#!/bin/bash

# 检测是否已经安装了 brew
if ! command -v brew &> /dev/null
then
    echo "brew 未安装，开始安装..."
    open https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ## brew环境变量设置
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    open /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "brew 已经安装，跳过安装步骤。"
    ## brew 升级
    brew update
    brew doctor
    brew -v
fi
# 检测是否已经安装了 brew-pandoc
<<'COMMENT'
Pandoc是一个用haskell编写的开源文本转换工具（通用标记转换器）。
小巧迅速且支持格式广泛，堪称文本转换应用的瑞士军刀。支持很多种输入输出。
最大缺点：Pandoc是命令行工具，没有图形用户界面。
COMMENT
if ! command -v pandoc &> /dev/null
then
    echo "pandoc 未安装，开始安装..."
    brew install pandoc
else
    echo "pandoc 已经安装，跳过安装步骤。"
fi
# 检测是否已经安装了 pdflatex
if command -v pdflatex >/dev/null 2>&1; then
echo “pdflatex已经安装，跳过安装步骤。”
tlmgr update --self
else
<<'COMMENT'
1、安装 TeXLive：
    1.1、tlmgr 是 TeXLive 的安装和管理命令行工具，不是 macOS 自带的工具，需要手动安装;
    1.2、brew install --cask mactex-no-gui
    1.3、配置 PATH 环境变量：可以将以下代码添加到 ~/.bash_profile 或者 ~/.zshrc 文件中：export PATH="/Library/TeX/texbin:$PATH"
2、安装 tlmgr 的 LaTeX 包：
例如，安装中文宏包 ctex：
sudo tlmgr update --self && sudo tlmgr install ctex
3、查看已安装的包列表：
tlmgr list --only-installed
4、LaTeX 是一种排版系统。编译pandoc默认的latex引擎是pdflatex，是不支持中文的，因此需要手动设置编译时所用的引擎为xelatex，
编译命令改为：pandoc infile.md -o outfile.pdf --latex-engine=xelatex

注意，如果使用 sudo 权限安装 tlmgr，可能会导致权限问题。
如果遇到权限错误，建议不要使用 sudo，而是将 TeXLive 安装在用户目录下，或者使用管理员权限运行终端。
COMMENT
echo “正在安装pdflatex…”
brew install --cask mactex-no-gui
## TeXLive 环境变量的配置
grep export PATH="/Library/TeX/texbin:$PATH" ~/.bash_profile
if [ $? -ne 0 ] ;then
	echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.bash_profile
	source ~/.bash_profile
fi
echo “pdflatex安装完成！”
## 安装中文宏包 ctex
sudo tlmgr update --self && sudo tlmgr install ctex

## 下载 pandoc 的默认样式文件
curl -O https://gist.githubusercontent.com/kevinburke/ea746fce3113f64b6260/raw/14e659e7aeab7e79f41f2d552b355ee5a54ad296/eisvogel.tex
fi

# 在macOS系统上，用shell脚本实现:键盘监听，输入一个文件路径，提取这个文件的文件名，不带后缀名
## 定义函数，用于提取文件名（不带后缀名）
function get_filename() {
    # 从文件路径中提取文件名（不带后缀名）
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    echo "$filename"
}
## 定义函数，用于提取文件名（不带后缀名）
function get_filename() {
    # 从文件路径中提取文件名（不带后缀名）
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    echo "$filename"
}
# 监听键盘输入
while true; do
    ## 读取用户输入的文件路径
    read -p "请输入文件路径：" filepath
    ## 检查文件是否存在
    if [ ! -f "$filepath" ]; then
        echo "文件不存在，请重新输入。"
        continue
    fi
    ## 检查文件后缀名是否为 md
    if [[ "${filepath##*.}" != "md" ]]; then
        echo "文件后缀名不是 md，请重新输入。"
        continue
    fi
    ## 提取文件名（不带后缀名）
    filename=$(get_filename "$filepath")
    ## 转换为pdf文件（默认就只能转英文，其他字符需要参数支持）
    pandoc "$filepath" -o "${filename}.pdf" --pdf-engine=xelatex -V CJKmainfont='STHeitiSC-Light'
    # pandoc --pdf-engine=xelatex -V CJKmainfont='STHeitiSC-Light' ./区块链.md -o ./区块链.pdf
    ## 输出提示信息
    echo "文件转换完成，生成的pdf文件为：${filename}.pdf"
    ## 退出循环
    break
done
