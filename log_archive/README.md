日志自动打包上传脚本
📘 Overview | 概述

This Bash script automatically finds and compresses log files older than 7 days, uploads them to an AWS S3 bucket, and removes the local copies afterward.
本脚本会自动查找并压缩 7 天前的日志文件，上传至 AWS S3 存储桶，并在上传后清理本地旧日志。

It is designed for DevOps automation, server maintenance, and log lifecycle management.
本脚本适用于 DevOps 自动化、服务器维护 及 日志生命周期管理 场景。

⚙️ Features | 功能特性

✅ Automatic detection of logs older than 7 days
自动检测 7 天前的日志文件

✅ Compression and archiving into .tar.gz
压缩归档 为 .tar.gz 文件

✅ Upload to AWS S3 using AWS CLI
使用 AWS CLI 上传至 S3

✅ Local cleanup after successful backup
上传成功后 自动删除本地旧日志

✅ Detailed logging for all operations
详细日志记录 每个操作步骤

🧩 Script Information | 脚本信息
项目 (Item)	描述 (Description)
File Name / 文件名	log_backup_upload.sh
Language / 语言	Bash
Version / 版本	v1.0
Compatible OS / 兼容系统	Linux / macOS
Required Tools / 依赖工具	bash, aws cli, tar, find
Default Log File / 日志文件	~/aws_practice/archive_log.log
🔧 Configuration | 参数配置

You can customize parameters in the configuration section:
你可以在配置部分修改以下参数：

DIR="${1:-$HOME/aws_practice/study-1}"           # Target directory / 目标目录
BACKUP_DIR="${2:-$HOME/aws_practice/buckup_dir}" # Backup storage directory / 备份存储路径
S3_BUCKET="s3://my-bucket"                       # S3 bucket name / S3 桶名
LOG="$HOME/aws_practice/archive_log.log"         # Log file path / 日志文件路径

📜 Usage | 使用方法
1️⃣ Make the script executable

授予执行权限：

chmod +x log_backup_upload.sh

2️⃣ Run the script manually

手动执行脚本：

./log_backup_upload.sh


You can also specify custom directories:
也可以自定义日志目录与备份路径：

./log_backup_upload.sh /var/log /opt/backup

3️⃣ (Optional) Automate with cron

可选：通过定时任务自动执行：

0 2 * * * /path/to/log_backup_upload.sh >> /dev/null 2>&1


(Example: Run daily at 2:00 AM / 每天凌晨 2 点执行)

📊 Example Log Output | 日志输出示例
[2025-11-10_11:20:01] ==== Starting Log Backup & Upload ====
[2025-11-10_11:20:02] Logs archived: /home/user/aws_practice/buckup_dir/log_2025-11-10_11:20:02.tar.gz
[2025-11-10_11:20:03] Upload to S3 successful
[2025-11-10_11:20:04] Old log files deleted
[2025-11-10_11:20:04] ==== Log Backup & Upload Finished ====

🧠 How It Works | 工作原理

File Discovery — Uses find to locate .log files older than 7 days.
使用 find 命令查找 7 天前的 .log 文件。

Compression — Compresses matching files into a .tar.gz archive.
将匹配文件打包为 .tar.gz 压缩包。

S3 Upload — Uploads archive to your specified S3 bucket via aws s3 cp.
使用 aws s3 cp 上传至 S3。

Cleanup — Deletes old local logs after successful upload.
上传成功后删除旧日志。

Logging — Every step is recorded in the local log file.
所有操作过程均写入日志文件中。

🧰 Dependencies | 依赖项

Make sure the following tools are installed and configured:
确保系统已安装并正确配置以下工具：

工具 (Tool)	用途 (Purpose)
bash	运行脚本
find	查找过期日志文件
tar	打包压缩日志
aws cli	上传文件至 S3（需事先配置凭证）
⚠️ Notes | 注意事项

Ensure AWS CLI is properly configured with valid credentials (aws configure).
请确保 AWS CLI 已配置好凭证（使用 aws configure）。

Make sure the target S3 bucket exists and the user has write permission.
请确认目标 S3 桶已存在且拥有写入权限。

Modify paths based on your environment before deploying.
在部署前请根据环境修改路径配置。

Log files are stored persistently at $HOME/aws_practice/archive_log.log.
日志默认保存在 $HOME/aws_practice/archive_log.log。

🧩 Example Scenario | 应用场景示例

🧾 Periodic log cleanup and upload（周期性日志清理与上传）

☁️ S3-based log backup（基于 S3 的日志归档备份）

🧰 Server maintenance automation（服务器自动化维护）

🔄 DevOps data retention policy implementation（日志保留策略实现）
