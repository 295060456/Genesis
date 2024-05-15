# 检查安装 brew
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
# 检查安装 you-get
if [[ $(command -v you-get) ]]; then
  echo "you-get is already installed."
else
  echo "you-get is not installed. Installing..."
  # https://you-get.org/
  brew install you-get
fi

read -p "请输入视频源,以回车结束:" videoSource
You-get $videoSource