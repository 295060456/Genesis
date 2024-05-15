#! /bin/sh
# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh

# 检查当前Ruby环境
check_ruby_environment() {
    echo "检查使用的是否是系统自带的 Ruby 还是我们自定义的 Ruby 环境"
    echo "查看本机的 Ruby 环境安装目录"
    which -a ruby
    echo "如果您使用的是 Mac OS 系统自带的 Ruby 环境，OS X将回应： /usr/bin/ruby"
    echo "如果您使用的是 Gem 环境安装的 Ruby 环境，OS X将回应： /usr/local/opt/ruby/bin/ruby"
}

# 设置 Ruby 环境变量（检查要被写入的文件里面是否存在定义，防止重复添加）
setup_ruby_environment() {
    local ruby_path="/usr/local/opt/ruby/bin"

    # 检查 ~/.bash_profile 是否已经包含了相同路径
    if ! grep -qE "^\s*export PATH=\"$ruby_path:\$PATH\"" ~/.bash_profile; then
        echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
        source ~/.bash_profile
    fi
    
    # 检查 ~/.zshrc 是否已经包含了相同路径
    if ! grep -qE "^\s*export PATH=\"$ruby_path:\$PATH\"" ~/.zshrc; then
        echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
        source ~/.zshrc
    fi

    # 打开 ~/.bash_profile 和 ~/.zshrc
    open ~/.bash_profile
    open ~/.zshrc
}

# 检查 macOS 系统自带的 Ruby 环境
check_system_ruby() {
    if command -v ruby >/dev/null 2>&1; then
        echo "系统自带的 Ruby 环境存在"
        return 0
    else
        echo "系统自带的 Ruby 环境不存在"
        return 1
    fi
}

# 检查 Brew 安装的 Ruby 环境
check_brew_ruby() {
    if command -v brew >/dev/null 2>&1 && brew list ruby >/dev/null 2>&1; then
        echo "通过 Brew 安装的 Ruby 环境存在"
        return 0
    else
        echo "通过 Brew 安装的 Ruby 环境不存在"
        return 1
    fi
}

# 检查 Rbenv 安装的 Ruby 环境
check_rbenv_ruby() {
    if command -v rbenv >/dev/null 2>&1 && rbenv versions | grep -q "system"; then
        echo "通过 Rbenv 安装的 Ruby 环境存在"
        return 0
    else
        echo "通过 Rbenv 安装的 Ruby 环境不存在"
        return 1
    fi
}

# 升级系统当前使用的 Ruby 环境
upgrade_ruby() {
    if check_system_ruby; then
        echo "正在升级系统自带的 Ruby 环境..."
        sudo gem update --system
        echo "系统自带的 Ruby 环境已升级完成"
    elif check_brew_ruby; then
        echo "正在升级通过 Brew 安装的 Ruby 环境..."
        brew update
        brew upgrade ruby
        brew cleanup ruby
        echo "通过 Brew 安装的 Ruby 环境已升级完成"
    elif check_rbenv_ruby; then
        echo "正在升级通过 Rbenv 安装的 Ruby 环境..."
        rbenv install --list | grep -v - | tail -1 | xargs -I {} rbenv install {}
        rbenv global $(rbenv versions --bare | grep -v - | tail -1)
        echo "通过 Rbenv 安装的 Ruby 环境已升级完成"
    else
        echo "未找到可用的 Ruby 环境"
    fi
}

# 检查并升级 Ruby 环境
upgrade_ruby
