::Version: beta 1.6.25.04.12
::by MAXOUYT

@echo off
::--------设置代码页编码--------
chcp 65001
::-----------------------------

@echo off

::---------------获取当前时间戳---------------
for /f "tokens=1-3 delims=/" %%a in ('echo %date%') do (
    set YEAR=%%a
    set MONTH=%%b
    set DAY=%%c
)

for /f "tokens=1-2 delims=:." %%a in ("%time%") do (
    set HOUR=%%a
    set MINUTE=%%b
)

set TIMESTAMP=%YEAR%.%MONTH%.%DAY% %HOUR%%MINUTE%
::-------------------------------------------


::---------------配置变量---------------
set SOURCE_FOLDER=""
set FILE_NAME="filename-%TIMESTAMP%.zip"
set DEST_FOLDER=""
::-------------------------------------


:: ----- 检查服务端是否正在运行 -----
echo 正在检查服务端是否正在运行...
tasklist /FI "IMAGENAME eq bedrock_server.exe" | findstr /i "bedrock_server.exe" >nul
if %errorlevel% neq 0 (
    echo 警告：服务端未运行，跳过停止步骤！
    goto :COMPRESS
)
::---------------------------------


::----------通过窗口发送停止命令----------
:STOP_SERVER
echo 正在向服务端发送停止命令...
powershell -Command "$wshell = New-Object -ComObject wscript.shell; $wshell.AppActivate('bedrock_server.exe'); Start-Sleep -Milliseconds 500; $wshell.SendKeys('stop{ENTER}');Start-Sleep -Milliseconds 500; $wshell.SendKeys('{ENTER}');
::--------------------------------------


::----------等待服务端停止----------
timeout /t 5 >nul
tasklist /FI "IMAGENAME eq bedrock_server.exe" | findstr /i "bedrock_server.exe" >nul
if %errorlevel% equ 0 (
    echo 服务端仍在运行，重新执行停止命令并继续等待......
    goto :STOP_SERVER
)
echo 服务端已成功停止
:: --------------------------------


::-----------------压缩文件-----------------
:COMPRESS
echo 正在压缩指定文件夹...
bz.exe a -r "filename-%TIMESTAMP%.zip"  %SOURCE_FOLDER%
if errorlevel 1 (
    echo 压缩失败，请检查源目录是否正确
    pause
    exit /b 1
)
echo 压缩完成！
::-----------------------------------------


::-----------------移动压缩文件-----------------
move /Y "filename-%TIMESTAMP%.zip" %DEST_FOLDER%
::---------------------------------------------


::-----------------重新启动服务端-----------------
start 
::-----------------------------------------------


::-----------------自定义服务器参数-----------------
powershell -Command "$wshell = New-Object -ComObject wscript.shell; $wshell.AppActivate('bedrock_server.exe'); Start-Sleep -Milliseconds 10000; $wshell.SendKeys('gamerule keepinventory true{ENTER}');
::-------------------------------------------------