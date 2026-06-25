#!/bin/bash
log_file="/home/user/Jia/.beijing-time-log"
state_file="/home/user/Jia/.beijing-time-state"

# Get current time
current_time=$(TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S')
beijing_time=$(TZ='Asia/Shanghai' date '+%H:%M')

# Output the greeting
message="你好，现在是北京时间 $beijing_time"
echo "$message"

# Log the execution
echo "[$current_time] $message" >> "$log_file"

# Update state file with last execution timestamp
echo "$(date +%s)" > "$state_file"
