基础套餐 README.md

文件名：README_basic_log_backup.md

# 🧩 Basic Log Backup Script / 基础日志备份脚本

### 📘 Description / 脚本说明
This Bash script automatically finds log files older than **7 days** in a specified directory and compresses them into a `.tar.gz` archive for backup.  
本脚本自动查找指定目录中**超过7天**的日志文件，并将其压缩成 `.tar.gz` 文件以便备份。

---

### ⚙️ Features / 功能特点
- 🔍 Automatically detects `.log` files older than 7 days  
- 📦 Compresses logs into a single archive  
- 🧾 Records all actions to a log file  
- 💡 Simple and lightweight — perfect for beginners  

---

### 🧰 Configuration / 配置
You can customize these variables at the top of the script:
```bash
DIR="${1:-$HOME/aws_practice/study-1}"           # Target directory / 目标目录
BACKUP_DIR="${2:-$HOME/aws_practice/backup_dir}" # Backup directory / 备份目录


Default path: ~/aws_practice/study-1

🚀 Usage / 使用方法

Make the script executable

chmod +x basic_log_backup.sh


Run the script

./basic_log_backup.sh


(Optional) Specify custom directories

./basic_log_backup.sh /path/to/logs /path/to/backups

🧾 Example Output / 输出示例
[2025-11-10_13:30:25] ==== Starting Basic Log Backup ====
[2025-11-10_13:30:25] Logs archived: /home/user/aws_practice/backup_dir/log_2025-11-10_13:30:25.tar.gz
[2025-11-10_13:30:25] ==== Basic Log Backup Finished ====

🧠 Requirements / 环境要求

OS: Linux / macOS / WSL

Tools: bash, tar, find

📁 Log File Location / 日志文件位置
~/aws_practice/archive_log_basic.log

🪄 Author Note / 作者说明

This is the Basic Package version — focused on simplicity and automation foundation.
适合想要快速实现日志自动归档的初学者或轻量化项目用户。


---

## 🟦 **进阶套餐 README.md**  
> 文件名：`README_intermediate_log_backup.md`

```markdown
# ⚙️ Intermediate Log Backup Script / 进阶日志备份脚本

### 📘 Description / 脚本说明
This Bash script automatically finds log files older than **7 days**, compresses them into an archive, and **deletes old logs** after successful backup.  
本脚本自动查找超过7天的日志文件，进行压缩归档，并在成功备份后**自动删除旧日志**。

---

### 💡 Key Improvements Over Basic Version / 相比基础版的改进
| Feature | Basic | Intermediate |
|----------|--------|---------------|
| Auto compress old logs | ✅ | ✅ |
| Delete old logs | ❌ | ✅ |
| Detailed execution log | ✅ | ✅ |
| Multi-directory support | ✅ | ✅ |

---

### ⚙️ Configuration / 配置
You can customize these variables at the top of the script:
```bash
DIR="${1:-$HOME/aws_practice/study-1}"           # Target directory / 目标目录
BACKUP_DIR="${2:-$HOME/aws_practice/backup_dir}" # Backup directory / 备份目录


Default path: ~/aws_practice/study-1

🚀 Usage / 使用方法

Make the script executable

chmod +x intermediate_log_backup.sh


Run the script

./intermediate_log_backup.sh


(Optional) Use custom paths

./intermediate_log_backup.sh /path/to/logs /path/to/backups

🧾 Example Output / 输出示例
[2025-11-10_13:30:25] ==== Starting Intermediate Log Backup ====
[2025-11-10_13:30:25] Logs archived: /home/user/aws_practice/backup_dir/log_2025-11-10_13:30:25.tar.gz
[2025-11-10_13:30:25] Old log files deleted.
[2025-11-10_13:30:25] ==== Intermediate Log Backup Finished ====

🧠 Requirements / 环境要求

OS: Linux / macOS / WSL

Tools: bash, tar, find

📁 Log File Location / 日志文件位置
~/aws_practice/archive_log_intermediate.log
