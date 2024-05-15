@echo off

setlocal enabledelayedexpansion

echo ****************** Java环境配置脚本 ******************

set /p choice=”选择下载方式，c表示curl, w表示wget，回车默认使用curl：”
if “%choice%” == “w” (
set download_cmd=wget
) else (
set download_cmd=curl
)

echo 正在检查网络连接…
ping -n 2 www.baidu.com >nul
if %errorlevel% neq 0 (
echo 无法连接外网，请检查网络连接！
pause
exit /b 1
)

echo 正在检查curl或wget是否已安装…
set cmd=
if “!download_cmd!” == “curl” (
set cmd=curl -V
) else (
set cmd=wget -V
)
%cmd% >nul 2>nul
if %errorlevel% neq 0 (
echo 没有安装!download_cmd!，正在安装…
if “!download_cmd!” == “curl” (
powershell -Command “& { iwr -useb https://raw.githubusercontent.com/rainysia/curl-installer/master/install-curl.ps1 | iex }”
) else (
powershell -Command “& { iwr -useb https://raw.githubusercontent.com/rainysia/wget-installer/master/install-wget.ps1 | iex }”
)
)

echo 正在获取当前可用的JDK版本…
set temp_jdk_list=%TEMP%\jdk_list.txt
%download_cmd% -sSL ‘https://www.oracle.com/java/technologies/javase-jdk16-downloads.html‘ | findstr -i “jdk-.*-windows-x64” > %temp_jdk_list%

echo 当前可用的JDK版本为：
type %temp_jdk_list%

set /p jdk_version=”请输入要下载的JDK版本（回车默认下载JDK8）：”
set jdk_version=!jdk_version:-=!
if not defined jdk_version (
set jdk_version=8
)

echo 正在下载JDK !jdk_version!…
set jdk_file=jdk-!jdk_version!-windows-x64.zip
set jdk_url=https://download.oracle.com/otn-pub/java/jdk/!jdk_version.0_291+10/2787e4a523244c269598db4e85c51e0c/!jdk_file!
set wget_cmd=wget -c –no-check-certificate –no-cookies –header “Cookie: oraclelicense=accept-securebackup-cookie”
%download_cmd% –create-dirs -L -C -o %temp_jdk_list%.html -H “Cookie: oraclelicense=accept-securebackup-cookie” %jdk_url%
if %errorlevel% neq 0 (
echo 下载JDK失败，请检查网络连接！
pause
exit /b 1
)

echo JDK下载完成！
start “” %cd%\jdk-!jdk_version!

echo 正在安装JDK，请稍等…
set jdk_install_dir=%ProgramFiles%\Java\jdk-!jdk_version!
if exist “%jdk_install_dir%” (
echo JDK !jdk_version! 已经安装在 %jdk_install_dir% ，无需重新安装！
) else (
7z x -y -o”%ProgramFiles%\Java” %cd%!jdk_file%
echo 安装成功，JDK安装路径为 %jdk_install_dir% 。
)

echo 正在配置环境变量，请稍等…
set jdk_home=%jdk_install_dir%
set path=%jdk_home%\bin;%path%
set java_home=%jdk_home%
echo JDK配置成功，JDK_HOME=%jdk_home% 。

set env_file=%USERPROFILE%\AppData\Local\Microsoft\WindowsApps\jdk_env.bat
if not exist “%env_file%” echo @echo off > “%env_file%”
echo setx JAVA_HOME “%java_home%” /M >> “%env_file%”
echo setx JDK_HOME “%jdk_home%” /M >> “%env_file%”
echo setx PATH “%%JAVA_HOME%%\bin;%%PATH%%” /M >> “%env_file%”
echo 配置JDK环境变量成功，已经保存在 %env_file% 文件里。

echo 请手动运行 jdk_env.bat 以更新环境变量。
pause