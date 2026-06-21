#!/bin/bash
echo "你好，现在是北京时间 $(TZ='Asia/Shanghai' date '+%H:%M')"
