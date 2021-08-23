#!/bin/bash

# TO run the script
# nohup sh ps-1s.sh &
#

while true
do
  date >> /tmp/ps1.out
  uptime >> /tmp/ps1.out
  ps H -eo user,pid,ppid,tid,times,%cpu,%mem,wchan,cmd --sort=%cpu >> /tmp/ps1.out
  sleep 1
done
