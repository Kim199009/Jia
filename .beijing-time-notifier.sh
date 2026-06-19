#!/bin/bash
# 每 48 小时发送北京时间通知（最接近 51 小时的标准间隔）

NOTIFICATION_FILE="/tmp/beijing-time-last-notification"
INTERVAL_SECONDS=$((48 * 60 * 60))  # 48 小时
CHECK_INTERVAL=300  # 每 5 分钟检查一次

# 初始化
if [ ! -f "$NOTIFICATION_FILE" ]; then
  echo "0" > "$NOTIFICATION_FILE"
fi

iteration=0
while true; do
  current_time=$(date +%s)
  last_notification=$(cat "$NOTIFICATION_FILE" 2>/dev/null || echo "0")

  # 计算距离上次通知的时间
  time_since_last=$((current_time - last_notification))

  # 如果距离上次通知已超过 48 小时，发送新通知
  if [ $time_since_last -ge $INTERVAL_SECONDS ]; then
    beijing_time=$(TZ=Asia/Shanghai date +%H:%M)
    echo "你好，现在是北京时间 $beijing_time"
    echo "$current_time" > "$NOTIFICATION_FILE"
  else
    # 定期输出状态，防止 Monitor 超时（每小时输出一次）
    iteration=$((iteration + 1))
    if [ $((iteration % 12)) -eq 0 ]; then
      hours_remaining=$((($INTERVAL_SECONDS - $time_since_last) / 3600))
      echo "[监控中] 距离下次通知还有约 $hours_remaining 小时"
    fi
  fi

  # 每 5 分钟检查一次
  sleep $CHECK_INTERVAL
done
