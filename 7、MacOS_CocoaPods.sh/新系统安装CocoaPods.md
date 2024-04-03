# 新系统安装[***CocoaPods***](# https://cocoapods.org/)
[toc]
## 资料来源

[***Mac安装Ruby版本管理器（RVM）***](# https://www.jianshu.com/p/e36c0a1c6b49)

[***pod install 报错: can't find gem cocoapods (>= 0.a) with executable pod (Gem::GemNotFoundException)***](# https://www.jianshu.com/p/00ef52c4cd3f)

[***Mac上安装Ruby教程***](# https://blog.csdn.net/u014163312/article/details/124784377)

[***Mac配置Ruby环境和安装Homebrew和CocoaPods***](# https://juejin.cn/post/6950518188798902286)

[***Mac机RVM安装***](# https://www.jianshu.com/p/c459ecfaf9db)

[***切换mac默认的ruby版本***](# https://www.jianshu.com/p/f3e4ae8e14a6)

[***Install Ruby · macOS***](# https://mac.install.guide/ruby/index.html)

[***Do Not Use the MacOS System Ruby***](# https://mac.install.guide/faq/do-not-use-mac-system-ruby/index.html)

[***rvm、Ruby、gem、CocoaPods的安装与卸载***](# https://www.jianshu.com/p/6ddeade2c565)
[***Mac上使用brew另装ruby和gem的新玩法***](# https://www.shuzhiduo.com/A/qVdeEK1gdP/)

[***问题：zsh: command not found: rvm***](# https://blog.csdn.net/shentian885/article/details/113548167)

https://mac.install.guide/ruby/13.html

https://rvm.io/rvm/security

## 安装流程

[***Xcode Command Line Tools***](# Xcode Command Line Tools)=>[***Brew***](# Homebrew)=>[***Ruby环境（RVM）***](# Ruby环境（RVM）)=>[***Ruby.Gems***](# Ruby.Gems)=>[***CocoaPods***](# )

### 准备工作

<span style="color:red; font-weight:bold;">如果没有执行权限，在这个sh文件的目录下，执行chmod u+x **.sh*</span>

*显示Mac OS X上的隐藏文件和文件夹*

```shell
defaults write com.apple.Finder AppleShowAllFiles YES
```
*Mac OS 打开任何来源*

```shell
sudo spctl --master-disable
```

  *查看软件更新列表*

  ```shell
  softwareupdate --list
  ```

### ***Xcode Command Line Tools***

*检查是否安装了 **xcode** 和 **Xcode Command Line Tools***

```shell
#!/bin/bash

# 检查是否安装了完整版的 Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "Xcode 未安装，正在前往 App Store 下载并安装 Xcode，请按照提示进行安装。"
    # 打开 App Store 下载页面
    open -a "App Store" "macappstore://apps.apple.com/app/xcode/id497799835"
    exit 1
fi

# 检查是否安装了 Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
    echo "Xcode Command Line Tools 未安装，正在尝试安装..."
    # 安装 Xcode Command Line Tools
    xcode-select --install
    echo "请按照提示进行安装，安装完成后再次运行此脚本。"
    exit 1
fi

echo "Xcode 和 Xcode Command Line Tools 均已安装。"
```

*查看当前**Xcode Command Line Tools**的版本*

```shell
llvm-gcc --version
```
*安装**Xcode Command Line Tools***

```shell
xcode-select —install
```
*删除**Xcode Command Line Tools***

```shell
sudo rm -rf /Library/Developer/CommandLineTools
```
*更新升级**Xcode Command Line Tools**（方式一）: 安装所有更新*

```shell
softwareupdate --install -a
```
*更新升级**Xcode Command Line Tools**（方式二）:亦可前往[**苹果官网**](# https://developer.apple.com/download/more/ )手动下载*
<span style="color:red; font-weight:bold;">**温馨提示：个别地区（例如：柬埔寨），是禁止对其进行访问。此时需要开启VPN，将IP置于美国，方可访问**</span>

### [***Homebrew***](# https://brew.sh/)

<span style="color:red; font-weight:bold;">**[*Homebrew*](# https://brew.sh/)不会自动移除旧版本的软件包**</span>

*检测是否已经安装了[**Homebrew**](# https://brew.sh/)*

```bash
#!/bin/bash

if ! command -v brew &> /dev/null
then
    echo "brew 未安装，开始安装..."
    open https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew 已经安装，跳过安装步骤。"
    echo "检查更新 Homebrew..."
    brew update
    echo "升级 Homebrew 和由 Homebrew 管理的程序包..."
    brew upgrade
    echo "正在执行 Homebrew 清理工作..."
    brew cleanup
    echo "完成更新和清理。"
    brew doctor
    brew -v
fi
```

*[**Homebrew**](# https://brew.sh/)环境变量设置*

```shell
#!/bin/bash

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
open /Users/$(whoami)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

*安装一些由[**Homebrew**](# https://brew.sh/)管理的包*

```shell
brew install llvm
brew install wget
brew install cake
#brew install clang-format
#brew install docker
#brew install git
#brew install maven
#brew install openjdk
#brew install tomcat
#brew install yarn
```

*移除旧版本的[**Homebrew**](# https://brew.sh/)软件包*

```shell
brew cleanup
```

### [***Ruby环境（RVM）***](# https://rvm.io/)

#### 使用RVM原因

* 虽然 macOS 自带了一个 Ruby 环境（阉割版），但是是系统自己使用的，所以权限很小，只有 system；
* MacOS Monterey 中的系统 Ruby 是 Ruby 2.6.8（相对较老的版本）； 
* 而/Library 目录是 root 权限,所以很多会提示无权限；
* 使用自带Ruby更新,管理不方便；
* 一系列无原因的报错；

#### RVM和Ruby的关系

* [***RVM（**R**uby **V**ersion **M**anager）***](# # https://rvm.io/)是一个用于管理 Ruby 版本的工具；
* 它允许用户在同一台机器上同时安装多个 Ruby 版本，并能够轻松地在这些版本之间切换；
* RVM 还可以为每个 Ruby 版本创建独立的 gemsets（Gem 环境），使用户能够在不同的项目中使用不同的 Gem 环境，从而避免 Gem 版本冲突；
* 在您安装了另一个版本的 Ruby 之后，将系统 Ruby 留在原处，不要试图删除它。因为某些应用程序（或 Apple 的系统软件）可能希望找到它；

#### 安装Ruby环境[***RVM***](# https://rvm.io/)

* 利用[***Homebrew***](# Homebrew)安装Ruby环境[***RVM***](# https://rvm.io/)

*此种安装方式，会将 Ruby 安装到系统级别。对所有用户都可用。* [**安装失败参考**](# https://ruby-china.org/topics/40922)

```shell
brew install ruby
```

* [***RVM***](# https://rvm.io/)官方推荐的安装方式

*此种安装方式，针对当前用户。只有安装了 RVM 的用户才能够使用*

```shell
\curl -sSL https://get.rvm.io | bash -s stable --ruby --auto-dotfiles
```

* 手动安装[***RVM***](# https://rvm.io/)

  * *下载*[***RVM***](# https://rvm.io/)

    ```shell
    git clone https://github.com/rvm/rvm.git
    ```

  * 安装[***RVM***](# https://rvm.io/)：打开`rvm/bin`文件夹，双击`rvm-installer`

  ```shell
  open rvm/bin
  ```

  * 启用[***RVM***](# https://rvm.io/)指令

  ```shell
  source ~/.rvm/scripts/rvm
  open ~/.rvm/scripts/rvm
  ```

### 检查当前系统Ruby环境的安装方式

*检查当前Ruby环境是否是通过RVM官方推荐的方式（非[**Homebrew**](# Homebrew)方式）安装的*

```shell
#!/bin/bash

if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
    echo "当前Ruby环境是通过RVM官方推荐的方式安装的。"
fi
```

*检查当前Ruby环境是否是通过[**Homebrew**](# Homebrew)安装的*

```shell
#!/bin/bash

if brew list --formula | grep -q ruby; then
    echo "当前Ruby环境是通过HomeBrew的方式安装的。"
    brew upgrade ruby
fi
```

*检查当前Ruby环境是否是MacOS自带的*

```shell
#!/bin/bash

if [[ $(which ruby) == "/usr/bin/ruby" ]]; then
    echo "MacOS自带的Ruby环境，请安装HomeBrew或使用其他方式安装Ruby。"
    # 必须停下来，因为系统自带的Ruby环境是阉割版，无法往下进行
    exit 0
fi
```

#### 通过手动输入版本号来切换Ruby环境

```shell
#!/bin/bash

# 列出已安装的 Ruby 版本
echo "已安装的 Ruby 版本："
rvm list
# 提示用户输入要切换的 Ruby 版本号
echo "请输入要切换的 Ruby 版本号："
read version
# 使用 RVM 切换 Ruby 版本
rvm use $version
# 检查是否成功切换
if [ $? -eq 0 ]; then
    echo "成功切换到 Ruby $version 环境！"
else
    echo "切换到 Ruby $version 环境失败，请检查输入的版本号是否正确。"
fi
```

#### `rvm automount`

<span style="color:red; font-weight:bold;">**简化 RVM 的配置过程，使得用户无需手动编辑 shell 配置文件来启用 RVM。**</span>

* 自动检测当前用户使用的 shell 类型（如 Bash、Zsh 等），根据用户的 shell 类型，自动将 RVM 初始化脚本添加到对应的 shell 配置文件中。比如，
  * 对于 Bash 用户，会将 RVM 初始化脚本添加到 `~/.bash_profile` 或 `~/.bashrc` 文件中；
  * 对于 Zsh 用户，会将其添加到 `~/.zprofile` 或 `~/.zshrc` 文件中；
* 这样，每次用户登录到系统时，系统会自动执行对应的 shell 配置文件，从而使 RVM 初始化脚本生效，确保 RVM 可以正确运行；

#### 检查使用的是否是系统自带的Ruby还是我们自定义的Ruby环境

```shell
#!/bin/bash

# 检查系统自带的 Ruby 版本
system_ruby=$(which ruby)
# 检查自定义的 Ruby 环境
custom_ruby=$(echo $PATH | tr ':' '\n' | grep -E 'rvm|rbenv' | head -n 1)

if [ -n "$custom_ruby" ]; then
    echo "当前使用的是自定义的 Ruby 环境，安装位置：$custom_ruby"
else
    echo "当前使用的是系统自带的 Ruby，安装位置：$system_ruby"
fi
```

#### 一些命令详解

*清理安装的 Ruby 版本的旧版本*

```shell
brew cleanup ruby
```

*检查使用哪个版本的Ruby OS X*

```
ruby -v
```

*查看当前已安装 ruby 版本*

```shell
rvm list
```

*查看本机的ruby环境安装目录*

* <span style="color:red; font-weight:bold;">***如果使用的是Mac OS系统自带的Ruby环境，OS X将回应： `/usr/bin/ruby `***</span>

* <span style="color:red; font-weight:bold;">*如果使用的是[**Gem**](# Gem)环境安装的Ruby环境，OS X将回应： `/usr/local/opt/ruby/bin/ruby`*</span>

```shell
# -a 选项告诉 which 命令不要停止在找到第一个匹配项后停止搜索，而是继续搜索并显示所有匹配项的路径
# 如果系统中有多个 ruby 可执行文件，which -a ruby 将显示所有匹配项的路径。
which -a ruby
```

#### Ruby环境变量设置

```shell
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

open ~/.bash_profile
open ~/.zshrc
```

#### 完全删除RVM

* ***删除 RVM 安装脚本：***

*在终端中运行以下命令，以删除 RVM的安装脚本：*

```bash
rm -rf ~/.rvm
```

* ***编辑 shell 配置文件：***

*打开shell配置文件（例如 `.bashrc`, `.bash_profile`, `.zshrc` 等），删除任何与 RVM 相关的行。*

*可以使用文本编辑器进行编辑。比如：*

```bash
nano ~/.bashrc
```

* ***删除 RVM 相关的环境变量：***

*如果你在配置文件中设置了 RVM 的环境变量，确保将其删除。一般情况下，这些变量包括 `rvm_path`、`rvm_bin_path` 等。*

* ***重新加载 shell 配置：***

*执行以下命令，以使更改生效：*

```bash
source ~/.bashrc
```

*或者，如果你使用的是 `zsh`：*

```bash
source ~/.zshrc
```

* **检查是否成功卸载：**

*运行以下命令，检查是否仍然存在 RVM：*

```bash
which rvm
```

如果返回空值，那么 RVM 已成功卸载。

<span style="color:red; font-weight:bold;">***确保在删除任何东西之前备份你的数据。***</span>

### [***Ruby.Gems***](# https://rubygems.org/)

#### 关于[***Ruby.Gems***](# https://rubygems.org/)

* [***Gem***](# https://rubygems.org/) 是 Ruby 社区中用于管理 Ruby 程序包（也称为 Gem 包）的包管理器；
* Mac OS 自带 [***Gem***](# https://rubygems.org/) 
* 它类似于其他语言中的包管理工具，如 Python 中的 pip、Node.js 中的 npm 等；
* [***Gem***](# https://rubygems.org/) 提供了一种简单的方式来安装、升级和管理 Ruby 程序包，并管理这些程序包之间的依赖关系；
* 以下是 Gem 的一些主要特性和用途：
  * **安装和管理 Gems**：Gem 允许用户通过简单的命令行接口来安装、升级和卸载 Gems。用户可以通过 `gem install`、`gem update` 和 `gem uninstall` 等命令来执行这些操作；
  * [***Gem 源***](# RubyGems.org)：[***Gem***](# https://rubygems.org/) 提供了一个默认的 Gems 源，称为 RubyGems.org。用户可以从这个源中获取大多数 Gems。此外，用户也可以添加其他自定义的 Gems 源，以获取其他来源的 Gems；
  * **Gemfile 和 Bundler**：Gemfile 是一个用于描述项目依赖关系的文件，通常与 Bundler 一起使用。Bundler 是 [***Gem***](# https://rubygems.org/)  的一个附加工具，用于管理项目中的 Gems 依赖关系。通过在 Gemfile 中列出所需的 Gems 和版本信息，Bundler 可以确保项目的开发环境与生产环境保持一致；
  * **Gemspec 文件**：[***Gem***](# https://rubygems.org/) 包通常包含一个 gemspec 文件，用于描述 [***Gem***](# https://rubygems.org/) 的元数据，如名称、版本、作者、依赖关系等。这个文件使得 Gems 能够被正确地安装和管理，并与其他 Gems 协作；
  * **Gem 开发工具**：[***Gem***](# https://rubygems.org/) 还提供了一些开发工具，用于创建、打包和发布 Gems。通过使用 `gem build` 和 `gem push` 等命令，开发者可以将他们自己编写的 Gems 分发给其他人使用；

<span style="color:red; font-weight:bold;">***总的来说，Gem 是 Ruby 社区中非常重要的一个工具，它使得 Ruby 开发者能够轻松地管理程序包，并通过分享 Gems 来促进代码共享和协作。***</span>


#### [***Gem***](# https://rubygems.org/)源

* 列出[***Gem***](# https://rubygems.org/)安装源

```shell
gem sources -l
```

* 如果人在中国大陆境内，那么就需要更换[***Gem***](# https://rubygems.org/)源

```shell
gem sources --remove https://rubygems.org/
gem sources --add https://gems.ruby-china.com/
```

* 更新[***Gem***](# https://rubygems.org/)的源列表缓存

```
gem sources -u
```

* 更新[***Gem***](# https://rubygems.org/)本身

*安装到默认的 gem 目录中*

```shell
sudo gem update --system
```

*-n 选项用于指定一个新的安装路径。RubyGems 更新工具 rubygems-update 实际上并不会被安装到指定的新路径，因为 -n 选项只影响更新后的 RubyGems 可执行文件的安装路径，而不影响更新过程中所使用的工具的安装路径。因此，这个命令和第一个命令效果相同，都会将更新后的 RubyGems 安装到默认的 gem 目录中*

```shell
sudo gem update --system -n /usr/local/bin
```

*这个命令并没有更新 RubyGems 系统自身，而只是安装了更新工具。要使用更新工具来更新 RubyGems 系统，你需要单独执行命令 sudo update_rubygems*

```
sudo gem install -n /usr/local/bin rubygems-update
```

* ##### 查看下目前的[***Gem***](# https://rubygems.org/)的版本

```shell
gem -v
```

* 更新[***Gem***](# https://rubygems.org/)包

*更新所有 gem 包*

```shell
gem update
```

*更新指定的 gem 包*

```shell
gem update gem_name
```

<span style="color:red; font-weight:bold;">***需要注意的是，有时更新 gem 包可能会导致现有代码出现兼容性问题，因此在执行更新之前最好确保备份了你的代码或者使用了合适的版本管理工具。***</span>

* 清理[***Gem***](# https://rubygems.org/)

```shell
sudo gem clean
```

#### 安装[***Ruby.Gems***](# https://rubygems.org/)

大多数情况下，[***Ruby.Gems***](# https://rubygems.org/) 会随着 Ruby 的安装一起自动安装

*[检查安装](# 查看下目前的Gem的版本)[**Ruby.Gems**](# https://rubygems.org/)*

### [***CocoaPods***](# https://cocoapods.org/)

*使用[**Ruby.Gems**](# https://rubygems.org/)安装[**CocoaPods**](# https://cocoapods.org/)*

```shell
sudo gem install cocoapods -n /usr/local/bin
```

*选择预览版[**CocoaPods**](# https://cocoapods.org/)*

```shell
sudo gem install cocoapods --pre
```

*如果安装了多个Xcode使用下面的命令选择（一般需要选择最近的Xcode版本）*

```shell
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
```

*安装[**CocoaPods**](# https://cocoapods.org/)本地库*

```shell
git clone https://github.com/CocoaPods/Specs.git ~/.cocoapods/repos/trunk
```

*如果在中国大陆境内，那么就选用清华大学的镜像地址*

```shell
git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git  ~/.cocoapods/repos/trunk
```

*更新本地的[**CocoaPods**](# https://cocoapods.org/)仓库索引，确保项目中可以访问到最新的第三方库，并且可以查看最新的版本信息*

```shell
pod repo update
```

*检查一下安装的成果*

```shell
pod search Masonry
```

*卸载[**CocoaPods**](# https://cocoapods.org/)*

* 如果出现root用户没有`/user/bin`权限,那是由于系统启用了SIP（**S**ystem **I**ntegerity **P**rotection）导致root用户也没有修改权限，所以我们需要屏蔽掉这个功能

  * 重启电脑

  * `command + R `进入recover模式

  * 点击最上方菜单使用工具，选择终端，并运行命令👇🏻

  * ```
    csrutil disable
    ```

  * 重新启动电脑

```shell
echo "查看本地安装过的cocopods相关东西"
gem list --local | grep cocoapods

echo "确认删除CocoaPods？确认请回车" # 参数-n的作用是不换行，echo默认换行
read sure                           # 把键盘输入放入变量sure

if [[ $sure = "" ]];then
echo "开始卸载CocoaPods"
#sudo gem uninstall cocoapods

for element in `gem list --local | grep cocoapods`
    do
        echo $"正在卸载CocoaPods子模块："$element$"......"
        # 使用命令逐个删除
        sudo gem uninstall $element
    done
else
    echo "取消卸载CocoaPods"
fi

exit 0
```

*手动安装*

* [**CocoaPods**](# https://cocoapods.org/)文件：https://github.com/CocoaPods/Specs 把下载的文件文件夹名改为trunk，并放在路径`~/.cocoapods/repos`下

* `.git`隐藏文件夹：https://github.com/ShaeZhuJiu/CocoaPadHiddenFileGit.git 把.git.zip解压缩然后将.git隐藏文件放在`~/.cocoapods/repos/trunk`路径下

## 错误提示汇总

* <span style="color:red; font-weight:bold;">***`ERROR:  Error installing rubygems-update:` `ERROR:  While executing gem ... (NoMethodError)`***</span>

  ```shell
  ➜  Desktop sudo gem update --system -n /usr/local/bin
  Password:
  Sorry, try again.
  Password:
  Updating rubygems-update
  Fetching rubygems-update-3.5.7.gem
  ERROR:  Error installing rubygems-update:
  	There are no versions of rubygems-update (= 3.5.7) compatible with your Ruby & RubyGems
  	rubygems-update requires Ruby version >= 3.0.0. The current ruby version is 2.6.10.210.
  ERROR:  While executing gem ... (NoMethodError)
      undefined method `version' for nil:NilClass
  ```

  这个错误是因为你当前的 Ruby 版本不符合要求，而更新 RubyGems 需要 Ruby 版本大于或等于 3.0.0。解决这个问题的方法之一是升级你的 Ruby 版本。以下是解决方法的一般步骤：

  1. **安装 Ruby 3.0.0 或更高版本**：你可以使用合适的方法安装 Ruby 3.0.0 或更高版本。可以通过 RVM（Ruby Version Manager）或 rbenv 这样的工具来管理 Ruby 版本。

  2. **更新 RubyGems**：一旦你的 Ruby 版本满足要求，你就可以再次尝试更新 RubyGems。

  具体操作步骤如下：

  首先，确保你已经安装了 RVM。你可以在终端中运行以下命令来安装 RVM：

  ```bash
  \curl -sSL https://get.rvm.io | bash -s stable
  ```

  然后退出当前终端窗口并重新打开一个新的终端窗口，以确保 RVM 被正确加载。

  接下来，安装 Ruby 3.0.0。运行以下命令：

  ```bash
  rvm install 3.0.0
  ```

  安装完成后，设置 Ruby 3.0.0 为默认版本：

  ```bash
  rvm use 3.0.0 --default
  ```

  现在，你已经升级了 Ruby 版本，再次尝试更新 RubyGems：

  ```bash
  sudo gem update --system -n /usr/local/bin
  ```

  这次应该不会再出现错误了。

* <span style="color:red; font-weight:bold;">***`Error running '__rvm_make -j8',`***</span>

  ```shell
  Error running '__rvm_make -j8',
  please read /Users/jobs/.rvm/log/1712070186_ruby-3.0.0/make.log
  
  There has been an error while running make. Halting the installation.
  ```

   这个错误表明在编译 Ruby 3.0.0 时出现了问题，导致安装过程中止。通常这种情况下，你需要查看相关的日志文件以了解具体的错误信息。在这种情况下，错误信息在 `/Users/jobs/.rvm/log/1712070186_ruby-3.0.0/make.log` 中。

  你可以打开这个日志文件，查看其中的详细错误信息。常见的问题可能包括缺少所需的依赖项或系统设置问题。根据日志中的错误信息，你可以采取适当的措施来解决问题。

  以下是一些可能的解决方案：

  1. **安装所需的依赖项**：Ruby 编译过程可能需要一些依赖项。在 Ubuntu 或类似的系统中，你可以使用以下命令安装所需的依赖项：

     ```bash
     sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
     ```

     对于其他系统，请参考官方文档或相关文档以获取正确的依赖项安装方式。

  2. **检查系统设置**：某些系统设置可能会影响 Ruby 的编译过程。确保你的系统设置符合 Ruby 编译的要求。

  3. **更新 RVM**：确保你正在使用最新版本的 RVM。你可以运行以下命令来更新 RVM：

     ```bash
     rvm get stable
     ```

     然后重新运行 Ruby 安装命令。

  4. **检查 make.log 文件**：详细查看 `make.log` 文件，尤其是错误信息和警告信息，以便更好地理解问题所在。

  根据 `make.log` 中的具体错误信息，你可以进一步采取适当的措施来解决问题。

* <span style="color:red; font-weight:bold;">***`gpg: command not found`***</span>

  ```shell
  brew uninstall gpg gnupg gnupg2
  echo "正在删除 /usr/local/etc/gnupg"
  rm -rf /usr/local/etc/gnupg
  echo "正在删除 /usr/local/etc/gnupg/scdaemon.conf"
  rm -rf /usr/local/etc/gnupg/scdaemon.conf
  brew reinstall gpg #gpg、gnupg、gnupg2 是一样的
  brew link gpg
  ```

* <span style="color:red; font-weight:bold;">***`某些时候因使用 brew 安装工具导致 ruby 环境错乱，执行 pod install 时报错提示找不到 gem 可执行文件的解决方案`***</span>

  *重新安装（升级） Ruby 环境（默认安装最新版本）*

    ```shell
    rvm reinstall ruby --disable-binary
    ```
  
  ```
  --disable-binary 是 rvm reinstall ruby 命令的一个选项，用于指示 RVM 在重新安装 Ruby 时禁用二进制安装。
  
  在默认情况下，RVM 在安装 Ruby 时会尝试使用预编译的二进制版本（如果可用），以提高安装速度。这种预编译的二进制版本通常是从 Ruby 官方提供的镜像服务器获取的，并且已经编译好了，因此安装速度较快。
  
  但是，在某些情况下，用户可能更喜欢从源代码编译 Ruby。例如，用户可能希望自定义 Ruby 的编译选项，或者可能需要在非常规系统配置下编译 Ruby。在这种情况下，使用 --disable-binary 选项可以告诉 RVM 禁用二进制安装，强制 RVM 从源代码编译并安装 Ruby。
  
  因此，rvm reinstall ruby --disable-binary 命令将会重新安装 Ruby，并且强制 RVM 使用源代码编译的方式进行安装，而不是使用预编译的二进制版本。
  ```
  
  





