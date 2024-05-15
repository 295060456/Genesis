#! /bin/sh

echo "Mac隐私打开任何来源命令"
sudo spctl --master-disable
#echo "Mac隐私关闭任何来源命令"
#sudo spctl --master-enable

echo "显示隐藏文件"
defaults write com.apple.finder AppleShowAllFiles -bool true
#echo "不显示隐藏文件"
#defaults write com.apple.finder AppleShowAllFiles -bool false

echo "安装oh-my-zsh" # https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 兼容系统配置（因为安装zsh，~/.bash_profile就不会被执行）
grep GOPATH ~/.zshrc
# 防止有些没有安装zsh
if [ $? -eq 1 ] ;then
  echo 'source ~/.bash_profile' >> ~/.zshrc
  source ~/.zshrc
fi

echo "ZSH权限问题"
# 更新完zsh目录权限问题的解决 https://www.jianshu.com/p/03bcc3e2930e
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

chmod 755 /Users/$(whoami)/.oh-my-zsh
chmod 755 /Users/$(whoami)/.oh-my-zsh/custom/plugins
#chmod 755 /Users/$(whoami)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
chmod 755 /Users/$(whoami)/.oh-my-zsh/plugins
chmod 755 /Users/$(whoami)/.oh-my-zsh/plugins/git
chmod 755 /usr/local/share/zsh

