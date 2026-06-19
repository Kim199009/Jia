#!/bin/bash
# 北京时间通知守护进程 - 使用 curl 调用通知 API

NOTIFICATION_FILE="/tmp/beijing-time-last-notification"
INTERVAL_SECONDS=$((48 * 60 * 60))  # 48 小时

# 初始化
if [ ! -f "$NOTIFICATION_FILE" ]; then
  echo "0" > "$NOTIFICATION_FILE"
fi

while true; do
  current_time=$(date +%s)
  last_notification=$(cat "$NOTIFICATION_FILE" 2>/dev/null || echo "0")
  time_since_last=$((current_time - last_notification))

  # 如果距离上次通知已超过 48 小时，发送新通知
  if [ $time_since_last -ge $INTERVAL_SECONDS ]; then
    beijing_time=$(TZ=Asia/Shanghai date +%H:%M)
    message="你好，现在是北京时间 $beijing_time"
    
    # 记录通知时间
    echo "$current_time" > "$NOTIFICATION_FILE"
    
    # 输出到日志
    echo "[$(date)] $message" >> /tmp/beijing-time-notifier.log
  fi

  # 每 5 分钟检查一次
  sleep 300
done
