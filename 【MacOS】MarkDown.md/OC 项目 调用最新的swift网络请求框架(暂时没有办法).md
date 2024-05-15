# OC 项目 调用最新的swift网络请求框架(暂时没有办法)

[toc]
- [OC 项目 调用最新的swift网络请求框架(暂时没有办法)](#oc-项目-调用最新的swift网络请求框架暂时没有办法)
  - [1、相关库继承关系Moya : Alamofire](#1相关库继承关系moya--alamofire)
  - [2、数据来源](#2数据来源)
  - [3、OC 和 Swift互相调用](#3oc-和-swift互相调用)
  - [4、架构](#4架构)
  - [5、作者回应](#5作者回应)
## 1、相关库继承关系Moya : Alamofire

```
Moya : Alamofire
```

## 2、数据来源

```JavaScript
http://httpbin.org/
```

*Get请求*

```JavaScript
http://httpbin.org/get
```

*Post请求*

```JavaScript
http://httpbin.org/post
```

*Put请求*

```JavaScript
http://httpbin.org/put
```

## 3、OC 和 Swift互相调用

*OC 调用 Swift*

```
1、被 OC 调用的 swift 类需要继承自 NSObject : runtime机制需要 isa 指针，只有继承 NSObject才能获得isa指针
2、需要暴露的 swift 属性或者方法（用 @objc 修饰）；全部暴露用 @objcMembers 修饰类
3、Xcode 默认生成了用于 OC 调用的 swift 头文件 "项目名-Swift.h",在 OC 类中引用即可 ❤️
```

*Swift 调用 OC(自动生成 ".pch文件" )*

```
1、Xcode 会自动帮我们生成 "项目名-Bridging-Header.h" 文件，并且会在 Build Setting 中指定桥接文件路径
2、在此桥接文件中暴露需要给 Swift 的类 ❤️
```

## 4、架构

```
OC → Tools.swift  → Alamofire
Tools.class : NSObject
```

## 5、作者回应

```javascript
https://github.com/Alamofire/Alamofire/issues/3708
```









































