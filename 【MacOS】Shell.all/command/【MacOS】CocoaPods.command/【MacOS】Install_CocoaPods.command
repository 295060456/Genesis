#!/bin/zsh

# 定义全局变量
RBENV_PATH='export PATH="$HOME/.rbenv/bin:$PATH"' # Rbenv 的环境变量
RBENV_INIT='eval "$(rbenv init -)"' # eval 是一个 shell 命令，用于将字符串作为 shell 命令执行。它实际上是在执行 rbenv init - 生成的命令。
HOMEBREW_PATH='export PATH="/opt/homebrew/bin:$PATH"' # HomeBrew 的环境变量
RUBY_GEMS_PATH='export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin"' # Gems 的环境变量
# 获取所有 ruby 的安装路径
ruby_paths=$(which -a ruby)
# 通用打印方法
_JobsPrint() {
    local COLOR="$1"
    local text="$2"
    local RESET="\033[0m"
    echo "${COLOR}${text}${RESET}"
}
# 定义红色加粗输出方法
_JobsPrint_Red() {
    _JobsPrint "\033[1;31m" "$1"
}
# 定义绿色加粗输出方法
_JobsPrint_Green() {
    _JobsPrint "\033[1;32m" "$1"
}
# 打印 "Jobs" logo
jobs_logo() {
    local border="=="
    local width=49  # 根据logo的宽度调整
    local top_bottom_border=$(printf '%0.1s' "${border}"{1..$width})
    local logo="
||${top_bottom_border}||
||  JJJJJJJJ     oooooo    bb          SSSSSSSSSS  ||
||        JJ    oo    oo   bb          SS      SS  ||
||        JJ    oo    oo   bb          SS          ||
||        JJ    oo    oo   bbbbbbbbb   SSSSSSSSSS  ||
||  J     JJ    oo    oo   bb      bb          SS  ||
||  JJ    JJ    oo    oo   bb      bb  SS      SS  ||
||   JJJJJJ      oooooo     bbbbbbbb   SSSSSSSSSS  ||
||${top_bottom_border}||
"
    _JobsPrint_Green "$logo"
}
# 自述信息
self_intro() {
    _JobsPrint_Green "安装Cocoapods"
    _JobsPrint_Red "按回车键继续..."
    read
}
# 检查并添加行到指定的配置文件
add_line_if_not_exists() {
    local file=$1
    local line=$2
    local filepath="$HOME/$file"

    # 检查文件是否存在，如果不存在或为空，则不添加空行
    if [ ! -s "$filepath" ]; then
        echo "$line" >> "$filepath"
        _JobsPrint_Green "添加到$file：$line"
    elif ! grep -qF "$line" "$filepath"; then
        # 文件不为空，并且行不存在，先添加空行然后添加目标行
        echo '' >> "$filepath"
        echo "$line" >> "$filepath"
        _JobsPrint_Green "添加到$file：$line"
    else
        _JobsPrint_Red "$file中已存在 $line"
    fi
}
# 更新 Oh.My.Zsh
update_OhMyZsh() {
    _JobsPrint_Green "检查是否有新版本..."
    cd ~/.oh-my-zsh || exit
    git fetch origin master
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if git rev-list --count HEAD..origin/master | grep -q '^0$' > /dev/null; then
        _JobsPrint_Green "已经是最新版本，无需更新。"
    else
        _JobsPrint_Green "发现新版本，正在升级 Oh.My.Zsh..."
        git pull origin master
    fi
}
# 检查并安装 Oh.My.Zsh
check_OhMyZsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        _JobsPrint_Green "当前系统中未安装 Oh.My.Zsh，正在进行安装..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        _JobsPrint_Green "当前系统中已安装 Oh.My.Zsh，进行检查更新升级。"
        update_OhMyZsh
    fi
}
# 准备前置环境
prepare_environment() {
    _JobsPrint_Green "先做一些准备工作..."
    # 显示Mac OS X上的隐藏文件和文件夹
    defaults write com.apple.Finder AppleShowAllFiles YES
    # 允许从任何来源打开应用（需要管理员权限）
    sudo spctl --master-disable
    # 检查并安装 Oh.My.Zsh
    check_OhMyZsh
    # 安装 Rosetta 2:在 Apple Silicon 上安装和运行某些工具时，可能需要使用 Rosetta 2 来确保兼容性
    softwareupdate --install-rosetta
    # 确认 Rosetta 2 安装成功
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    # 增加 Git 的缓冲区大小：可以尝试增加 Git 的 HTTP 缓冲区大小，以防止在传输大对象时出现问题。
    git config --global http.postBuffer 524288000  # 设置缓冲区为500MB
}
# 检查 Xcode 和 Xcode Command Line Tools
check_xcode_and_tools() {
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v xcodebuild &> /dev/null; then
        _JobsPrint_Red "Xcode 未安装，请安装后再运行此脚本。"
        open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"
        exit 1
    fi
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! xcode-select -p &> /dev/null; then
        _JobsPrint_Red "Xcode Command Line Tools 未安装，请安装后再运行此脚本。"
        xcode-select --install # 安装 Xcode Command Line Tools
        _JobsPrint_Green "请按照提示进行安装，安装完成后再次运行此脚本。"
        exit 1
    fi
    _JobsPrint_Green "🍺🍺🍺 Xcode 和 Xcode Command Line Tools 均已安装。"
}
# 非用Homebrew管理的方式安装fzf
install_fzf(){
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}
# 检查并安装/更新 libyaml
check_and_update_libyaml() {
    # 命令检查 libyaml 是否已安装。输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if brew list libyaml &> /dev/null; then
        echo "libyaml 已经安装"
    else
        echo "libyaml 还没有安装。现在安装..."
        # 尝试安装 libyaml
        brew install libyaml
        if [ $? -eq 0 ]; then
            echo "libyaml 已经被成功安装"
        else
            echo "libyaml 安装失败"
        fi
    fi
    pkg-config --cflags --libs yaml-0.1

}
# 检查并安装/更新 fzf
check_and_update_fzf() {
    # 检查fzf命令是否存在。输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v fzf &> /dev/null; then
        _JobsPrint_Red "fzf没有安装，正在安装到最新版本"
        echo "选择安装方式："
        echo "1) 通过 Homebrew 安装"
        echo "2) 通过 Git 克隆安装"
        read -p "请输入选项 (1 或 2): " choice

        case $choice in
            1)
                check_homebrew # 检查并安装 Homebrew
                brew install fzf
                ;;
            2)
                install_fzf
                ;;
            *)
                _JobsPrint_Red "无效输入，操作取消"
                ;;
        esac
    else
        _JobsPrint_Green "fzf 已被安装，正在检查更新..."
        # 检查fzf是否通过brew安装。输出被重定向到 /dev/null，因此不会在终端显示任何内容
        if brew list fzf &> /dev/null; then
            _JobsPrint_Green "fzf is installed via Homebrew."
            # 检查是否有更新
            outdated_packages=$(brew outdated fzf)
            if [ -n "$outdated_packages" ]; then
                _JobsPrint_Green "升级 fzf..."
                brew upgrade fzf
            else
                _JobsPrint_Green "fzf 已经是最新版本"
            fi
        fi
        # 检查fzf是否通过 install_fzf 的方式进行安装的
        if [ -d "$HOME/.fzf" ] && [ -x "$HOME/.fzf/bin/fzf" ]; then
            cd "$HOME/.fzf" # 进入 fzf 安装目录
            git pull # 拉取最新的代码
            ./install # 重新运行安装脚本
        fi
    fi
}
# 用fzf的方式安装 Homebrew。
install_homebrew_byFzf() {
    local choice
    choice=$(printf "1. 自定义脚本安装（可能不受官方支持）\n2. 官方脚本安装（推荐）" | fzf --prompt "请选择安装方式：")
    case $choice in
    "1. 自定义脚本安装（可能不受官方支持）")
        _JobsPrint_Green "正在使用自定义脚本安装 Homebrew..."
        open https://gitee.com/ineo6/homebrew-install/
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
        ;;
    "2. 官方脚本安装（推荐）")
        _JobsPrint_Green "正在使用官方脚本安装 Homebrew..."
        open https://brew.sh/
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_homebrew_byFzf
        ;;
    esac
}
# 键盘输入的方式安装 Homebrew
install_homebrew_normal() {
    echo "请选择安装方式："
    echo "1. 自定义脚本安装（可能不受官方支持）"
    echo "2. 官方脚本安装（推荐）"
    echo -n "请输入选项（1或2，按回车默认选择2）: "
    read choice

    # 如果没有输入任何内容，则默认设置为2
    if [ -z "$choice" ]; then
        choice=2
    fi

    case $choice in
    1)
        _JobsPrint_Green "正在使用自定义脚本安装 Homebrew..."
        open https://gitee.com/ineo6/homebrew-install/
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
        _brewRuby # 写环境变量
        _JobsPrint_Green "自定义脚本安装 Homebrew 完毕。验证安装..."
        check_homebrew # 检查并安装 Homebrew
        ;;
    2)
        _JobsPrint_Green "正在使用官方脚本安装 Homebrew..."
        open https://brew.sh/
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        _brewRuby # 写环境变量
        _JobsPrint_Green "官方脚本安装 Homebrew 完毕。验证安装..."
        check_homebrew # 检查并安装 Homebrew
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_homebrew_normal
        ;;
    esac
}
# 检查并安装 Homebrew
check_homebrew() {
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v brew &> /dev/null; then
        _JobsPrint_Red "brew 未安装，开始安装..."
        install_homebrew_normal
    else
        _JobsPrint_Green "Homebrew 已经安装，跳过安装步骤。"
        _JobsPrint_Green "检查更新 Homebrew..."
        brew update
        _JobsPrint_Green "升级 Homebrew 和由 Homebrew 管理的程序包..."
        brew upgrade
        _JobsPrint_Green "正在执行 Homebrew 清理工作..."
  
        if [ -d "/usr/local/Cellar/" ]; then
            sudo chown -R $(whoami) /usr/local/Cellar/
        fi
        if [ -d "$(brew --prefix)" ]; then
            sudo chown -R $(whoami) "$(brew --prefix)"/*
        fi
        brew cleanup
        _JobsPrint_Green "🍺🍺🍺完成更新和清理 Homebrew"
        brew doctor
        brew -v
    fi
}
# 检查并安装 zsh
check_and_install_zsh() {
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if command -v zsh >/dev/null 2>&1; then
        _JobsPrint_Green "zsh 已经安装，不需要执行任何操作。"
    else
        _JobsPrint_Red "zsh 未安装，正在通过 Homebrew 安装 zsh..."
        check_homebrew # 检查并安装 Homebrew
        brew install zsh
    fi
}
# 配置 Home.Ruby 环境变量
_brewRuby(){
    # 使用全局变量更新 HomeBrew
    add_line_if_not_exists ".bash_profile" "$HOMEBREW_PATH" # 检查并添加行到 ./bash_profile
    add_line_if_not_exists ".bashrc" "$HOMEBREW_PATH" # 检查并添加行到 ./bashrc
    add_line_if_not_exists ".zshrc" "$HOMEBREW_PATH" # 检查并添加行到 ./zshrc
    # 重新加载配置文件
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 配置 Rbenv.Ruby 环境变量
_rbenRuby(){
    # 使用全局变量更新 RBenv
    add_line_if_not_exists ".bash_profile" "$RBENV_PATH" # 检查并添加行到 ./bash_profile
    add_line_if_not_exists ".bashrc" "$RBENV_PATH" # 检查并添加行到 ./bashrc
    add_line_if_not_exists ".zshrc" "$RBENV_PATH" # 检查并添加行到 ./zshrc
    
    add_line_if_not_exists ".bash_profile" "$RBENV_INIT" # 检查并添加行到 ./bash_profile
    add_line_if_not_exists ".bashrc" "$RBENV_INIT" # 检查并添加行到 ./bashrc
    add_line_if_not_exists ".zshrc" "$RBENV_INIT" # 检查并添加行到 ./zshrc
    
    # 重新加载配置文件
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 配置 Ruby.Gems 环境变量
_rubyGems(){
    # 使用全局变量更新 Gems
    add_line_if_not_exists ".bash_profile" "$RUBY_GEMS_PATH" # 检查并添加行到 ./bash_profile
    add_line_if_not_exists ".bashrc" "$RUBY_GEMS_PATH" # 检查并添加行到 ./bashrc
    add_line_if_not_exists ".zshrc" "$RUBY_GEMS_PATH" # 检查并添加行到 ./zshrc
    # 重新加载配置文件
    source ~/.bashrc
    source ~/.zshrc
    source ~/.bash_profile
}
# 检查并修复 RVM 路径
fix_rvm_path() {
    if [[ ":$PATH:" != *":$HOME/.rvm/bin:"* ]]; then
        export PATH="$HOME/.rvm/bin:$PATH"
        _JobsPrint_Green "修复 RVM 路径设置。"
    fi
}
# 安装/升级 ruby-build 插件
install_ruby_build() {
    local ruby_build_dir="$(rbenv root)"/plugins/ruby-build
    if [ ! -d "$ruby_build_dir" ]; then
        _JobsPrint_Green "正在安装 ruby-build 插件..."
        git clone https://github.com/rbenv/ruby-build.git "$ruby_build_dir"
    else
        _JobsPrint_Green "检测到已安装 ruby-build 插件，正在检查是否需要升级..."
        cd "$ruby_build_dir" && git pull
        _JobsPrint_Green "ruby-build 插件已更新到最新版本。"
    fi
}
# 定义一个通用的函数来处理操作结果
handle_operation_result() {
    if [ $1 -eq 0 ]; then
        _JobsPrint_Green "$2 完成."
        install_ruby_build # 安装/升级 ruby-build 插件
        return 0  # 成功执行
    else
        return 1  # 执行失败
    fi
}
# 检查并安装 Rbenv
check_Rbenv() {
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v rbenv &> /dev/null; then
        _JobsPrint_Green "正在安装 Rbenv..."
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        _rbenRuby # 配置 Rbenv.Ruby 环境变量
        # 调用封装的函数处理结果
        handle_operation_result $? "rbenv 安装"
    else
        _JobsPrint_Green "检测到已安装 Rbenv，准备升级到最新版本..."
        _JobsPrint_Green "正在升级 Rbenv..."
        cd ~/.rbenv && git pull
        # 调用封装的函数处理结果
        handle_operation_result $? "Rbenv 升级"
    fi
}
# 利用 Homebrew 安装 Ruby 环境
install_ruby_byBrew(){
    _JobsPrint_Green "利用 Homebrew 安装 Ruby环境（RVM）..."
    brew install ruby
    brew cleanup ruby
}
# 检测当前通过 Rbenv 安装的 Ruby 环境
check_rbenv_version(){
    _JobsPrint_Green '列出当前系统上安装的所有 Ruby 版本'
    rbenv versions
    _JobsPrint_Green '显示当前全局生效的 Ruby 版本'
    rbenv version
}
# 检测当前通过 HomeBrew 安装的 Ruby 环境
check_homebrew_version(){
    brew info ruby
}
# 通过 Rbenv 的形式，安装 ruby 环境
install_ruby_byRbenv(){
    _JobsPrint_Green "打印可用的 Ruby 版本列表："
    # 用于列出所有可用的 Ruby 版本，同时过滤掉所有空白行
    rbenv install --list | grep -v -e "^[[:space:]]*$"
    read "version?请输入要安装的 Ruby 版本号，或者按回车键安装当前最新版本（未输入版本号，则安装当前最新版本）: "
    if [ -z "$version" ]; then
        _JobsPrint_Green "正在安装最新版本的 Ruby..."
        # 用于找到并存储可用的最新稳定版本的 Ruby，忽略任何预发布版本或带有特殊标记的版本
        latest_version=$(rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1)
        rbenv install $latest_version
        rbenv local $latest_version
    else
        if rbenv install --list | grep -q "$version"; then
            _JobsPrint_Green "正在安装 Ruby $version..."
            rbenv install $version
            rbenv local $version
        else
            _JobsPrint_Red "版本号 $version 不存在，请重新输入。"
            exit 1
        fi
    fi
    _rbenRuby # 配置 Rbenv.Ruby 环境变量
    
    # 在安装或卸载 Ruby 版本、安装新的 gem（具有可执行文件）后重新生成 shims
    # shims 是 rbenv 用来拦截 Ruby 命令（如 ruby, irb, gem, rails 等）并将它们重定向到正确安装的 Ruby 版本的一种机制
    # 当你在使用 rbenv 管理多个 Ruby 版本时，rbenv 不会改变全局的 PATH 环境变量中的 Ruby 命令路径。
    # 相反，它在 PATH 中添加一个指向 ~/.rbenv/shims 目录的路径，这个目录包含了伪装（shim）过的 Ruby 命令。
    # 每次运行例如 ruby 或 gem 这样的命令时，实际上运行的是一个位于 shims 目录的代理脚本。这个脚本负责调用 rbenv 来确定应该使用哪个 Ruby 版本，然后重定向到这个版本的对应命令。
    rbenv rehash # rbenv rehash 是维护 rbenv 环境正确性的重要步骤，确保所有安装的 Ruby 版本和 Ruby 工具都可以被正确调用。
    
    check_rbenv_version # 检测当前通过 Rbenv 安装的 Ruby 环境
}
# 一键安装 Ruby 版本管理器 RVM（Ruby Version Manager）和最新稳定版的 Ruby
install_ruby_byRVM(){
    open https://get.rvm.io
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
}
# 如果当前 Ruby 环境是通过 HomeBrew 安装的，那么升级 HomeBrew.Ruby 到最新版
check_ruby_install_ByHomeBrew(){
    if brew list --formula | grep -q ruby; then
        _JobsPrint_Green "当前 Ruby 环境是通过 HomeBrew 安装的"
        _JobsPrint_Green "升级 HomeBrew.Ruby 到最新版..."
        brew upgrade ruby
        brew cleanup ruby
    fi
}
# 检查当前 Ruby 环境是否是通过 Rbenv 安装的
check_rbenv_installed_ruby() {
    local version
    local rbenv_version
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    version=$(ruby -v 2>/dev/null | awk '{print $2}' || true)
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    rbenv_version=$(rbenv version 2>/dev/null | awk '{print $1}' || true)

    if [ -n "$version" ] && [ -n "$rbenv_version" ]; then
        if [ "$version" = "$rbenv_version" ]; then
            _JobsPrint_Green "当前 Ruby 环境是通过 Rbenv 安装的"
            upgrade_current_rbenv_ruby # 升级当前 Rbenv.Ruby 环境
        else
            _JobsPrint_Red "当前 Ruby 环境不是通过 Rbenv 安装的"
        fi
    else
        _JobsPrint_Red "无法获取 Ruby 版本信息"
    fi
}
# 检测当前 Ruby 环境是否通过 RVM 官方推荐的方式安装的
check_ruby_install_ByRVM(){
    if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
        _JobsPrint_Green "当前 Ruby 环境是通过RVM官方推荐的方式安装的"
    fi
}
# 检测当前 Ruby 环境是否是 MacOS 自带的
check_ruby_install_ByMacOS(){
    if echo "$ruby_paths" | grep -q "/usr/bin/ruby"; then
        _JobsPrint_Red "当前Ruby环境为MacOS自带的Ruby环境（阉割版）"
    fi
}
# 检查当前的Ruby环境
check_ruby_environment() {
    _JobsPrint_Green "查看本机的 Ruby 环境安装目录："
    which -a ruby

    check_ruby_install_ByMacOS # 检测当前 Ruby 环境是否是 MacOS 自带的
    check_rbenv_version # 检测当前 Ruby 环境是否通过 Rbenv 安装的
    check_homebrew_version # 检测当前 Ruby 环境是否通过 HomeBrew 安装的
    check_ruby_install_ByRVM # 检测当前 Ruby 环境是否通过 RVM 官方推荐的方式安装的
    
    if ! echo "$ruby_paths" | grep -q "/usr/bin/ruby"; then
        read "confirm_delete?是否删除这些非系统 Ruby 环境？(按 Enter 键继续，输入任意字符删除并重新安装): "
        if [[ -n "$confirm_delete" ]]; then
            _JobsPrint_Red "正在删除非系统 Ruby 环境..."
            uninstall_Ruby # 卸载所有已安装的 Ruby 环境
        fi
    fi
    
    _JobsPrint_Green "打印已安装的 Ruby 版本："
    rvm list
    _JobsPrint_Green "当前使用的 Ruby 版本："
    ruby -v
    
    _JobsPrint_Green "清理 RVM 环境..."
    rvm cleanup all
    _JobsPrint_Green "RVM 环境清理完成。"
}
# 安装Ruby环境
setup_ruby_environment(){
    choice=$(printf "1. 使用 Homebrew 安装\n2. 使用 rbenv 安装\n3. 使用 RVM 官方推荐的方式进行安装" | fzf --prompt "请选择 Ruby 的安装方式：")
    case $choice in
    "1. 使用 Homebrew 安装")
        install_ruby_byBrew # 利用 Homebrew 安装 Ruby 环境
        _JobsPrint_Green "🍺🍺🍺 Homebrew.Ruby安装成功"
        check_ruby_install_ByHomeBrew
        ;;
    "2. 使用 rbenv 安装")
        install_ruby_byRbenv # 通过 Rbenv 的形式，安装 ruby 环境
        _JobsPrint_Green "🍺🍺🍺 Rbenv.Ruby安装成功"
        check_rbenv_version # 检测当前通过 Rbenv 安装的 Ruby 环境
        ;;
    "3. 使用 RVM 官方推荐的方式进行安装")
        install_ruby_byRVM # 一键安装 Ruby 版本管理器 RVM（Ruby Version Manager）和最新稳定版的 Ruby
        _JobsPrint_Green "🍺🍺🍺 RVM.Ruby安装成功"
        check_ruby_install_ByRVM
        if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
            _JobsPrint_Green "正在使用 rvm get stable --auto-dotfiles 修复 PATH 设置..."
            rvm get stable --auto-dotfiles
        fi
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新输入。"
        setup_ruby_environment # 安装Ruby环境
        ;;
    esac
}
# 删除指定版本的 Ruby 环境
remove_ruby_environment() {
    local version=$1
    _JobsPrint_Red "开始删除 Ruby 环境：$version"

    if check_ruby_install_ByHomeBrew; then
        # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
        brew uninstall --force ruby 2>/dev/null || true
        sudo sed -i '' '/rvm/d' ~/.bash_profile ~/.bashrc ~/.zshrc 2>/dev/null || true
    fi
    # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if ! command -v rbenv &> /dev/null; then
        sudo rbenv uninstall -f $version 2>/dev/null || true
    fi

    if check_ruby_install_ByRVM; then
        _JobsPrint_Red "Uninstalling RVM..."
        # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
        rvm implode 2>/dev/null || true
        _JobsPrint_Red "Removing any remaining RVM-related directories..."
        # 输出被重定向到 /dev/null，因此不会在终端显示任何内容
        rm -rf ~/.rvm 2>/dev/null || true
        _JobsPrint_Green "Uninstallation complete."
    fi

    _JobsPrint_Green "Ruby 环境 $version 删除完成"
}
# 遍历所有版本的 Ruby 环境，并进行卸载删除
remove_all_ruby_environments() {
    _JobsPrint_Red "开始删除所有已安装的 Ruby 环境"
    for version in $(rbenv versions --bare); do
        remove_ruby_environment $version # 删除指定版本的 Ruby 环境
    done
    _JobsPrint_Green "所有 Ruby 环境已删除"
}
# 卸载所有已安装的 Ruby 环境
uninstall_Ruby(){
    read "choice?是否卸载删除所有已安装的 Ruby 环境？(y/n): "
    case $choice in
        [Yy]* )
            remove_all_ruby_environments
            ;;
        [Nn]* )
            _JobsPrint_Red "取消卸载删除 Ruby 环境"
            ;;
        * )
            _JobsPrint_Red "无效的选项，取消卸载删除 Ruby 环境"
            ;;
    esac
}
# 升级当前 Rbenv.Ruby 环境
upgrade_current_rbenv_ruby() {
    _JobsPrint_Green "开始升级当前 Ruby 环境"
    rbenv install --list | grep -v -e "^[[:space:]]*$" | grep -v -e "-" | tail -1 | xargs rbenv install -s
    _JobsPrint_Green "升级完成"
}
# 检查并安装 Gem
check_and_setup_gem() {
    # 检查 gem 命令是否已经被注册。输出被重定向到 /dev/null，因此不会在终端显示任何内容
    if command -v gem &> /dev/null; then
        _JobsPrint_Green "Gem 已安装."
        read "reinstall_gem?是否卸载并重新安装 Gem? (按 Enter 键继续，输入任意字符则卸载并重新安装): "
        if [[ -n "$reinstall_gem" ]]; then
            _JobsPrint_Green "正在卸载 Gem..."
            sudo gem uninstall --all --executables gem
            _JobsPrint_Green "Gem 已成功卸载."
            _JobsPrint_Green "正在重新安装 Gem..."
            brew install ruby
            _JobsPrint_Green "Gem 安装成功."
            _JobsPrint_Green "升级 Gem 到最新版本..."
            sudo gem update --system
            _JobsPrint_Green "Gem 已升级到最新版本."
            _JobsPrint_Green "更新 Gem 管理的所有包..."
            sudo gem update
            _JobsPrint_Green "🍺🍺🍺所有包已更新."
        else
            _JobsPrint_Green "不卸载 Gem，跳过安装步骤."
            _JobsPrint_Green "升级 Gem 到最新版本..."
            sudo gem update --system
            _JobsPrint_Green "Gem 已升级到最新版本."
            _JobsPrint_Green "更新 Gem 管理的所有包..."
            sudo gem update
            _JobsPrint_Green "🍺🍺🍺所有包已更新."
        fi
    else
        _JobsPrint_Red "Gem 未安装."
        _JobsPrint_Green "正在安装 Gem..."
        brew install ruby
        _JobsPrint_Green "Gem 安装成功."
        _JobsPrint_Green "升级 Gem 到最新版本..."
        sudo gem update --system
        _JobsPrint_Green "🍺🍺🍺 Gem 已升级到最新版本."
        _JobsPrint_Green "更新 Gem 管理的所有包..."
        sudo gem update
        _JobsPrint_Green "🍺🍺🍺所有 Gem 包已更新."
    fi

    _JobsPrint_Green "重建所有 Gem 扩展..."
    gem pristine --all
    _JobsPrint_Green "所有 Gem 扩展已重建。"

    _JobsPrint_Green "使用全局 gemset..."
    rvm gemset use global

    _JobsPrint_Green "安装 bundler..."
    gem install bundler
    bundler -v   # 检查 bundler 版本

    _JobsPrint_Green "运行 bundle install..."
    # Gemfile 由 Bundler，一个 Ruby 的依赖管理工具，来处理。使用 Gemfile 可以确保所有开发和部署环境中 Ruby 应用的依赖版本一致。
    # Gemfile 支持从多种来源获取 gem，包括 RubyGems 官方站点、GitHub、私有 gem 服务器，甚至是本地路径。
    # 可以在 Gemfile 中使用分组来指定某些 gem 只在特定环境中使用，如开发环境、测试环境和生产环境。这样可以在不同的环境中加载不同的 gem 集，优化性能和资源使用。
    # 安装或更新 gem 后，Bundler 会创建一个 Gemfile.lock 文件，锁定所有依赖的具体版本。这保证了其他人在拉取代码并运行 bundle install 时，即使新版本的 gem 已发布，也会安装相同版本的依赖，确保环境的一致性。
    # Gemfile 是 Ruby 项目中不可或缺的一部分，它通过确保环境之间的一致性来增强项目的可维护性和可扩展性。
    bundle init # 创建一个基本的 Gemfile
    bundle install # 使用 Bundler 安装依赖。安装 Gemfile 中列出的所有 gem。如果已经安装了依赖，Bundler 会根据 Gemfile 检查依赖是否需要更新或保持当前版本。
    bundle update # 更新 gem 至 Gemfile 允许的最新版本。

    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        _JobsPrint_Green "本地当前的 IP 在中国大陆境内."
        _JobsPrint_Green "更换 Gem 源为 https://gems.ruby-china.com/ ..."
        gem sources --remove https://rubygems.org/
        gem sources --add https://gems.ruby-china.com/
        _JobsPrint_Green "Gem 源已更换."
        _JobsPrint_Green "更新 Gem 源列表缓存..."
        gem sources --update
        _JobsPrint_Green "Gem 源列表缓存已更新."
    else
        _JobsPrint_Green "本地当前的 IP 不在中国大陆境内，将移除 Gem 源 https://gems.ruby-china.com/ ..."
        gem sources --remove https://gems.ruby-china.com/
        _JobsPrint_Green "Gem 源已移除."
        _JobsPrint_Green "还原默认 Gem 源..."
        gem sources --add https://rubygems.org/
        _JobsPrint_Green "默认 Gem 源已还原."
        _JobsPrint_Green "更新 Gem 源列表缓存..."
        gem sources --update
        _JobsPrint_Green "Gem 源列表缓存已更新."
    fi

    _JobsPrint_Green "执行 Gem 清理工作..."
    sudo gem clean
    _JobsPrint_Green "Gem 清理工作已完成."
}
# 卸载 CocoaPods
remove_cocoapods() {
    _JobsPrint_Green "查看本地安装过的 CocoaPods 相关内容："
    gem list --local | grep cocoapods

    _JobsPrint_Red "确认删除 CocoaPods？确认请输入 'y'，取消请回车"
    read -n 1 sure
    if [[ $sure == "y" ]]; then
        _JobsPrint_Green "开始卸载 CocoaPods"
        for element in $(gem list --local | grep cocoapods | cut -d" " -f1)
        do
            _JobsPrint_Green "正在卸载 CocoaPods 子模块：$element ......"
            sudo gem uninstall $element
        done
    else
        _JobsPrint_Green "取消卸载 CocoaPods"
    fi
}
# 更新 CocoaPods 本地库
update_cocoapods() {
    _JobsPrint_Green "更新 CocoaPods 本地库..."
    pod repo update
    _JobsPrint_Green "CocoaPods 本地库已更新."
}
# 安装 CocoaPods
install_cocoapods() {
    choice=$(printf "1. 安装稳定版 CocoaPods\n2. 安装预览版 CocoaPods" | fzf --prompt "请选择安装方式：")
    case $choice in
    "1. 安装稳定版 CocoaPods")
        _JobsPrint_Green "正在安装稳定版 CocoaPods..."
        sudo gem install cocoapods
        ;;
    "2. 安装预览版 CocoaPods")
        _JobsPrint_Green "正在安装预览版 CocoaPods..."
        sudo gem install cocoapods --pre
        ;;
    *)
        _JobsPrint_Red "无效的选项，请重新选择。"
        install_cocoapods # 递归安装 CocoaPods
        ;;
    esac
    
    gem install \
      cocoapods-deintegrate \ # 这是一个 CocoaPods 插件，用于从一个项目中移除所有 CocoaPods 的痕迹。它可以清理所有由 CocoaPods 添加的配置和文件，使项目回到未使用 CocoaPods 管理依赖之前的状态。
      cocoapods-downloader \ # 这个 Gem 为 CocoaPods 提供下载功能，支持多种类型的源（如 git, http, svn 等）。它是 CocoaPods 内部使用的组件，也可以单独用于下载特定的库或框架。
      cocoapods-trunk \ # 这是一个用于与 CocoaPods 的 Trunk 服务交互的命令行工具。CocoaPods Trunk 是一个允许开发者提交他们的库到一个中央索引的服务，使得这些库可以被全球的开发者搜索和使用。
      cocoapods-try # 这个插件允许开发者直接尝试使用一个 CocoaPod，而无需手动在项目中集成。它可以快速地克隆一个库的示例项目，安装依赖，并打开这个项目，使得评估和试用第三方库变得更加简单。

    update_cocoapods
    pod cache clean --all
}
# 检查并安装 CocoaPods
check_and_setup_cocoapods() {
    local_ip=$(curl -s https://api.ipify.org)
    china_ip=$(curl -s https://ip.ruby-china.com/ip)
    if [[ "$local_ip" == "$china_ip" ]]; then
        _JobsPrint_Green "本地当前的 IP 在中国大陆境内."
        _JobsPrint_Green "选用清华大学的 CocoaPods 镜像..."
        pod repo remove master
        pod repo add master https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git
    else
        _JobsPrint_Green "本地当前的 IP 不在中国大陆境内，不需要更换 CocoaPods 镜像."
    fi
    if command -v pod &> /dev/null; then
        remove_cocoapods
    else
        _JobsPrint_Red "CocoaPods 未安装."
    fi
    _JobsPrint_Green "开始安装 CocoaPods..."
    install_cocoapods
    _JobsPrint_Green "检查 CocoaPods 的安装是否成功..."
    gem which cocoapods
    # 解决pod 命令只在特定的 Ruby 版本下可用
    # 设置 Ruby 版本为当前正在使用的版本
    rbenv global $(rbenv version-name)
    # 重新编译 rbenv，更新环境变量
    rbenv rehash
    # 检查 pod 命令是否可用
    pod --version
    
    pod repo update
    pod cache clean --all
    pod search Masonry
}
# 主流程
jobs_logo
self_intro
prepare_environment # 准备前置环境
check_xcode_and_tools # 检查 Xcode 和 Xcode Command Line Tools
install_homebrew_normal # 检查并安装 Homebrew
check_and_update_fzf # 检查并安装/更新 fzf
check_and_install_zsh # 检查并安装 zsh
check_Rbenv # 检查并安装 Rbenv
check_ruby_environment # 检查当前的Ruby环境
check_and_update_libyaml # 检查并安装/更新 libyaml
setup_ruby_environment # 安装Ruby环境
fix_rvm_path # 检查并修复 RVM 路径
check_and_setup_gem # 检查并安装 Gem
check_and_setup_cocoapods # 检查并安装 CocoaPods
