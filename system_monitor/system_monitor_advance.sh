#!/bin/bash
#====================================================================
# Standard System Health Monitor v2
# 进阶系统健康监控脚本
# Description: Monitor CPU, Memory, and directory growth.
# 描述：监控CPU、内存与指定目录大小变化
#====================================================================

#=== Configuration / 配置部分 ===
DIR="${1:-$HOME/aws_practice}"           # Directory to be monitored（Customizable）
LOG="$HOME/system_monitor_standard.log"  # Log file path
CPU_THRESHOLD=80                         # CPU untilization threshold
MEM_THRESHOLD=85                         # Memory usage threshold
DIR_DIFF_THRESHOLD=100                   # Directory growth threshold (MB)
LAST_STATE="/tmp/last_dir_size.txt"
NOW_STATE="/tmp/now_dir_size.txt"

#=== Utility Function / 工具函数 ===
write_log(){
    local TIME="$(date '+%Y-%m-%d_%H:%M:%S')"
    echo "[$TIME] $1" | tee -a "$LOG"
}

#=== CPU Monitor / CPU监控 ===
check_cpu(){
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    local cpu_int=${cpu_usage%.*}
    if (( cpu_int > CPU_THRESHOLD )); then
        write_log "CPU usage ${cpu_usage}% exceeds threshold ${CPU_THRESHOLD}%"
    else
        write_log "CPU usage normal: ${cpu_usage}%"
    fi
}

#=== Memory Monitor / 内存监控 ===
check_mem(){
    local mem_usage=$(free | awk '/Mem/{printf("%.0f", $3/$2 * 100)}')
    if (( mem_usage > MEM_THRESHOLD )); then
        write_log "Memory usage ${mem_usage}% exceeds threshold ${MEM_THRESHOLD}%"
    else
        write_log "Memory usage normal: ${mem_usage}%"
    fi
}

#=== Directory Size Monitor / 目录增长监控 ===
check_dir(){
    if [ ! -d "$DIR" ]; then
        write_log "Directory $DIR not found. Skip."
        return
    fi

    local size_now=$(du -s "$DIR" 2>/dev/null | awk '{print $1}')
    [ ! -f "$LAST_STATE" ] && echo "$size_now" > "$LAST_STATE"
    echo "$size_now" > "$NOW_STATE"

    local size_last=$(cat "$LAST_STATE")
    local diff_kb=$(( size_now - size_last ))
    local diff_mb=$(echo "scale=2; $diff_kb / 1024" | bc)
    local diff_int=${diff_mb%.*}

    if (( diff_int > DIR_DIFF_THRESHOLD )); then
        write_log "Directory $DIR grew by ${diff_mb}MB (Threshold ${DIR_DIFF_THRESHOLD}MB)"
    else
        write_log "Directory growth within limits (${diff_mb}MB)"
    fi

    cp "$NOW_STATE" "$LAST_STATE"
}

#=== Main Function / 主函数 ===
main(){
    write_log "===== Standard System Monitoring Started ====="
    check_cpu
    check_mem
    check_dir
    write_log "===== Standard System Monitoring Finished ====="
}

main
