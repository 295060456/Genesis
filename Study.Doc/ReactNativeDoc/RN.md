# [<span style="color:red; font-weight:bold;">R</span>eact<span style="color:red; font-weight:bold;">N</span>ative](# https://reactnative.dev/)

[toc]

## 基础知识

* 脚本语言：必须在自己的环境下（解释器）运行，不能完全对接操作系统。比如，`*.js`需要在操作系统里面安装了Node.js以后，才可以运行；

## 一些工具

### Node.js

* Node.js：是一个基于 Chrome V8 引擎的 JavaScript 运行环境。它的特点如下:

  * **事件驱动与非阻塞I/O模型**
    Node.js 采用事件驱动、非阻塞I/O模型,使它非常适合构建高并发应用。通过事件循环,Node.js 可以有效利用系统资源,处理高并发请求。

  * **单线程**
    Node.js 遵循单线程模型,但通过事件循环,它可以支持非常高的并发量。所有I/O操作都是异步完成的,避免了线程上下文切换的开销。

  * **跨平台**
    Node.js 使用 JavaScript 作为编程语言,可以跨多个平台运行,如 Windows、Linux 和 macOS。

  * **高性能**
    Node.js 采用了 Google 的 V8 引擎,它编译和执行 JavaScript 的速度非常快。此外,它使用的非阻塞模型,可以处理很多并发连接,性能表现良好。

  * **丰富的生态系统**
    Node.js 具有庞大且不断增长的包生态系统(npm),开发人员可以很容易地重用社区的代码。

  * **应用场景**
    * Web 服务器
    * 工具构建
    * 游戏服务器
    * 代理服务器
    * 数据流处理等

  总之,Node.js 借助 JavaScript 语言的优势和事件驱动、非阻塞I/O模型, 成为构建高并发、可伸缩网络应用的理想平台。

