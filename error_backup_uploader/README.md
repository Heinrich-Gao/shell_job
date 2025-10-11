# 🧰 AWS Error Counter & Backup Uploader (Shell Script)
# AWS错误统计与自动备份上传脚本

## 📖 Overview / 概述

**English:**
This Bash script automates a common cloud maintenance workflow:
- Scans a directory for `"ERROR"` occurrences in log files.
- Creates a compressed backup of another directory.
- Uploads the backup to an AWS S3 bucket.
- Records each step in a local log file.

**中文：**
该Bash脚本用于模拟常见的云运维场景：
- 扫描指定目录中的日志文件，统计包含 `"ERROR"` 的行数；
- 对另一个指定目录进行压缩备份；
- 将备份文件自动上传至 AWS S3 存储桶；
- 全程输出并记录操作日志。

---

## ⚙️ Usage / 使用方法

### **English:**
```bash
bash error_backup_uploader.sh [SOURCE_DIR] [BACKUP_DIR] [S3_BUCKET]
Prerequisites / 前置条件

English:

AWS CLI installed and configured with valid credentials.

Bash environment (Linux/macOS).

User has permission to upload objects to the target S3 bucket.

中文：

已安装并配置 AWS CLI（包含有效凭证）。

Linux 或 macOS 环境（支持 Bash）。

用户具有上传文件至指定 S3 桶的权限。
