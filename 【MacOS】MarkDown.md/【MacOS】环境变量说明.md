# 1、MacOS 环境变量

[toc]
- [1、MacOS 环境变量](#1macos-环境变量)
  - [1.1、系统变量的加载顺序](#11系统变量的加载顺序)
    - [1.1.1、🇨🇳【系统级别】](#111系统级别)
    - [1.1.2、👤【当前用户】](#112当前用户)
      - [1.1.2.1、`~/.bash_profile`](#1121bash_profile)
      - [1.1.2.2、`~/.bash_login`](#1122bash_login)
      - [1.1.2.3、`~/.profile`](#1123profile)
      - [1.1.2.4、`~/.bashrc `](#1124bashrc-)
  - [1.2、编辑系统变量](#12编辑系统变量)
    - [1.2.1、相关语法](#121相关语法)
    - [1.2.2、利用第三方软件，编辑环境变量](#122利用第三方软件编辑环境变量)
    - [1.2.3、环境信息生效](#123环境信息生效)
  - [1.3、关于打印输出](#13关于打印输出)
    - [1.3.1、竖排打印环境变量，并输出到本目录下面的 localGoEnvInfo.md文件（易读）](#131竖排打印环境变量并输出到本目录下面的-localgoenvinfomd文件易读)
    - [1.3.2、直接输出（不易读）](#132直接输出不易读)
    - [1.3.3、去除环境变量中的重复项](#133去除环境变量中的重复项)
    - [1.3.4、一些环境变量的打印输出](#134一些环境变量的打印输出)
- [2、第三方的 Bash](#2第三方的-bash)
  - [2.1、Zsh](#21zsh)
    - [2.1.1、【安装】使用 brew 管理的Zsh，而非 MacOS 自带的](#211安装使用-brew-管理的zsh而非-macos-自带的)
      - [2.1.1.1、通过 brew 下载安装 zsh](#2111通过-brew-下载安装-zsh)
      - [2.1.1.2、得到 brew 管理的 Zsh 的安装路径](#2112得到-brew-管理的-zsh-的安装路径)
      - [2.1.1.3、写入环境变量](#2113写入环境变量)
      - [2.1.1.4、更改默认终端](#2114更改默认终端)
      - [2.1.1.5、检查安装](#2115检查安装)
    - [2.1.2、【卸载】使用 brew 管理的Zsh，而非 MacOS 自带的](#212卸载使用-brew-管理的zsh而非-macos-自带的)
      - [2.1.2.1、删除已经配置的环境变量](#2121删除已经配置的环境变量)
      - [2.1.2.2、卸载程序包](#2122卸载程序包)
      - [2.1.2.3、相关疑难杂症](#2123相关疑难杂症)
  - [2.2、Oh-My-Zsh](#22oh-my-zsh)
    - [2.2.1、官方网站](#221官方网站)
    - [2.2.2、【安装】Oh-My-Zsh](#222安装oh-my-zsh)
      - [2.2.2.1、直接安装到本系统](#2221直接安装到本系统)
      - [2.2.2.2、通过 brew 安装 Oh-My-Zsh](#2222通过-brew-安装-oh-my-zsh)
    - [2.2.3、兼容系统配置（新建生成.sh脚本文件）](#223兼容系统配置新建生成sh脚本文件)
      - [2.2.3.1、【方式一】手动添加到文件末尾](#2231方式一手动添加到文件末尾)
      - [2.2.3.2、【方式二】通过运行脚本文件写入](#2232方式二通过运行脚本文件写入)
    - [2.2.4、安装 `Oh-My-Zsh`  插件](#224安装-oh-my-zsh--插件)
      - [2.2.4.1、插件说明](#2241插件说明)
      - [2.2.4.2、一些有用的 `Oh-My-Zsh` 插件](#2242一些有用的-oh-my-zsh-插件)
      - [2.2.4.3、编辑 ~/.zshrc 文件](#2243编辑-zshrc-文件)
      - [2.2.4.4、用于 zsh-completions](#2244用于-zsh-completions)
      - [2.2.4.5、更新设置后重启 Terminal](#2245更新设置后重启-terminal)
    - [2.2.5、【卸载】 Oh-My-Zsh](#225卸载-oh-my-zsh)
      - [2.2.5.1、【卸载】直接安装 Oh-My-Zsh 到本系统](#2251卸载直接安装-oh-my-zsh-到本系统)
      - [2.2.5.2、【卸载】通过 brew 安装 Oh-My-Zsh](#2252卸载通过-brew-安装-oh-my-zsh)
  - [2.3、Oh My Posh](#23oh-my-posh)
    - [2.3.1、Oh My Posh 官方网站](#231oh-my-posh-官方网站)
    - [2.3.2、【安装】 Oh My Posh](#232安装-oh-my-posh)
      - [2.3.2.1、直接安装 Oh My Posh 到本系统](#2321直接安装-oh-my-posh-到本系统)
      - [2.3.2.2、通过 brew 安装 Oh My Posh](#2322通过-brew-安装-oh-my-posh)
    - [2.3.3、【卸载】Oh My Posh](#233卸载oh-my-posh)

*资料来源*

[简书/MAC 设置环境变量PATH 和 查看PATH](https://www.jianshu.com/p/acb1f062a925)

## 1.1、系统变量的加载顺序

### 1.1.1、🇨🇳【系统级别】

`/etc/profile `

```bash
code /etc/profile
```

*✅全局建议修改这个文件：`/etc/paths`* 

```bash
code /etc/paths
```

### 1.1.2、👤【当前用户】

从上到下，若文件存在，则不再往下读取。以此类推

#### 1.1.2.1、`~/.bash_profile`

*🈲建议不修改这个文件，全局（公有）配置，不管是哪个用户，登录时都会读取该文件。该文件包含专用于你的bash shell的bash信息（每个用户都有一个.bashrc文件，在用户目录下） 🈲*

```bash
code ~/.bash_profile
```

**注：因为安装zsh，~/.bash_profile就不会被执行。解决办法有以下两种：**

```bash
1、vim ~/.zshrc 将你要配置到环境变量配置到该文件中即可
2、vim ~/.zshrc 将 source ~/.bash_profile 添加到末尾，这样~/.bash_profile配置的环境变量同样有效

使得配置文件生效 source ~/.zshrc
```

#### 1.1.2.2、`~/.bash_login`

```bash
code ~/.bash_login
```

**注：对于 MacOS，有可能不存在此文件目录**

#### 1.1.2.3、`~/.profile`

*✅该文件为系统的每个用户设置环境信息,当用户第一次登录时,该文件被执行.并从/etc/profile.d目录的配置文件中搜集shell的设置*

```bash
code ~/.profile
```

**注：如果你有对/etc/profile有修改的话必须得重启你的修改才会生效，此修改对每个用户都生效【全局性】**

**注：对于 MacOS,目录/etc/profile.d 有可能不存在**

#### 1.1.2.4、`~/.bashrc `

```
没有上述规则，它是bash shell打开的时候载入的。
不管是何种方式，都会读取此文件。
✅一般在这个文件中添加系统级环境变量
```

```bash
code ~/.bashrc
```

**注：对所有的使用bash的用户修改某个配置并在以后打开的bash都生效的话可以修改这个文件，修改这个文件不用重启，重新打开一个bash即可生效**

## 1.2、编辑系统变量

### 1.2.1、相关语法

```bash
PATH的语法：中间用冒号隔开
export PATH=$PATH:<PATH 1>:<PATH 2>:<PATH 3>:------:<PATH N>
```

### 1.2.2、利用第三方软件，编辑环境变量

*推荐安装 Visual Studio Code；亦可使用`vi`和`vim`进行编辑*

```
code /etc/profile
```

```
code /etc/paths
```

```
code ./.bash_profile
```

```
#(对于 MacOS，有可能不存在此文件目录)

code ./.bash_login
```

```
code ./.profile
```

```
code ./.bashrc
```

### 1.2.3、环境信息生效

*关键词：`source`*

```bash
source /etc/profile
source /etc/paths
source ./.bash_profile
source ./.bash_login
source ./.profile
source ./.bashrc
```

## 1.3、关于打印输出

### 1.3.1、竖排打印环境变量，并输出到本目录下面的 localGoEnvInfo.md文件（易读）

```bash
sed 's/:/\n/g' <<< "$PATH" >> localGoEnvInfo.md
```

### 1.3.2、直接输出（不易读）

```bash
echo $PATH
```

### 1.3.3、去除环境变量中的重复项

注意sed的用法，linux和MacOS不同，linux是Gnu的，MacOS是BSD的

```bash
export PATH=$$PATH | tr ':' '\n' | sort | uniq | tr -s '\n' ':' | sed 's/:$//g')
export PATH=$(echo $PATH | sed 's/:/\'$'\n/g' | sort | uniq | tr -s '\n' ':' | sed 's/:$//g')
```

### 1.3.4、一些环境变量的打印输出

```bash
➜  ~ $exec bash -l

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
```

# 2、第三方的 Bash

*资料来源*

[Installing Zsh and Oh My Zsh on Mac using Homebrew](https://rutger-t.medium.com/installing-zsh-and-oh-my-zsh-on-mac-using-homebrew-af80d266515d)

## 2.1、Zsh

*从 MacOS Catalina Zsh 开始，Zsh 成为 MacOS 默认的登录 shell 和交互 shell*

### 2.1.1、【安装】使用 brew 管理的Zsh，而非 MacOS 自带的

#### 2.1.1.1、通过 brew 下载安装 zsh

```bash
brew install zsh
```

#### 2.1.1.2、得到 brew 管理的 Zsh 的安装路径

```bash
brew list zsh
返回👉🏻
/opt/homebrew/Cellar/zsh/5.9/bin/zsh
/opt/homebrew/Cellar/zsh/5.9/bin/zsh-5.9
/opt/homebrew/Cellar/zsh/5.9/lib/zsh/ (37 files)
/opt/homebrew/Cellar/zsh/5.9/share/info/ (7 files)
/opt/homebrew/Cellar/zsh/5.9/share/man/ (17 files)
/opt/homebrew/Cellar/zsh/5.9/share/zsh/ (1509 files)

路径为：/opt/homebrew/Cellar/zsh/5.9/bin/zsh
```

#### 2.1.1.3、写入环境变量 TODO

```bash
sudo vi /etc/shells
```

```bash
因为是 MacOS 系统受保护区，所以需要复制到新建一个文件，修改并进行整体替换
在 /etc/shells 文末加入：/opt/homebrew/Cellar/zsh/5.9/bin/zsh
```

*shell脚本：echo '/opt/homebrew/Cellar/zsh/5.9/bin/zsh' >> /etc/shells*

```
// TODO
```

#### 2.1.1.4、更改默认终端

```bash
chsh -s /opt/homebrew/Cellar/zsh/5.9/bin/zsh

更改以后重启 Terminal
```

#### 2.1.1.5、检查安装

```bash
echo $SHELL

它应该给出以下结果
/usr/local/bin.zsh
```

### 2.1.2、【卸载】使用 brew 管理的Zsh，而非 MacOS 自带的

#### 2.1.2.1、删除已经配置的环境变量

```bash
brew list zsh
sudo vi /etc/shells
```

#### 2.1.2.2、卸载程序包

```bash
brew uninstall zsh
```

#### 2.1.2.3、相关疑难杂症

*`zshrc` 文件找不到的问题*

```shell
1、创建zshrc
touch .zshrc

2、打开zshrc
open -e .zshrc

3、同步继承系统配置:在zshrc文件里输入 source ~/.bash_profile，然后保存
source ~/.bash_profile

4、刷新环境配置
source .zshrc
```

## 2.2、Oh-My-Zsh

### 2.2.1、官方网站

```javascript
open https://ohmyz.sh/
```

### 2.2.2、【安装】Oh-My-Zsh

#### 2.2.2.1、直接安装到本系统

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
或者
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

#### 2.2.2.2、通过 brew 安装 Oh-My-Zsh

`暂未提供`

### 2.2.3、兼容系统配置（新建生成.sh脚本文件）

#### 2.2.3.1、【方式一】手动添加到文件末尾

`source ~/.bash_profile`

#### 2.2.3.2、【方式二】通过运行脚本文件写入

```shell
#!/bin/bash

grep source ~/.bash_profile
# 防止有些没有安装zsh
if [ $? -eq 1 ] ;then
  echo 'source ~/.bash_profile' >> ~/.zshrc
  source ~/.zshrc
fi
```

### 2.2.4、安装 `Oh-My-Zsh`  插件

#### 2.2.4.1、插件说明

`Oh My Zsh 的一大优点是我们可以使用插件自定义 Zsh`

#### 2.2.4.2、一些有用的 `Oh-My-Zsh` 插件

*zsh-语法高亮*

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

*zsh-完成*

```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
```

*zsh-自动建议*

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### 2.2.4.3、编辑 ~/.zshrc 文件

```shell
将克隆存储库的名称添加到插件列表中：替换 plugins=(git)
plugins=(
 git
 zsh-syntax-highlighting
 zsh-autosuggestions
 zsh-completions
)
```

#### 2.2.4.4、用于 zsh-completions 

```bash
autoload -U compinit && compinit 的命令
```

#### 2.2.4.5、更新设置后重启 Terminal

```shell
source ~/.zshrc
```

### 2.2.5、【卸载】 Oh-My-Zsh

#### 2.2.5.1、【卸载】直接安装 Oh-My-Zsh 到本系统

```
uninstall_oh_my_zsh
```

#### 2.2.5.2、【卸载】通过 brew 安装 Oh-My-Zsh

```
暂不提供
```

## 2.3、Oh My Posh

### 2.3.1、Oh My Posh 官方网站

```bash
open https://ohmyposh.dev/
```

### 2.3.2、【安装】 Oh My Posh

#### 2.3.2.1、直接安装 Oh My Posh 到本系统

`略`

#### 2.3.2.2、通过 brew 安装 Oh My Posh

```bash
brew install oh-my-posh
```

### 2.3.3、【卸载】Oh My Posh

```bash
brew uninstall oh-my-posh
```

