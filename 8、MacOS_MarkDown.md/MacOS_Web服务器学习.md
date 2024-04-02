# MacOS_Web服务器学习

[toc]
- [Web服务器学习](#web服务器学习)
  - [1、前言](#1前言)
  - [2、`tomcat`](#2tomcat)
    - [2.1、`tomcat`的安装](#21tomcat的安装)
    - [2.2、`tomcat`的开启/关闭/重启](#22tomcat的开启关闭重启)
  - [3、`httpd`](#3httpd)
    - [3.1、`httpd`的安装](#31httpd的安装)
    - [3.2、`httpd`httpd的启动](#32httpdhttpd的启动)
    - [3.3、`httpd`的停止](#33httpd的停止)
    - [3.4、`httpd`的重启](#34httpd的重启)
    - [3.5、`httpd`的相关备注和说明](#35httpd的相关备注和说明)
  - [4、`nginx`](#4nginx)
    - [4.1、`nginx`的安装](#41nginx的安装)
    - [4.2、`nginx`的启动](#42nginx的启动)
    - [4.3、`nginx`的关闭](#43nginx的关闭)
    - [4.4、`nginx`的重启](#44nginx的重启)
    - [4.5、`nginx`的停止](#45nginx的停止)
    - [4.6、重读`nginx`日志文件](#46重读nginx日志文件)
    - [4.7、`nginx`的相关备注和说明](#47nginx的相关备注和说明)

*资料来源*

[**Apache 、Tomcat、Nginx的区别**](https://blog.51cto.com/willis/1852083)

## 1、前言

*MacOS 自带`tomcat`和`apache`，但是建议都用`brew`重新下载进行额外的管理*

```bash
which -a apache
which apache
```

*查找用`brew`管理的软件的安装路径（以`tomat`为例）：*

```bash
brew list tomcat
```

## 2、`tomcat`

### 2.1、`tomcat`的安装

```bash
brew install tomcat
```

### 2.2、`tomcat`的开启/关闭/重启

```
进入tomcat安装目录下的libexec/bin，执行里面对应的sh
```

## 3、`httpd`

### 3.1、`httpd`的安装

```
brew install httpd
```

### 3.2、`httpd`httpd的启动

```
apachectl start
```

### 3.3、`httpd`的停止

```
apachectl stop
```

### 3.4、`httpd`的重启

```
apachectl restart
```

### 3.5、`httpd`的相关备注和说明

*1、默认占用系统`8080`端口，俗称`apache`*

*2、因为是只读所以需要加写权限，然后将默认的8080更改为8081，以及80更改为81（防止其他程序抢夺端口）*

```bash
open /etc/apache2/httpd.conf
```

```bash
<IfDefine SERVER_APP_HAS_DEFAULT_PORTS>
  Listen 8081
</IfDefine>
<IfDefine !SERVER_APP_HAS_DEFAULT_PORTS>
  Listen 81
</IfDefine>
```

## 4、`nginx`

### 4.1、`nginx`的安装

```bash
brew install nginx
```

### 4.2、`nginx`的启动

```bash
nginx
```

### 4.3、`nginx`的关闭

*相当于先查出`nginx`的进程id再使用kill命令强制杀掉进程*

```bash
nginx -s stop
```

### 4.4、`nginx`的重启

```bash
nginx -s reload
```

### 4.5、`nginx`的停止

*待nginx进程处理任务完毕进行停止*

```bash
nginx -s quit
```

### 4.6、重读`nginx`日志文件

```bash
nginx -s reopen
```

### 4.7、`nginx`的相关备注和说明

*1、默认占用系统8080端口*

*2、如果端口被占用则报错如下：*

```
nginx: [emerg] bind() to 0.0.0.0:8080 failed (48: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:8080 failed (48: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:8080 failed (48: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:8080 failed (48: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:8080 failed (48: Address already in use)
nginx: [emerg] still could not bind()
```

*3、查询*

*3.1、查询某个软件（比如：`Nginx`）的进程号*

```
ps aux|grep nginx
```

*3.2、查询端口占用情况（比如查询`8080`端口）*

```
lsof -i tcp:8080
```

*3.3、查询由`brew`管理的`nginx`的安装目录*

```
brew list nginx
```

*3.4、查询`nginx`的配置文件目录*

```
nginx -t（安装目录 ≠ 配置文件目录）
```

