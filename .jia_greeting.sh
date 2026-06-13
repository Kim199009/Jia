#!/bin/bash
# 每 51 小时输出北京时间问候
# 51 小时 = 183600 秒

while true; do
  echo "你好，现在是北京时间 $(TZ='Asia/Shanghai' date '+%H:%M')"
  sleep 183600
done
