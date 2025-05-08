::Version:beta-2.3.25.04.22
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
echo/
powershell -Command Write-Host "当前时间戳：%TIMESTAMP%" -ForegroundColor Green
::-------------------------------------------


::---------------配置变量---------------
set SOURCE_FOLDER=""
set DEST_FOLDER=""
set SOURCE_FILE_NAME=""
set SERVER_NAME=""
::----------------常量-----------------
set FILE_NAME="%SOURCE_FILE_NAME%-%TIMESTAMP%.zip"
::-------------------------------------


:: ----- 检查服务端是否正在运行 -----
echo/
powershell -Command Write-Host "正在检查服务端是否正在运行..." -ForegroundColor Cyan
tasklist /FI "IMAGENAME eq bedrock_server.exe" | findstr /i "bedrock_server.exe" >nul
if %errorlevel% neq 0 (
    echo/
    powershell -Command Write-Host "信息：服务端未运行，跳过此步骤" -ForegroundColor Blue
    timeout /t 5 >nul
    goto :COMPRESS
)
::---------------------------------


::----------通过窗口发送停止命令----------
:STOP_SERVER
powershell -Command Write-Host "正在向服务端发送停止命令..." -ForegroundColor Cyan
powershell -Command "$wshell = New-Object -ComObject wscript.shell; $wshell.AppActivate('bedrock_server.exe'); Start-Sleep -Milliseconds 500; $wshell.SendKeys('stop{ENTER}');Start-Sleep -Milliseconds 500; $wshell.SendKeys('{ENTER}');
::--------------------------------------


::----------等待服务端停止----------
echo/
set count=5

:loop
powershell -Command Write-Host "正在等待服务端停止，延时: %count% 秒" -ForegroundColor Green -NoNewLine
timeout /t 1 /nobreak >nul
set /a count-=1

if %count% gtr 0 (
  powershell -Command Write-Host "`r" -NoNewLine
  goto loop
)

tasklist /FI "IMAGENAME eq bedrock_server.exe" | findstr /i "bedrock_server.exe" >nul
if %errorlevel% equ 0 (
    echo/
    echo/
    powershell -Command Write-Host "信息：服务端仍在运行，重新执行停止命令并继续等待..." -ForegroundColor Yellow
    goto :STOP_SERVER
)
echo/
echo/
powershell -Command Write-Host "信息：服务端已停止" -ForegroundColor Green
:: --------------------------------


::-----------------压缩文件-----------------
:COMPRESS
echo/
set count=5

:loop1
powershell -Command Write-Host "即将开始进行压缩操作... 延时：%count% 秒" -ForegroundColor Cyan -NoNewLine
timeout /t 1 /nobreak >nul
set /a count-=1

if %count% gtr 0 (
  powershell -Command Write-Host "`r" -NoNewLine
  goto loop1
)

echo/
echo/
powershell -Command Write-Host "正在压缩文件..." -ForegroundColor Cyan
echo/
echo/
bz.exe a -r "%SOURCE_FILE_NAME%-%TIMESTAMP%.zip"  %SOURCE_FOLDER%
if errorlevel 1 (
    echo/
    powershell -Command Write-Host "警告：压缩失败，请检查源目录是否正确！" -ForegroundColor Red
    pause
    exit /b 1
)
echo/
powershell -Command Write-Host "信息：压缩完成！" -ForegroundColor Green
::-----------------------------------------


::-----------------移动压缩文件-----------------
echo/
powershell -Command Write-Host "将压缩文件移动到预设的文件路径：%DEST_FOLDER%" -ForegroundColor Cyan
timeout /t 3 >nul
move /Y "%SOURCE_FILE_NAME%-%TIMESTAMP%.zip" %DEST_FOLDER%
::---------------------------------------------


::-----------------重新启动服务端-----------------
echo/
powershell -Command Write-Host "正在重新启动服务端..." -ForegroundColor Cyan
timeout /t 3 >nul
start %SERVER_NAME%
::-----------------------------------------------


::-----------------自定义服务器参数-----------------
echo/
powershell -Command Write-Host "向服务端发送预设的参数..." -ForegroundColor Cyan
timeout /t 5 >nul
powershell -Command "$wshell = New-Object -ComObject wscript.shell; $wshell.AppActivate('bedrock_server.exe'); Start-Sleep -Milliseconds 10000; $wshell.SendKeys('gamerule keepinventory true{ENTER}');
::-------------------------------------------------