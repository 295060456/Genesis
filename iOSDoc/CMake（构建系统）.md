# CMake

[toc]

##  构建

* 在软件开发中，“构建”指的是将源代码转换为可执行文件、库或其他分发格式的过程。这通常包括编译源代码、链接库和生成最终的可执行文件。构建系统是用于自动化和管理这一过程的工具。
* 构建的过程：（以下是构建过程的一般步骤）
  * **编译（Compile）**： 将源代码文件（如 `.cpp` 或 `.c` 文件）转换为目标文件（`.o` 或 `.obj` 文件）。这一步通常由编译器（如 `gcc` 或 `clang`）完成。
  * **链接（Link）**： 将多个目标文件和库文件链接在一起，生成最终的可执行文件或库。这一步通常由链接器（如 `ld`）完成。
  * **打包（Package）**： 将生成的可执行文件、库和其他资源打包成发布版本，以便分发和安装。
  * **其他步骤**： 这可能包括预处理（Preprocessing）、代码生成（Code Generation）、单元测试（Unit Testing）等。

## [**CMake**](https://cmake.org/) 

* [**CMake**](https://cmake.org/) 是一个开源的跨平台构建系统，它可以管理项目的编译过程。CMake 使用配置文件（通常称为 `CMakeLists.txt` 文件）来生成本地构建系统文件（例如 Makefile、Visual Studio 项目文件等）。这些配置文件描述了项目的源文件、头文件、依赖项和编译选项。

* [**CMake**](https://cmake.org/) 的主要特点和功能：

  * **跨平台支持**： [**CMake**](https://cmake.org/)  支持多种操作系统和编译器，包括 Linux、Windows、macOS，以及 GNU Compiler Collection (GCC)、Clang 和 Microsoft Visual C++ (MSVC) 等编译器。
  * **项目配置**： [**CMake**](https://cmake.org/)  通过 `CMakeLists.txt` 文件来配置项目的构建。这些文件包含了构建目标、源文件、依赖项和编译选项等信息。
  * **构建系统生成**： [**CMake**](https://cmake.org/)  可以生成多种本地构建系统文件，如 Makefile、Ninja 文件、Visual Studio 项目文件、Xcode 项目文件等。
  * **模块和包管理**： [**CMake**](https://cmake.org/)  支持模块和包管理，可以轻松查找和使用第三方库。
  * **测试支持**： [**CMake**](https://cmake.org/)  支持集成测试，通过 CTest 工具可以定义和运行测试。

* MacOS.[**CMake**](https://cmake.org/) 的安装

  * *xcode 本身不自带 [**CMake**](https://cmake.org/)*

    ```
    # 先安装Homebrew环境
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # 利用Homebrew安装cmake
    brew install cmake
    ```

* 使用 [**CMake**](https://cmake.org/)  生成 xcode 项目：

  * *对下面的代码进行构建*

    ```c++
    // main.cpp
    #include <iostream>
    
    int main() {
        std::cout << "Hello, CMake!" << std::endl;
        return 0;
    }
    ```

  * 创建 `CMakeLists.txt`配置文件

    ```cmake
    cmake_minimum_required(VERSION 3.10)  # 指定 CMake 最低版本
    project(HelloCMake)                   # 定义项目名称
    set(CMAKE_CXX_STANDARD 11)            # 指定 C++ 标准
    add_executable(HelloCMake main.cpp)   # 定义可执行文件和源文件
    ```

  * *在终端中，导航到项目目录`build`并运行以下命令：*

    ```shell
    mkdir build
    cd build
    cmake -G "Xcode" ..
    ```

  * [**CMake**](https://cmake.org/)  会在 `build` 目录中生成一个 Xcode 项目文件 `MyProject.xcodeproj`。可以通过 xcode 打开这个文件