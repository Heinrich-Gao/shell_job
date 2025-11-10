进阶系统健康监控脚本

📘 Overview | 概述

This Bash script is an upgraded version of the basic system monitor.
It not only checks CPU and Memory usage, but also tracks directory growth trends — helping you detect abnormal increases in disk usage or log accumulation.

该 Bash 脚本是基础版的进阶升级版。
它除了监控 CPU 与内存使用率，还可检测 目录增长趋势，帮助你发现异常的数据积累或日志暴涨问题。

⚙️ Features | 功能特点

✅ Monitor CPU utilization and detect overloads

✅ Track Memory usage in real time

✅ Detect directory size growth (e.g. log accumulation)

✅ Auto-generate logs with timestamps

✅ Lightweight & easy to configure

功能说明：

✅ 监控 CPU 使用率 并提示超限

✅ 实时检测 内存使用情况

✅ 检测 目录增长（如日志过多、磁盘膨胀）

✅ 自动生成带时间戳的日志

✅ 无需外部依赖，轻量易用

📂 File Structure | 文件结构
├── system_monitor_standard.sh     # 主脚本
└── system_monitor_standard.log    # 运行日志（自动生成）

⚙️ Configuration | 配置参数

You can modify thresholds or target directories by editing the variables below:

DIR="$HOME/aws_practice"           # 要监控的目录
LOG="$HOME/system_monitor_standard.log"  # 日志文件路径
CPU_THRESHOLD=80                   # CPU阈值（%）
MEM_THRESHOLD=85                   # 内存阈值（%）
DIR_DIFF_THRESHOLD=100             # 目录增长阈值（MB）


Example / 示例：

# 如果你想监控更严格
CPU_THRESHOLD=70
MEM_THRESHOLD=80
DIR_DIFF_THRESHOLD=50

🚀 How to Use | 使用方法
1️⃣ Make script executable
chmod +x system_monitor_standard.sh

2️⃣ Run manually
./system_monitor_standard.sh

3️⃣ (Optional) Run automatically with cron
*/15 * * * * /path/to/system_monitor_standard.sh


This will run every 15 minutes.
示例：每 15 分钟执行一次脚本。

🧾 Log Example | 日志示例

正常情况：

[2025-11-10_12:45:33] ===== Standard System Monitoring Started =====
[2025-11-10_12:45:33] CPU usage normal: 18.4%
[2025-11-10_12:45:33] Memory usage normal: 63%
[2025-11-10_12:45:33] Directory growth within limits (12.5MB)
[2025-11-10_12:45:33] ===== Standard System Monitoring Finished =====


出现异常时：

[2025-11-10_13:02:15] CPU usage 92% exceeds threshold 80%
[2025-11-10_13:02:15] Directory /home/user/logs grew by 128MB (Threshold 100MB)

🧠 Recommended Use Cases | 适用场景

🖥️ Personal servers or VPS resource monitoring

☁️ AWS / cloud sandbox monitoring

🧩 Detecting abnormal directory growth (e.g. logs, cache)

👨‍💻 DevOps & system automation practice

适用范围：

个人服务器 / VPS 性能监控

云实验环境 / AWS 测试实例监控

检测日志或缓存文件的异常增长

DevOps 初学者练习自动化监控脚本

🔼 Upgrade Option | 可选升级

For users who need:

📧 Email alert notifications

☁️ Automatic upload to AWS S3

🧹 Old log cleanup

👉 Try the Advanced System Monitor v3 (高级版本) — a full DevOps automation script with AWS integration.

👨‍💻 Author Info

Author: [Your Fiverr or GitHub Username]
Category: Bash / DevOps / Linux Automation
License: Free to use and modify for learning purposes
