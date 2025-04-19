::Version: beta 0.5.25.03.20
::by MAXOUYT
::--------设置代码页编码--------
chcp 65001
::-----------------------------
@echo off

::获取当前时间戳
for /f "tokens=1-3 delims=/ " %%a in ("%date%")do (
    set YEAR=%%a
    set MONTH=%%b
    set DAY=%%c
)
for /f "tokens=1-3 delims=:." %%a in ("%time%") do (
    set HOUR=%%a
    set MINUTE=%%b
    set SECOND=%%c
)
set TIMESTAMP=%YEAR%.%MONTH%.%DAY%_%HOUR%-%MINUTE%-%SECOND%

echo 正在压缩指定文件夹......

::---------------配置变量---------------
bz.exe a -r "%~dp0test-%TIMESTAMP%.zip" D:\Desktop\test
set DEST_FOLDER=""
move /Y "%~dp0test-%TIMESTAMP%.zip" %DEST_FOLDER%
::--------------------------------------"
