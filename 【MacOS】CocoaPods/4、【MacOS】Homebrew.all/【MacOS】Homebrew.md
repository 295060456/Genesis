#  MacOS_brew

[toc]
- [MacOS\_brew](#macos_brew)
  - [1、brew 本地文件的下载地址](#1brew-本地文件的下载地址)
  - [2、brew 服务列表](#2brew-服务列表)
  - [3、其他的一些 brew 命令](#3其他的一些-brew-命令)
  - [4、Homebrew Cask](#4homebrew-cask)
    - [4.1、Homebrew Cask 的安装位置](#41homebrew-cask-的安装位置)
## 1、brew 本地文件的下载地址

```shell
➜  ~ open /Users/jobs/Library/Caches/Homebrew/downloads/
```

## 2、brew 服务列表

```bash
➜  ~ brew services list
Warning: Calling plist_options is deprecated! Use service.require_root instead.
Please report this issue to the elastic/tap tap (not Homebrew/brew or Homebrew/homebrew-core), or even better, submit a PR to fix it:
  /opt/homebrew/Library/Taps/elastic/homebrew-tap/Formula/elasticsearch-full.rb:68

Name               Status     User File
elasticsearch-full none            
httpd              started    jobs ~/Library/LaunchAgents/homebrew.mxcl.httpd.plist
lighttpd           none            
mongodb-community  error  512 jobs ~/Library/LaunchAgents/homebrew.mxcl.mongodb-community.plist
mysql              started    jobs ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
nginx              none            
php                none            
tomcat             none            
unbound            none   
```

## 3、其他的一些 brew 命令

```bash
brew list           列出已安装的软件
brew update     更新brew
brew home       用浏览器打开brew的官方网站
brew info         显示软件信息
brew deps        显示包依赖
```

## 4、Homebrew Cask

### 4.1、Homebrew Cask 的安装位置

```bash
➜  ~ brew list cake             
/opt/homebrew/Cellar/cake/3.0.0/bin/cake
/opt/homebrew/Cellar/cake/3.0.0/libexec/cs/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/de/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/es/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/fr/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/it/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/ja/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/ko/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/pl/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/pt-BR/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/ru/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/tr/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/zh-Hans/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/zh-Hant/ (4 files)
/opt/homebrew/Cellar/cake/3.0.0/libexec/ (39 files)
```













