# 🧠 Intermediate Log Backup Script | 进阶日志备份脚本

### 🔧 Overview | 概述
This **Intermediate Log Backup Script** automatically finds and compresses log files older than 7 days, archives them, and then deletes the old logs to free up storage space.  
该 **进阶日志备份脚本** 会自动查找并压缩超过 7 天的日志文件，将它们归档保存，并清理旧日志以释放存储空间。

---

### 🚀 Features | 功能特性
- 🕒 **Automatic File Detection 自动检测**：自动查找指定目录下超过 7 天的 `.log` 文件。  
- 📦 **Compression 压缩归档**：将符合条件的日志文件打包为 `.tar.gz` 格式的压缩包。  
- 🧹 **Cleanup 自动清理**：在归档完成后自动删除旧日志文件。  
- 📝 **Operation Log 操作日志**：每次执行都会记录运行结果与错误信息。  
- ⚙️ **Customizable Path 自定义路径**：支持通过命令行参数自定义日志目录和备份目录。

---

### 📂 Directory Structure | 目录结构
aws_practice/
├── study-1/ # 日志文件所在目录（示例）
├── backup_dir/ # 压缩包存放目录
├── archive_log_intermediate.log # 脚本运行日志
└── intermediate_log_backup.sh # 主脚本

yaml
复制代码

---

### ⚙️ Usage | 使用方法

#### 1️⃣ 基本运行
```bash
bash intermediate_log_backup.sh
默认：

查找路径：$HOME/aws_practice/study-1

备份目录：$HOME/aws_practice/backup_dir

2️⃣ 自定义路径运行
bash
复制代码
bash intermediate_log_backup.sh /path/to/logs /path/to/backup
示例：

bash
复制代码
bash intermediate_log_backup.sh /var/log /mnt/backup
📋 Example Output | 示例输出
yaml
复制代码
[2025-11-10_13:45:23] ==== Starting Intermediate Log Backup ====
[2025-11-10_13:45:23] Logs archived: /home/user/aws_practice/backup_dir/log_2025-11-10_13:45:23.tar.gz
[2025-11-10_13:45:23] Old log files deleted.
[2025-11-10_13:45:23] ==== Intermediate Log Backup Finished ====
🧩 Parameters | 参数说明
参数	说明	默认值
$1	日志文件所在目录	$HOME/aws_practice/study-1
$2	压缩包存放目录	$HOME/aws_practice/backup_dir

🛠️ Log Files | 日志说明
脚本会在 $HOME/aws_practice/archive_log_intermediate.log 中记录：

归档成功与否

错误信息

删除状态
这些记录便于后期运维人员审查执行记录。

🔐 Safety | 安全性
删除操作仅针对 .log 文件，避免误删其他数据。

所有操作均会写入日志，确保可追溯性。

💡 Tips | 使用建议
可设置 cron 定时任务 实现自动执行：

bash
复制代码
0 2 * * * /bin/bash /path/to/intermediate_log_backup.sh >> /dev/null 2>&1
👉 每天凌晨 2 点自动执行。

建议在正式部署前先执行一次测试，确认路径与权限无误。

📜 License | 许可协议
This project is released under the MIT License.
本项目基于 MIT 协议发布，可自由修改与使用。

