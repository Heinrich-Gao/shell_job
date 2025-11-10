系统健康监控脚本 v2
📘 Overview | 概述

This Bash script continuously monitors CPU usage, memory utilization, and directory growth, generating detailed logs and sending alert emails when thresholds are exceeded.
本脚本用于实时监控 CPU 使用率、内存使用率 和 指定目录增长情况，当指标超过阈值时会自动记录日志并发送报警邮件。

It is lightweight, easily customizable, and ideal for DevOps system checks, automated maintenance, and server health monitoring.
脚本轻量、易于自定义，适用于 DevOps 系统巡检、自动化运维维护 与 服务器健康状态监控。

⚙️ Features | 功能特性

✅ CPU Usage Monitoring — Detects high CPU load and sends alerts.
CPU使用率监控：检测CPU过载并发送报警。

✅ Memory Usage Monitoring — Triggers alerts when memory exceeds the set threshold.
内存使用率监控：当内存超过设定阈值时触发警报。

✅ Directory Growth Tracking — Monitors directory size changes (e.g., log folders).
目录增长监控：追踪目录容量变化（如日志目录）。

✅ Email Notification (optional) — Sends alerts via email when configured.
可选邮件通知：配置邮箱后可发送警报邮件。

✅ Detailed Logging — All alerts are written to a log file.
日志记录：所有报警信息将记录到日志文件中。

🧩 Script Information | 脚本信息
项目 (Item)	描述 (Description)
File Name / 文件名	system_monitor_v2.sh
Language / 语言	Bash
Version / 版本	v2
Compatible OS / 兼容系统	Linux / macOS
Log File Path / 日志路径	~/aws_practice/system_monitor.log (可修改)
🔧 Configuration | 参数配置

You can adjust thresholds and paths inside the configuration section:
你可以在配置部分自定义以下参数：

DIR="${1:-$HOME/aws_practice}"    # Directory to monitor (default: ~/aws_practice)
CPU_THRESHOLD=80                  # CPU usage threshold (%)
MEM_THRESHOLD=85                  # Memory usage threshold (%)
DIR_DIFF_THRESHOLD=100            # Directory growth threshold (MB)
EMAIL_ALERT="yourmail@***.com"    # Alarm email address (optional)
LOG="$HOME/aws_practice/system_monitor.log"  # Log file path

📜 Usage | 使用方法
1️⃣ Make the script executable

授予执行权限：

chmod +x system_monitor_v2.sh

2️⃣ Run the script manually

手动执行脚本：

./system_monitor_v2.sh


Or specify a custom directory to monitor:
或自定义监控目录：

./system_monitor_v2.sh /var/log

3️⃣ (Optional) Set up cron job for periodic checks

可选：通过 cron 定时执行：

*/10 * * * * /path/to/system_monitor_v2.sh >> /dev/null 2>&1


(Example: Run every 10 minutes)

📊 Output Example | 输出示例

Example log content (system_monitor.log):
日志输出示例：

[2025-11-10_10:00:01] ==== System Monitoring Started ====
[2025-11-10_10:00:02] CPU usage 92.5 % exceeds threshold 80 %
[2025-11-10_10:00:02] Memory usage 87% exceeds threshold 85%
[2025-11-10_10:00:03] Directory /home/user/aws_practice increased by 120.50 MB (Threshold 100 MB).
[2025-11-10_10:00:03] ==== System Monitoring Finished ====

🧠 How It Works | 工作原理

CPU & Memory:

Uses top and free commands to retrieve system stats.

When usage exceeds thresholds, logs and alerts are triggered.

利用 top 与 free 获取系统状态；当使用率超标时触发日志记录与邮件报警。

Directory Monitoring:

Compares current directory size (du -s) with the last recorded size.

If growth (in MB) exceeds threshold, alerts are sent.

使用 du -s 对比上次与当前目录容量变化，若增长超出阈值则报警。

Logging & Alerts:

Logs are appended to $LOG.

Email alerting uses system mail command (if available).

所有日志写入指定文件；若系统支持 mail 命令则发送邮件通知。

🧰 Dependencies | 依赖项

Ensure the following commands are available in your environment:
确保系统已安装以下命令：

bash

awk

bc

top

du

mail (optional, for email alerts)

⚠️ Notes | 注意事项

Email alerting requires a properly configured mail service (sendmail / postfix).
邮件告警依赖于系统已正确配置的邮件发送服务。

Recommended to run this script with root or sufficient privileges to access system metrics.
建议以 root 或具有足够权限的用户运行脚本以获取完整系统信息。

Adjust thresholds based on your system workload and environment.
请根据系统负载实际情况适当调整阈值。

🧩 Example Scenario | 应用场景示例

🖥️ Server Health Monitoring（服务器健康监控）

🧾 Log Directory Growth Detection（日志目录膨胀监控）

🧰 DevOps Maintenance Automation（自动化运维巡检）

📈 Resource Usage Analysis（资源使用分析）
