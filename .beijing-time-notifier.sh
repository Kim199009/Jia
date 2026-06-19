#!/bin/bash
# 每 48 小时发送北京时间通知（最接近 51 小时的标准间隔）

while true; do
  # 获取北京时间
  beijing_time=$(TZ=Asia/Shanghai date +%H:%M)

  # 输出通知内容（会被后续脚本捕获）
  echo "你好，现在是北京时间 $beijing_time"

  # 等待 48 小时 (172800 秒)
  sleep 172800
done
