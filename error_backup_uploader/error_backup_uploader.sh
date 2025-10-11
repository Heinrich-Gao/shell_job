#!/bin/bash
#=============================================
# Script Name : error_backup_uploader.sh
# Author      : Heinrich-Gao
# Description :
#   English: 
#     1. Count "ERROR" occurrences in all files of a given directory.
#     2. Create a backup tar.gz of another directory.
#     3. Upload the backup to an AWS S3 bucket.
#
#   中文：
#     1. 统计指定目录中所有文件的 "ERROR" 出现次数；
#     2. 备份另一个指定目录并打包为 tar.gz 文件；
#     3. 将该备份上传至指定的 AWS S3 存储桶。
#=============================================

#========= Configuration / 配置部分 =========#
SRC_DIR=${1:-"study-2"}                       # Directory to scan for ERRORs / 需要扫描ERROR的目录
BACKUP_DIR=${2:-"study-1"}                    # Directory to back up / 需要备份的目录
BUCKET_NAME=${3:-"heinrich-study-bucket"}     # Target S3 bucket name / 目标S3存储桶名称
BACKUP_FILE="${BACKUP_DIR}_backup_$(date '+%Y%m%d').tar.gz"  # Backup filename / 备份文件名
LOGFILE="$HOME/aws_practice/error_backup.log" # Log file path / 日志文件路径
TOTAL=0

#========= Utility Functions / 工具函数 =========#

# Log message with timestamp / 输出带时间戳的日志
log() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S')  $message" | tee -a "$LOGFILE"
}

# Exit script with error message / 输出错误并退出脚本
error_exit() {
    log "❌ ERROR: $1"
    exit 1
}

#========= Step 1: Count Errors / 统计错误 =========#
log "🔍 Scanning directory '$SRC_DIR' for 'ERROR' keywords..."
for f in "$SRC_DIR"/*; do
    if [[ -f "$f" ]]; then
        count=$(grep -ci "ERROR" "$f" || true)
        printf "%-30s : %d\n" "$(basename "$f")" "$count"
        TOTAL=$((TOTAL + count))
    fi
done
log "✅ Total ERROR lines found: $TOTAL"

#========= Step 2: Backup Directory / 备份目录 =========#
log "📦 Creating backup for directory '$BACKUP_DIR'..."
tar -czf "$BACKUP_FILE" "$BACKUP_DIR" 2>>"$LOGFILE" || error_exit "Failed to create backup / 创建备份失败。"
log "✅ Backup created successfully: $BACKUP_FILE"

#========= Step 3: Upload to S3 / 上传到S3 =========#
log "☁️  Uploading '$BACKUP_FILE' to S3 bucket: $BUCKET_NAME ..."
aws s3 cp "$BACKUP_FILE" "s3://$BUCKET_NAME/" >>"$LOGFILE" 2>&1 \
    && log "✅ Upload successful: $BACKUP_FILE uploaded to s3://$BUCKET_NAME/" \
    || error_exit "Upload failed. Check AWS CLI configuration or network / 上传失败，请检查AWS CLI配置或网络。"

log "🎉 Script completed successfully / 脚本执行完毕。"
