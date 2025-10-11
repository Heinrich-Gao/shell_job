#!/bin/bash
#=========================================================
# Script Name : error_focus_finder.sh
# Author      : Heinrich-Gao
# Description :
#   English:
#     Scan all .txt files in a given directory, count the number of
#     "ERROR" lines (case-insensitive), identify the file with the
#     highest number of errors, and log the result.
#
#   中文：
#     扫描指定目录中的所有 .txt 文件，统计其中 "ERROR"（不区分大小写）
#     的出现次数，找出错误行数最多的文件，并记录结果到日志中。
#=========================================================

#================== Configuration / 配置部分 ==================#
SCAN_DIR=${1:-"$HOME/aws_practice/study-1"}     # Directory to scan / 要扫描的目录
LOGFILE="$HOME/aws_practice/error_focus.log"    # Log file / 日志文件路径
DATE=$(date '+%Y-%m-%d %H:%M:%S')

#================== Utility Functions / 工具函数 ==================#

# 输出带时间戳的日志 / Log with timestamp
log() {
    local msg="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $msg" | tee -a "$LOGFILE"
}

# count_error 函数：统计文件中包含 "ERROR" 的行数（不区分大小写）
# count_error function: count "ERROR" lines (case-insensitive)
count_error() {
    local file="$1"
    grep -ci "ERROR" "$file" 2>/dev/null || echo 0
}

#================== Main Script Logic / 主逻辑 ==================#
log "🔍 Starting error scan in directory: $SCAN_DIR"

# 判断目录是否存在 / Check if directory exists
if [ ! -d "$SCAN_DIR" ]; then
    log "❌ ERROR: Directory not found - $SCAN_DIR"
    exit 1
fi

max_count=0        # 当前最大错误数 / Current max error count
max_file=""        # 错误最多的文件名 / File with most errors
total_files=0      # 文件计数 / Count of scanned files

# 遍历指定目录下的所有 .txt 文件
for f in "$SCAN_DIR"/*.txt; do
    if [[ -f "$f" ]]; then
        ((total_files++))
        num=$(count_error "$f")
        echo "📄 File: $(basename "$f") | ERROR lines: $num"
        log "File: $(basename "$f") | ERROR lines: $num"

        # 若发现更高错误数则更新记录 / Update if higher error count found
        if [ "$num" -gt "$max_count" ]; then
            max_count=$num
            max_file=$(basename "$f")
        fi
    fi
done

#================== Results / 结果输出 ==================#
if [ "$total_files" -eq 0 ]; then
    log "⚠️ No .txt files found in directory."
    echo "目录中未发现 .txt 文件。"
    exit 0
fi

if [ "$max_count" -gt 0 ]; then
    log "🚨 Focus File: $max_file | ERROR Count: $max_count"
    echo "需要重点关注的文件：$max_file，错误行数：$max_count"
else
    log "✅ No ERROR lines found in any file."
    echo "所有文件无 ERROR 行，系统状态正常。"
fi

log "🎉 Scan completed at $DATE"
