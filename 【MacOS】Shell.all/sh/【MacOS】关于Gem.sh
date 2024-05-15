echo "Mac OS 自带Gem"
echo "列出安装源"
gem sources -l
# 如果人在国内那么就需要更换Gem源
gem sources --remove https://rubygems.org/
gem sources --add https://gems.ruby-china.com/
echo "更新安装源缓存"
gem sources -u
echo "更新Gem本身"
gem update --system
echo "查看下目前的Gem的版本"
gem -v
echo "更新所有程序包"
gem update
echo "清理gem"
gem clean
