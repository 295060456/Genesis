#! /bin/sh

# 如果没有执行权限，在这个sh文件的目录下，执行chmod u+x *.sh

brew update
brew install ruby
brew reinstall ruby

echo "检查使用的是否是系统自带的Ruby还是我们自定义的Ruby环境"
echo "查看本机的ruby环境安装目录"
which -a ruby
echo "如果您使用的是Mac OS系统自带的Ruby环境，OS X将回应： /usr/bin/ruby  || 如果您使用的是Gem环境安装的Ruby环境，OS X将回应： /usr/local/opt/ruby/bin/ruby"
which ruby

# Ruby环境变量设置
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

open ~/.bash_profile
open ~/.zshrc

brew cleanup ruby


