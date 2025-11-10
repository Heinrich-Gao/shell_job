#!/bin/bash
#Log Backup & Uploaad Script
#日志自动打包上传脚本
#Description：Find logs older than 7 days,compress them, and upload to S3

#==== Configuration / 配置 ====
DIR="${1:-$HOME/aws_practice/study-1}"           #Target directory / 目标目录
BACKUP_DIR="${2:-$HOME/aws_practice/buckup_dir}" #Backup storage / 备份存储目录
TIME=$(date '+%Y-%m-%d_%H:%M:%S')
ARCHIVE_NAME="log_$TIME.tar.gz"                  #Archive name / 压缩文件名
S3_BUCKET="s3://my-bucket"                       #Target S3 bucket（Make changes based on your actual S3 bucket name.) / S3桶名
LOG="$HOME/aws_practice/archive_log.log"         #Log file path / 日志文件路径

if [ ! -d "$BACKUP_DIR" ]; then
mkdir -p "$BACKUP_DIR"
fi

#==== Utility Functions / 工具函数 ====
write_log(){
    local times=$(date '+%Y-%m-%d_%H:%M:%S')
    local msg=$1
    echo "[$times] $msg" | tee -a "$LOG"
}

#==== Backup & Upload Function / 备份上传函数 ====
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
        write_log "Logs archived: $BACKUP_DIR/$ARCHIVE_NAME "
        if command -v aws >/dev/null 2>&1; then
        aws s3 cp "$BACKUP_DIR/$ARCHIVE_NAME" "$S3_BUCKET/"
                if [ $? -eq 0 ]; then
                    write_log "Upload to S3 successful"
                else
                    write_log "Upload to S3 failed"
                    return 1
                fi
        else
         write_log "AWS CLI not found, skipping upload."
        fi
    find "$DIR" -type f -name "*.log" -mtime +7 -delete
    write_log "Old log files deleted"
}

#==== Main Function ====
main(){
write_log "==== Starting Log Backup & Upload ===="
backup_log
write_log "==== Log Backup & Upload Finished ===="
}

main
