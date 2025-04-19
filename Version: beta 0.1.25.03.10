::Version: beta 0.1.25.03.10
::by MAXOUYT
@echo off
color a
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
set TIMESTAMP=%YEAR%-%MONTH%-%DAY%_%HOUR% %MINUTE% %SECOND%

echo 正在压缩指定文件夹......

::---------------配置变量---------------
tar -cvf "%~dp0backup_%TIMESTAMP%.zip" ./1
::----------------------------------------
::tar可更改变量：①backup_  ②.zip   ③1
::注：更改tar变量可以更改压缩文件名、压缩文件后缀、压缩文件内容
::注意：./后是源文件夹名称，请务必将批处理文件放在要压缩的文件夹目录下
::配置完成后将文件后缀改成.bat即可
