# Automated-backup
基于Windows Server及Windows环境下的自动化备份脚本，用于备份你的游戏存档

Automated backup scripts based on Windows Server and Windows environment to back up your game saves

## zh-CN 更新日志：

### 2025.03.10

I.创建项目

1.使用 `for /f "tokens=1-n+1 delims=/"` 做 `do` 循环，获取当前时间戳 `in(%time%)` `in(%date%)`，将时间信息存储至 `%%a` `%%...`

2.使用系统自带的`tar`进行压缩操作

### 2025.03.20

1.更新了页面代码，使批处理脚本保持在 _UTF-8_ 格式下运行

2.更新了获取时间戳的逻辑，新增了秒数

3.由于系统自带的 `tar` 指令可能存在问题，导致压缩文件无法正常打开，甚至乱码，因此调用了第三方软件 ***Bandizip*** 中的 ***bz.exe*** 进行压缩

4.新增了文件移动的操作，可将生成的压缩文件移动至用户指定的文件夹中，可在 `DEST_FOLDER` 中修改参数实现