* [**Node.js**](# https://nodejs.org/en/) 配置（MacOS下载后是`*.pkg`文件，直接运行，自动配置环境变量）

  * ```bash
    This package has installed:
    	•	Node.js v20.12.2 to /usr/local/bin/node
    	•	npm v10.5.0 to /usr/local/bin/npm
    Make sure that /usr/local/bin is in your $PATH.
    ```

  * ```bash
    ➜  Desktop node -v
    v21.7.1
    ```

### npm

npm = **N**ode **P**ackage **M**anager = Node.js 的默认包管理工具。它的主要作用如下:

* **下载安装包**：通过 npm 可以方便地下载安装各种包到本地项目中。例如运行 `npm install express` 就可以下载安装 express 包。

* **管理包版本**：npm 可以很好地管理包的版本,可以指定特定的版本号下载,也可以下载最新版本。

* **管理依赖关系**：包通常会依赖其它包,npm 可以自动解析下载依赖包,并且基于语义化版本号智能地解决版本兼容性问题。

* **运行包脚本**：在包中可以编写脚本,比如构建、测试等,通过 `npm run` 命令可以执行这些脚本。

* **分享代码**：开发者可以将自己开发的包发布到 npm 源,供其他开发者下载使用。

* **创建项目**：npm 可以通过 `npm init` 创建一个标准化的包结构,便于构建新项目。

###  Yarn

* 全称：Yarn Package Manager
* 由**Facebook**开源的**依赖管理工具**
* Yarn ≈ npm，都用于管理 Node.js 项目的依赖包
* Yarn 命令与 npm 基本保持一致。如 `yarn install`、`yarn add`、`yarn upgrade` 等，可以很容易地从 npm 切换到 Yarn。
* Yarn 主要有以下几个特点
  * **离线模式**：在安装过程中,Yarn 会先从缓存中寻找已下载的依赖,减少了不必要的下载,提高了安装速度。
  * **并行操作**：Yarn 采用了并行安装依赖的策略,比 npm 更快更高效。
  * **版本锁定**：Yarn 通过生成 yarn.lock 文件来固定版本,确保在不同系统下依赖版本保持一致。
  * **更简洁的输出**：Yarn 相比 npm 输出更加简洁、易读。
  * **更好的安全性**：在每次安装前,Yarn 会通过验证机制校验每个安装包的完整性。
  * **更好的网页端支持**：Yarn 可直接通过 Node.js 的流重定向到浏览器中运行。

### [watchman](# https://facebook.github.io/watchman/)

* **Facebook**出品，用于监视文件系统的变化

* ```bash
  brew install node
  brew install watchman
  ```

### `react-native-cli`

* `cli` = **C**ommand **L**ine **I**nterface = 命令行界面 = 指的是一种基于纯文本或字符界面与计算机程序进行交互的方式,用户通过输入命令来执行相应的操作；

* 如果之前有安装全局`react-native-cli`包，请将其删除。因为它可能会导致意外问题：

  ```bash
  npm uninstall -g react-native-cli @react-native-community/cli
  ```

* `react-native-cli` 是 React Native 的命令行工具，用于初始化和管理 React Native 项目；

* 它提供了一些命令来创建新的 React Native 项目、运行已有项目、链接本地依赖库等；

* 主要命令包括：

  * ```bash
    react-native init <ProjectName> # 创建一个新的 React Native 项目
    ```

  * ```bash
    react-native run-android # 在 Android 模拟器/设备上运行 React Native 应用
    ```

  * ```bash
    react-native run-ios # 在 iOS 模拟器/设备上运行 React Native 应用
    ```

  * ```bash
    react-native start # 启动 React Native 打包服务器
    ```

  * ```bash
    react-native bundle # 为 iOS 或 Android 平台构建源代码 bundle
    ```

  * ```bash
    react-native link # 链接本地依赖包中的资源(如原生代码、字体等)到原生项目
    ```

  * ```bash
    react-native log-android / log-ios # 显示 Android / iOS 上应用的日志
    ```

  * ```bash
    react-native upgrade # 将项目代码升级到最新的 React Native 版本
    ```

### Expo

Expo 是一个用于构建React Native应用程序的**工具链**。它旨在简化React Native应用程序的开发过程,并提供了许多有用的功能和工具。以下是 Expo 的一些主要特点:

* **快速开始开发**:Expo 提供了一个命令行工具，可以快速创建一个新的React Native项目，无需进行复杂的配置；

* **开发者工具**:Expo 包括一个功能强大的开发者工具，包括实时重新加载、日志记录、远程调试器等功能；

* **SDK**:Expo 提供了一个面向React Native的SDK，**包含许多预先构建的API；如相机、推送通知、文件系统等，减少了与原生模块的集成工作；**

* **Expo Client**:Expo Client是一个用于测试应用的工具。**开发人员可以通过扫描二维码或输入网址在设备或模拟器上立即预览应用；**

* **过渡到纯React Native**:使用Expo开发的应用可以随时"eject"过渡到纯React Native项目,以获得更多的定制能力；

* **支持Web**:使用Expo开发的应用可以编译为Web应用，在浏览器中运行；

* **无需Xcode或Android Studio**:使用Expo,开发人员无需在本地安装Xcode或Android Studio就可以构建React Native应用；

### JavaScript bundler

* JavaScript bundler是一种工具；

* 它的作用是将许多JavaScript文件打包成一个或几个bundled文件；

* 这对于部署Web应用程序或React Native应用程序至关重要；
* 打包的主要原因包括:
  * **减少HTTP请求数**：将多个JavaScript文件合并成单个或少数几个文件，可以大幅减少Web应用程序的HTTP请求数量，从而加快加载速度；
  * **代码拆分**：虽然将所有代码打包到一个文件中可以减少请求数,但文件体积可能过大。代码拆分可以将代码按需加载,先加载入口文件，其他依赖文件延迟加载,优化加载性能；
  * **模块系统**：大多数JavaScript bundler都支持ES6的模块系统，允许您使用import和export语句导入/导出模块，然后将它们打包在一起；
  * **其他优化**：bundler还可以进行其他优化。如：压缩代码、删除死代码、按需加载polyfills等；
* 常见的JavaScript bundler工具包括:
  - **Webpack**：最流行的bundler,具有强大的功能和良好的生态系统。
  - **Rollup**：针对ES模块优化过的bundler,输出结果更扁平化。
  - **Parcel**：零配置的bundler,开箱即用。
  - **Metro**：React Native应用程序的默认bundler。

### Metro 开发服务器

* Metro是React Native应用程序的JavaScript bundler；
* 在React Native中，Metro充当bundler的角色，将React Native应用的JavaScript代码打包成一个单一文件，以优化应用的启动时间和整体性能；
* JavaScript bundler是构建现代JavaScript应用不可或缺的工具；

* Metro最初由**Facebook**为其React Native项目开发，后来成为React Native的标准开发工具；

* 它通过命令`react-native start`或`npx react-native start`启动；

* Metro仅用于开发环境,当您准备发布生产版本时,需要通过`react-native bundle`命令创建一个优化后的JavaScript bundle；

* 它被设计用于在开发过程中提供强大的服务，例如：
  * **缓存bundle**：Metro在第一次构建JavaScript bundle时会比较慢,但后续的增量构建会非常快,因为它会缓存模块。这可以显著加快开发周期；
  * **实时刷新**：Metro支持实时刷新,它允许您在编辑器中更改代码时立即看到更改反映在模拟器或设备上,无需重新编译整个应用程序；
  * **热模块替换(HMR)**：HMR可以在运行时更新React Native应用,而无需重新加载整个应用。这使得反复编辑、检查和调试代码变得更加容易；
  * **源代码映射**：Metro生成的bundle包含源代码映射,方便调试时在源代码级别设置断点和检查变量；
  * **资产解析**：Metro能够解析并正确导入图像、视频、字体等资产文件；
  * **错误捕获**：Metro将编译时和运行时的错误可视化,使排查问题更加简单；





## 新建项目

<span style="color:red; font-weight:bold;">*使用**React Native的内置命令行界面**新建工程*</span>

```bash
➜  Desktop npx react-native@latest init AwesomeProject3
Need to install the following packages:
react-native@0.74.1
Ok to proceed? (y) y

npm warn deprecated @babel/plugin-proposal-optional-catch-binding@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-catch-binding instead.
npm warn deprecated @babel/plugin-proposal-numeric-separator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-numeric-separator instead.
npm warn deprecated @babel/plugin-proposal-nullish-coalescing-operator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-nullish-coalescing-operator instead.
npm warn deprecated @babel/plugin-proposal-class-properties@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-class-properties instead.
npm warn deprecated @babel/plugin-proposal-logical-assignment-operators@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-logical-assignment-operators instead.
npm warn deprecated @babel/plugin-proposal-optional-chaining@7.21.0: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-chaining instead.
npm warn deprecated @babel/plugin-proposal-async-generator-functions@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-async-generator-functions instead.
npm warn deprecated @babel/plugin-proposal-object-rest-spread@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-object-rest-spread instead.
npm warn deprecated querystring@0.2.1: The querystring API is considered Legacy. new code should use the URLSearchParams API instead.
                                                          
               ######                ######               
             ###     ####        ####     ###             
            ##          ###    ###          ##            
            ##             ####             ##            
            ##             ####             ##            
            ##           ##    ##           ##            
            ##         ###      ###         ##            
             ##  ########################  ##             
          ######    ###            ###    ######          
      ###     ##    ##              ##    ##     ###      
   ###         ## ###      ####      ### ##         ###   
  ##           ####      ########      ####           ##  
 ##             ###     ##########     ###             ## 
  ##           ####      ########      ####           ##  
   ###         ## ###      ####      ### ##         ###   
      ###     ##    ##              ##    ##     ###      
          ######    ###            ###    ######          
             ##  ########################  ##             
            ##         ###      ###         ##            
            ##           ##    ##           ##            
            ##             ####             ##            
            ##             ####             ##            
            ##          ###    ###          ##            
             ###     ####        ####     ###             
               ######                ######               
                                                          

                  Welcome to React Native!                
                 Learn once, write anywhere               

✔ Downloading template
✔ Copying template
⠸ Processing template➤ YN0000: You don't seem to have Corepack enabled; we'll have to rely on yarnPath instead
➤ YN0000: Downloading https://repo.yarnpkg.com/3.6.4/packages/yarnpkg-cli/bin/yarn.js
⠼ Processing template➤ YN0000: Saving the new release in .yarn/releases/yarn-3.6.4.cjs
➤ YN0000: Done with warnings in 4s 140ms
⠇ Processing template➤ YN0000: Successfully set nodeLinker to 'node-modules'
✔ Processing template
✔ Installing dependencies
✔ Do you want to install CocoaPods now? Only needed if you run your project in Xcode directly … no


info 💡 To enable automatic CocoaPods installation when building for iOS you can create react-native.config.js with automaticPodsInstallation field. 
For more details, see https://github.com/react-native-community/cli/blob/main/docs/projects.md#projectiosautomaticpodsinstallation
            
✔ Initializing Git repository

  
  Run instructions for Android:
    • Have an Android emulator running (quickest way to get started), or a device connected.
    • cd "/Users/jobs/Desktop/AwesomeProject3" && npx react-native run-android
  
  Run instructions for iOS:
    • cd "/Users/jobs/Desktop/AwesomeProject3/ios"
    
    • Install Cocoapods
      • bundle install # you need to run this only once in your project.
      • bundle exec pod install
      • cd ..
    
    • npx react-native run-ios
    - or -
    • Open AwesomeProject3/ios/AwesomeProject3.xcodeproj in Xcode or run "xed -b ios"
    • Hit the Run button
    
  Run instructions for macOS:
    • See https://aka.ms/ReactNativeGuideMacOS for the latest up-to-date instructions.
    
  
➜  Desktop 
```

<span style="color:red; font-weight:bold;">*使用**npm.npx**新建工程*</span>

```bash
Last login: Sun May  5 21:18:50 on ttys000
➜  Desktop npx create-expo-app AwesomeProject
Need to install the following packages:
create-expo-app@2.3.1
Ok to proceed? (y) y
(node:8334) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
✔ Downloaded and extracted project files.
> npm install
npm WARN deprecated @npmcli/move-file@1.1.2: This functionality has been moved to @npmcli/fs
npm WARN deprecated @babel/plugin-proposal-async-generator-functions@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-async-generator-functions instead.
npm WARN deprecated @babel/plugin-proposal-class-properties@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-class-properties instead.
npm WARN deprecated @babel/plugin-proposal-nullish-coalescing-operator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-nullish-coalescing-operator instead.
npm WARN deprecated @babel/plugin-proposal-logical-assignment-operators@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-logical-assignment-operators instead.
npm WARN deprecated @babel/plugin-proposal-optional-catch-binding@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-catch-binding instead.
npm WARN deprecated @babel/plugin-proposal-optional-chaining@7.21.0: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-chaining instead.
npm WARN deprecated @babel/plugin-proposal-numeric-separator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-numeric-separator instead.
npm WARN deprecated @babel/plugin-proposal-object-rest-spread@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-object-rest-spread instead.

added 1239 packages, and audited 1240 packages in 3m

119 packages are looking for funding
  run `npm fund` for details

5 moderate severity vulnerabilities

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.

✅ Your project is ready!

To run your project, navigate to the directory and run one of the following npm commands.

- cd AwesomeProject
- npm run android
- npm run ios
- npm run web
npm notice 
npm notice New minor version of npm available! 10.5.0 -> 10.7.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v10.7.0
npm notice Run npm install -g npm@10.7.0 to update!
npm notice 
➜  Desktop 
```

<span style="color:red; font-weight:bold;">*使用`yarn`新建工程*</span>

```bash
Last login: Sun May  5 21:39:44 on ttys000
➜  Desktop yarn create expo-app AwesomeProject
yarn create v1.22.22
[1/4] 🔍  Resolving packages...
[2/4] 🚚  Fetching packages...
[3/4] 🔗  Linking dependencies...
[4/4] 🔨  Building fresh packages...

success Installed "create-expo-app@2.3.1" with binaries:
      - create-expo-app
[##] 2/2(node:10472) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
The directory AwesomeProject has files that might be overwritten:

  .expo
  App.js
  app.json
  assets
  babel.config.js
  node_modules
  package-lock.json
  package.json

Try using a new directory name, or moving these files.

error Command failed.
Exit code: 1
Command: /opt/homebrew/bin/create-expo-app
Arguments: AwesomeProject
Directory: /Users/jobs/Desktop
Output:

info Visit https://yarnpkg.com/en/docs/cli/create for documentation about this command.
➜  Desktop yarn create expo-app AwesomeProject2
yarn create v1.22.22
[1/4] 🔍  Resolving packages...
[2/4] 🚚  Fetching packages...
[3/4] 🔗  Linking dependencies...
[4/4] 🔨  Building fresh packages...

success Installed "create-expo-app@2.3.1" with binaries:
      - create-expo-app
[##] 2/2(node:10506) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
✔ Downloaded and extracted project files.
> yarn --version
> yarn install
yarn install v1.22.22
info No lockfile found.
[1/4] 🔍  Resolving packages...
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-async-generator-functions@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-async-generator-functions instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-nullish-coalescing-operator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-nullish-coalescing-operator instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-numeric-separator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-numeric-separator instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-class-properties@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-class-properties instead.
warning expo > @expo/metro-config > babel-preset-fbjs > @babel/plugin-proposal-class-properties@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-class-properties instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-optional-chaining@7.21.0: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-chaining instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-optional-catch-binding@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-catch-binding instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @babel/plugin-proposal-object-rest-spread@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-object-rest-spread instead.
warning expo > @expo/metro-config > babel-preset-fbjs > @babel/plugin-proposal-object-rest-spread@7.20.7: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-object-rest-spread instead.
warning expo > @expo/cli > cacache > @npmcli/move-file@1.1.2: This functionality has been moved to @npmcli/fs
warning expo > babel-preset-expo > @react-native/babel-preset > @react-native/babel-plugin-codegen > @react-native/codegen > jscodeshift > @babel/plugin-proposal-class-properties@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-class-properties instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @react-native/babel-plugin-codegen > @react-native/codegen > jscodeshift > @babel/plugin-proposal-nullish-coalescing-operator@7.18.6: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-nullish-coalescing-operator instead.
warning expo > babel-preset-expo > @react-native/babel-preset > @react-native/babel-plugin-codegen > @react-native/codegen > jscodeshift > @babel/plugin-proposal-optional-chaining@7.21.0: This proposal has been merged to the ECMAScript standard and thus this plugin is no longer maintained. Please use @babel/plugin-transform-optional-chaining instead.
[2/4] 🚚  Fetching packages...
[3/4] 🔗  Linking dependencies...
warning "expo > @expo/metro-config@0.17.7" has unmet peer dependency "@react-native/babel-preset@*".
warning "react-native > @react-native/codegen@0.73.3" has unmet peer dependency "@babel/preset-env@^7.1.6".
[4/4] 🔨  Building fresh packages...
success Saved lockfile.
✨  Done in 55.16s.

✅ Your project is ready!

To run your project, navigate to the directory and run one of the following yarn commands.

- cd AwesomeProject2
- yarn android
- yarn ios
- yarn web
✨  Done in 61.56s.
➜  Desktop 
```

## 运行项目

### 在iOS模拟器上运行

*`npm run ios`*或者`yarn ios`

```
➜  AwesomeProject git:(master) npm run ios

> awesomeproject@1.0.0 ios
> expo start --ios

Starting project at /Users/jobs/Desktop/AwesomeProject
(node:19943) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
Starting Metro Bundler
(node:19943) [DEP0044] DeprecationWarning: The `util.isArray` API is deprecated. Please use `Array.isArray()` instead.
› Opening exp://192.168.0.23:8081 on iPhone Xs
Downloading the Expo Go app [================================================================] 100% 0.0s


▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
█ ▄▄▄▄▄ █   █▄▄▀▄██ ▄▄▄▄▄ █
█ █   █ █ ▀▄ █▀▄▀▄█ █   █ █
█ █▄▄▄█ █▀██▀▀█▀▄██ █▄▄▄█ █
█▄▄▄▄▄▄▄█▄▀▄█ █▄█▄█▄▄▄▄▄▄▄█
█ ▄▀▀  ▄██▀▀▄▀█▄ ███ ▀▄▄ ▄█
█ ▄▄█▀▄▄▄ █▀ ▄██  ▀ █▄  ▀██
█   █ █▄██▀▄█▄▀▄▀▄▀▄▀▀▄ ▀██
███▀▄▀▄▄███▄█▀██▄▄▄█▄▀ ▀███
█▄▄███▄▄█ ▄▀▄▀█▄▄ ▄▄▄ ▀ ▄▄█
█ ▄▄▄▄▄ █▀▄▀ ▄██▀ █▄█ ▀▀█▀█
█ █   █ █▄ ██▄▀▄█▄▄ ▄▄▀   █
█ █▄▄▄█ █▀ ▀█▀█▀▄██▄▀█▀▀ ██
█▄▄▄▄▄▄▄█▄██▄▄▄▄████▄▄▄▄▄▄█

› Metro waiting on exp://192.168.0.23:8081
› Scan the QR code above with Expo Go (Android) or the Camera app (iOS)

› Using Expo Go
› Press s │ switch to development build

› Press a │ open Android
› Press i │ open iOS simulator
› Press w │ open web

› Press j │ open debugger
› Press r │ reload app
› Press m │ toggle menu
› Press o │ open project code in your editor

› Press ? │ show all commands

Logs for your project will appear below. Press Ctrl+C to exit.
› Opening the iOS simulator, this might take a moment.
iOS Bundled 7816ms (node_modules/expo/AppEntry.js)
iOS Bundled 7769ms (node_modules/expo/AppEntry.js)

```

### 在Android模拟器上运行

```bash
➜  AwesomeProject git:(master) npm run android

> awesomeproject@1.0.0 android
> expo start --android

Starting project at /Users/jobs/Desktop/AwesomeProject
(node:21311) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
Starting Metro Bundler
CommandError: No Android connected device found, and no emulators could be started automatically.
Please connect a device or create an emulator (https://docs.expo.dev/workflow/android-studio-emulator).
Then follow the instructions here to enable USB debugging:
https://developer.android.com/studio/run/device.html#developer-device-options. If you are using Genymotion go to Settings -> ADB, select "Use custom Android SDK tools", and point it at your Android SDK directory.
➜  AwesomeProject git:(master) 
```

### 一些错误提示及解决办法

```bash
➜  Desktop cd AwesomeProject
➜  AwesomeProject git:(master) npx expo start
Starting project at /Users/jobs/Desktop/AwesomeProject
(node:9875) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
Starting Metro Bundler
node:events:497
      throw er; // Unhandled 'error' event
      ^

Error: EMFILE: too many open files, watch
    at FSEvent.FSWatcher._handle.onchange (node:internal/fs/watchers:207:21)
Emitted 'error' event on NodeWatcher instance at:
    at FSWatcher._checkedEmitError (/Users/jobs/Desktop/AwesomeProject/node_modules/metro-file-map/src/watchers/NodeWatcher.js:82:12)
    at FSWatcher.emit (node:events:519:28)
    at FSEvent.FSWatcher._handle.onchange (node:internal/fs/watchers:213:12) {
  errno: -24,
  syscall: 'watch',
  code: 'EMFILE',
  filename: null
}

Node.js v21.7.1

/**
这个错误是由于你打开的文件数量超过了系统的限制而导致的。
在启动 Expo 时,Metro Bundler 需要监视大量文件的变化,当打开的文件数量超过系统限制时就会出现 EMFILE: too many open files 错误。
1、增加系统限制
可以尝试临时或永久地增加系统对单个进程可打开文件数的限制。
对于临时增加,可以在终端运行:sudo ulimit -n 8192 （将8192替换为你想要的限制值），然后重新启动 Expo。
对于永久增加,需要编辑系统配置文件,这取决于你的操作系统。
2、使用增量式启动
在启动 Metro Bundler 时使用 --max-workers 选项设置工作线程数量,比如:npx expo start --max-workers 2 ，减少工作线程数可以减少需要监视的文件数。
3、清理已打开的文件
尝试重启 Metro Bundler 或重启你的计算机,以释放之前打开的文件。
4、检查文件监视范围
确保你的项目没有不必要地引入了大量外部文件被监视。
可以在 package.json 中的 metro 配置项中添加 watchFolders 限制需要监视的文件夹范围。
*/
```

