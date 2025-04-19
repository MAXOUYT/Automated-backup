# Automated-backup
基于Windows Server及Windows环境下的自动化备份脚本，用于备份你的游戏存档

Automated backup scripts based on Windows Server and Windows environment to back up your game saves

## Language
  - [zh-CH](#zh-cn-更新日志)
  - [en-US](#en-us--release-notes)

## zh-CN 更新日志：

### 2025.03.10
- [Version: beta 0.1.25.03.10](https://github.com/MAXOUYT/Automated-backup/blob/main/beta%200.1.25.03.10.bat)


I.创建项目

1.使用 `for /f "tokens=1-n+1 delims=/"` 做 `do` 循环，获取当前时间戳 `in(%time%)` `in(%date%)`，将时间信息存储至 `%%a` `%%b`等

2.使用系统自带的`tar`进行压缩操作

### 2025.03.20
- [Version: beta 0.5.25.03.20](https://github.com/MAXOUYT/Automated-backup/blob/main/beta%200.5.25.03.20.bat)

#### 1.更新了页面代码，使批处理脚本保持在 _UTF-8_ 格式下运行

#### 2.更新了获取时间戳的逻辑，新增了秒数

#### 3.由于系统自带的 `tar` 指令可能存在问题，导致压缩文件无法正常打开，甚至乱码，因此调用了第三方软件 [***Bandizip***](https://www.bandisoft.com/bandizip/ "") 中的 ***bz.exe*** 进行压缩


#### 4.新增了文件移动的操作，可将生成的压缩文件移动至用户指定的文件夹中，可在 `DEST_FOLDER` 中修改参数实现

------------------------------------------------------------------------------------------


## en-US  Release Notes:

### 2025.03.10
- [Version: beta 0.1.25.03.10](https://github.com/MAXOUYT/Automated-backup/blob/main/beta%200.1.25.03.10.bat)

Project Initialization

Implemented a `for /f "tokens=1-n+1 delims=/"` loop to retrieve the current timestamp by parsing `%time%` and `%date%`, storing the results in variables `%%a`, `%%b`, etc.

Utilized the system-built `tar` utility for archive compression.

### 2025.03.20
- [Version: beta 0.5.25.03.20](https://github.com/MAXOUYT/Automated-backup/blob/main/beta%200.5.25.03.20.bat)

#### 1.Codebase Update

Modified page encoding logic to ensure batch script execution compatibility with _UTF-8_ encoding.

#### 2.Timestamp Logic Enhancement

Refactored timestamp extraction logic to include seconds precision.

#### 3.Compression Reliability Improvement

Replaced the native `tar` command with ***bz.exe*** (from the third-party tool [***Bandizip***](https://www.bandisoft.com/bandizip/ "") ) due to potential issues with system-built tar, such as corrupted archives or encoding errors.

#### 4.File Relocation Feature

Added functionality to automatically move generated archives to a user-specified directory. Target path can be configured via the `DEST_FOLDER` parameter.
