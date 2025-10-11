# 🧰 Error Focus Finder (Shell Script)
# 错误重点文件分析脚本

## 📖 Overview / 概述

**English:**
This Bash script scans a target directory for `.txt` files, counts the number of `"ERROR"` occurrences in each file (case-insensitive), and identifies which file has the most errors.  
The result is both printed to the terminal and logged for record keeping.

**中文：**
该 Bash 脚本用于扫描指定目录下的 `.txt` 文件，统计每个文件中 `"ERROR"`（不区分大小写）的行数，并找出错误最多的文件。  
结果会在终端显示，并同时写入日志文件以便追踪。

---

## ⚙️ Usage / 使用方法

### **English:**
```bash
bash error_focus_finder.sh [SCAN_DIRECTORY]
