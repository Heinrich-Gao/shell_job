#!/bin/bash
#System Health Monitoring Script v2
#系统健康监控脚本v2
#Description:Monitor CPU, Memory, and directory growth.
#描述：监控CPU、内存和指定目录增长情况

#========Configuration Section / 配置部分 ========
DIR="${1:-$HOME/aws_practice}"    #Monitoring Directory(Default:~/aws_practice, Customizable parameters)
CPU_THRESHOLD=80    #CPU utilization threshold
MEM_THRESHOLD=85    #Memory usage threshold
DIR_DIFF_THRESHOLD=100    #Directory growth threshold (MB)
EMAIL_ALERT="yourmail@***.com"    #Alarm email address;If not configured,only logs willbe recorded.(Please fill in the email address yourself)
LAST_STATE="/tmp/last_dir_size.txt"
NOW_STATE="/tmp/now_dir_size.txt"
LOG="$HOME/aws_practice/system_monitor.log"    #Log file storage path (Please modify the path according to your actual path)

if [ ! -d "$DIR" ]; then
echo "目录不存在，脚本退出"
exit 1
fi

#=== Utility Functions / 工具函数 ===
write_log(){
    local TIME="$(date '+%Y-%m-%d_%H:%M:%S')"
    local msg="$1"
    echo "[$TIME] $msg" | tee -a "$LOG"
}

send_mail(){
    local subject="$1"
    local body="$2"
    if command -v mail >/dev/null 2>&1; then
        echo "$body" | mail -s "$subject" "$EMAIL_ALERT"
    else
        write_log "Email failed to send.(Log only)"
    fi
}

#==== System Check Functions / 系统检测函数 ====
check_cpu(){
local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
local cpu_int=${cpu_usage%.*}
    if (( $cpu_int > $CPU_THRESHOLD )); then
    local msg="CPU usage ${cpu_usage} % exceeds threshold ${CPU_THRESHOLD} % "
        write_log "$msg"
        send_mail "CPU Alert" "$msg"
fi
}

check_mem(){
    local mem_usage=$(free | awk '/Mem/{printf("%.0f", $3/$2 * 100)}')
    if (( mem_usage > MEM_THRESHOLD )); then
        local msg="Memory usage ${mem_usage}% exceeds threshold ${MEM_THRESHOLD}%"
        write_log "$msg"
        send_mail "Memory Alert" "$msg"
    fi
}

check_dir(){
local size_now=$(du -s "$DIR" 2>/dev/null | awk '{print $1}')
    if [ -z "$size_now" ]; then
        write_log "Directory $DIR not found."
           return
fi
    [ ! -f "$LAST_STATE" ] && echo "$size_now" > "$LAST_STATE"
        echo "$size_now" > "$NOW_STATE"
    local size_last=$(cat "$LAST_STATE")
    local diff_kb=$(( size_now - size_last ))
    local diff_mb=$(echo "scale=2;$diff_kb / 1024" | bc)
    local diff_int=${diff_mb%.*}
    if (( $(echo "$diff_int > $DIR_DIFF_THRESHOLD" | bc -l) )); then
        local msg="Directory $DIR increased by ${diff_mb} MB (Threshold ${DIR_DIFF_THRESHOLD} MB)."
        write_log "$msg"
        send_mail "Directory Alert" "$msg"
    fi
    cp "$NOW_STATE" "$LAST_STATE"
}

#==== Main Function / 主函数 ====
main(){
write_log "==== System Monitoring Started ===="
check_cpu
check_mem
check_dir
write_log "==== System Monitoring Finished===="
}

main
