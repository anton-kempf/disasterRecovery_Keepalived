#!/bin/bash


log_file="/var/log/calc_priority.log"


load=$(awk '{print $1}' /proc/loadavg)


cores=$(nproc)


max_load=$(echo "$cores * 1.0" | bc)


raw_priority=$(echo "$load / $max_load * 300" | bc -l)
priority=$(echo "255 - $raw_priority" | bc -l)


priority=$(printf "%.0f" "$priority")

if [ "$priority" -lt 30 ]; then
    priority=30
fi
echo "$priority" > /etc/keepalived/track_priority

echo "$(date): load=$load, cores=$cores, max_load=$max_load, priority=$priority" >> "$log_file"
