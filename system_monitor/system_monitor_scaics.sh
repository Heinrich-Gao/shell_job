#!/bin/bash
#===============================================================
# Basic System Health Monitor v1
# 基础系统健康监控脚本
# Description: Monitor CPU and Memory usage and log results.
# 描述：监控CPU与内存使用率并记录日志
#===============================================================

#=== Configuration / 配置部分 ===
LOG="$HOME/system_monitor_basic.log"     #Log file path
CPU_THRESHOLD=80                         # CPU threshold (%)
MEM_THRESHOLD=85                         # Memory threshold (%)

#=== Utility Function / 工具函数 ===
write_log(){
    local TIME="$(date '+%Y-%m-%d_%H:%M:%S')"
    echo "[$TIME] $1" | tee -a "$LOG"
}

#=== Check CPU Usage / 检查CPU使用率 ===
check_cpu(){
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    local cpu_int=${cpu_usage%.*}
    if (( cpu_int > CPU_THRESHOLD )); then
        write_log "CPU usage ${cpu_usage}% exceeds threshold ${CPU_THRESHOLD}%"
    else
        write_log "CPU usage normal: ${cpu_usage}%"
    fi
}

#=== Check Memory Usage / 检查内存使用率 ===
check_mem(){
    local mem_usage=$(free | awk '/Mem/{printf("%.0f", $3/$2 * 100)}')
    if (( mem_usage > MEM_THRESHOLD )); then
        write_log "Memory usage ${mem_usage}% exceeds threshold ${MEM_THRESHOLD}%"
    else
        write_log " Memory usage normal: ${mem_usage}%"
    fi
}

#=== Main Function / 主函数 ===
main(){
    write_log "===== Basic System Monitoring Started ====="
    check_cpu
    check_mem
    write_log "===== Basic System Monitoring Finished ====="
}

main
