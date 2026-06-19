#!/bin/bash
# 每 48 小时发送北京时间通知（最接近 51 小时的标准间隔）

NOTIFICATION_FILE="/tmp/beijing-time-last-notification"
INTERVAL_SECONDS=$((48 * 60 * 60))  # 48 小时

while true; do
  current_time=$(date +%s)

  # 检查上次通知的时间
  if [ ! -f "$NOTIFICATION_FILE" ]; then
    last_notification=0
  else
    last_notification=$(cat "$NOTIFICATION_FILE")
  fi

  # 如果距离上次通知已超过 48 小时，发送新通知
  time_since_last=$((current_time - last_notification))
  if [ $time_since_last -ge $INTERVAL_SECONDS ]; then
    beijing_time=$(TZ=Asia/Shanghai date +%H:%M)
    echo "你好，现在是北京时间 $beijing_time"
    echo "$current_time" > "$NOTIFICATION_FILE"
  fi

  # 每 60 秒检查一次是否应该发送通知
  sleep 60
done
