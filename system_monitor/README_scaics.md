基础系统健康监控脚本

📘 Overview | 概述

This Bash script provides a lightweight and efficient way to monitor system CPU and memory usage on Linux systems. It automatically logs the usage data, checks against defined thresholds, and records warnings when resource usage exceeds limits.

该 Bash 脚本是一款轻量级、高效的 Linux 系统资源监控工具，可定期监控 CPU 与内存使用率，并自动记录日志，当资源使用超过设定阈值时输出警告。

⚙️ Features | 功能特点

✅ Monitor CPU usage in real time

✅ Monitor Memory usage dynamically

✅ Log results to a timestamped log file

✅ Simple, lightweight, no extra dependencies

功能说明：

✅ 实时监控 CPU 使用率

✅ 动态检测内存占用率

✅ 自动记录日志并带有时间戳

✅ 轻量化设计，无需额外依赖

🧩 Script Structure | 脚本结构
├── system_monitor_basic.sh       # Main monitoring script
└── system_monitor_basic.log      # Log output file (auto-generated)

⚙️ Configuration | 配置说明

You can adjust thresholds or paths by editing these variables at the top of the script:

LOG="$HOME/system_monitor_basic.log"  # 日志文件路径
CPU_THRESHOLD=80                      # CPU使用率阈值
MEM_THRESHOLD=85                      # 内存使用率阈值


Example:
If you want to make it more strict, set:

CPU_THRESHOLD=70
MEM_THRESHOLD=80

🚀 Usage | 使用方法
1️⃣ Make the script executable
chmod +x system_monitor_basic.sh

2️⃣ Run manually
./system_monitor_basic.sh

3️⃣ (Optional) Schedule automatic runs with cron

Add this line to your crontab:

*/10 * * * * /path/to/system_monitor_basic.sh


This example runs the script every 10 minutes.
示例：每 10 分钟执行一次脚本。

📂 Log Example | 日志示例
[2025-11-10_14:21:33] ===== Basic System Monitoring Started =====
[2025-11-10_14:21:33] CPU usage normal: 12.5%
[2025-11-10_14:21:33] Memory usage normal: 58%
[2025-11-10_14:21:33] ===== Basic System Monitoring Finished =====


If thresholds are exceeded:

[2025-11-10_14:25:33] CPU usage 91% exceeds threshold 80%

🧠 Recommended Use Cases | 适用场景

Local Linux servers / 本地Linux服务器监控

Lightweight VPS / 轻量VPS性能检测

Cloud lab environments / 云端实验环境

DevOps beginners practicing automation / DevOps初学者练习自动化脚本

💡 Upgrade Recommendation | 升级建议

If you need email alerts, directory growth detection, or AWS integration,
check out my Advanced System Health Monitor v2 version.

⚙️ It includes directory growth tracking, email notifications, and log cleanup automation.

👨‍💻 Author

Created by: [Your Fiverr/GitHub Username]
Category: DevOps / Bash Scripting / Linux Automation
License: Free to use and modify for learning purposes
