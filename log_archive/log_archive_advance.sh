#!/bin/bash
#Intermediate Log Backup Script
#进阶日志备份脚本
#Description: Find logs older than 7 days, compress them, and delete old logs.

#==== Configuration ====
DIR="${1:-$HOME/aws_practice/study-1}"
BACKUP_DIR="${2:-$HOME/aws_practice/backup_dir}"
TIME=$(date '+%Y-%m-%d_%H:%M:%S')
ARCHIVE_NAME="log_$TIME.tar.gz"
LOG="$HOME/aws_practice/archive_log_intermediate.log"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

#==== Utility Function ====
write_log(){
    local times=$(date '+%Y-%m-%d_%H:%M:%S')
    local msg="$1"
    echo "[$times] $msg" | tee -a "$LOG"
}

#==== Backup Function ====
backup_log(){
    local files=$(find "$DIR" -type f -name "*.log" -mtime +7)
    if [ -z "$files" ]; then
        write_log "No log files older than 7 days found."
        return 0
    fi
    tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" $files
    if [ $? -ne 0 ]; then
        write_log "Error: Failed to create archive."
        return 1
    fi
    write_log "Logs archived: $BACKUP_DIR/$ARCHIVE_NAME"

    # 删除旧日志
    find "$DIR" -type f -name "*.log" -mtime +7 -delete
    write_log "Old log files deleted."
}

#==== Main ====
main(){
    write_log "==== Starting Intermediate Log Backup ===="
    backup_log
    write_log "==== Intermediate Log Backup Finished ===="
}

main
