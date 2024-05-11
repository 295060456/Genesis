# MacOS_Shell脚本制作CocoaPods库

[toc]

## 1、具体需求描述

```
在 MacOS 平台上，利用 shell 脚本，一键完成下列需求：
1、对本地的某个iOS功能代码模块，制作第三方CocoaPods库;
2、能推到 https://cocoapods.org/ 并能搜索到;
3、保持本地的这个iOS功能代码模块的文件夹结构;
```

## 2、具体操作方案

### 2.1、准备工作：确保已经安装了CocoaPods和Git

*如果还没有安装，请参考CocoaPods和Git的官方文档进行安装。*

### 2.2、在本地创建一个与你的代码模块同名的文件夹，用于组织CocoaPods库的文件结构

### 2.3、进入该文件夹，并初始化Git仓库

```shell
cd your_module_folder
git init
```

### 2.4、创建一个新的Xcode工程，将你的iOS功能代码模块添加到该工程中

### 2.5、制作`podspec`文件

*在该工程的根目录下创建一个名为`podspec`的文件，命名为**YourModuleName.podspec***作为CocoaPods库的描述文件。*

*该文件将包含库的名称、版本、依赖关系等信息。*

*示例内容如下：*

**请根据你的实际情况修改下列参数内容，并确保你的文件结构与`source_files`路径匹配。**

```ruby
Pod::Spec.new do |spec|
  spec.name         = 'YourModuleName'
  spec.version      = '1.0.0'
  spec.summary      = 'A brief description of your module'
  spec.homepage     = 'https://github.com/your_username/YourModuleName'
  spec.license      = 'MIT'
  spec.author       = { 'Your Name' => 'your_email@example.com' }
  spec.source       = { :git => 'https://github.com/your_username/YourModuleName.git', :tag => spec.version.to_s }
  spec.platform     = :ios, '9.0'
  
  spec.source_files = 'YourModuleName/Classes/**/*' 
  ## 或者是
  spec.source_files = "YourModuleName/**/*.{h,m,swift}"
  
  spec.swift_version = "5.0"
  spec.requires_arc = true
  spec.dependency 'Dependency1'
  spec.dependency 'Dependency2'
  spec.dependency "AFNetworking", "~> 3.0"
  # Add more dependencies if needed
end

1、在该iOS功能代码模块的根目录下创建一个podspec文件，命名为"MyModule.podspec"，内容可以参考下面的模板：

Pod::Spec.new do |s|
    s.name         = "MyModule"
    s.version      = "1.0.0"
    s.summary      = "A brief description of MyModule."
    s.description  = "A longer description of MyModule in Markdown format."
    s.homepage     = "https://github.com/your-username/MyModule"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "Your Name" => "your@email.com" }
    s.source       = { :git => "https://github.com/your-username/MyModule.git", :tag => "#{s.version}" }
    s.platform     = :ios, "9.0"
    s.source_files = "MyModule/**/*.{h,m,swift}"
    s.swift_version = "5.0"
    s.dependency "AFNetworking", "~> 3.0"
end
```

### 2.6、检查`podspec`文件

```
pod spec lint MyModule.podspec
```

### 2.7、收尾工作

*按照提示一步一步输入相关信息，最后选择使用刚才创建的podspec文件即可*

```
pod lib create MyModule
```

#### 2.7.1、pod trunk register

*在本地代码模块的根目录下执行*

#### 2.7.2、注册

```
"pod trunk register your-email email-password --verbose"进行注册，
然后执行""上传podspec文件。
```

#### 2.7.3、上传 **podspec** 文件

```
pod trunk push MyModule.podspec --verbose
```

#### 2.7.4、添加、提交并推送代码到远程Git仓库：

```shell
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:your_username/YourModuleName.git
git push -u origin master
```

### 2.8、验证该代码库是否可以在`CocoaPods`中搜索到

*运行以下命令：*

**如果能够搜索到你的库，并显示正确的描述信息，说明推送到CocoaPods成功。**

```
pod search YourModuleName
```

