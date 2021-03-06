#!/bin/bash

# Memory Threshold (% of Memory). Allows to tweak the threshold above which chrome tabs will be killed
MT=2

# Echo process IDs above Memory Threshold
echo "Process IDs of process above Memory Threshold: $MT%"
ps -awxm -o %mem,cpu,pid,rss,vsz,comm | sort -nr | grep 'Google Chrome Helper' | awk -v mt=$MT '{if ($1 > mt ) print $3}'


#Method 1: To test on run time, works without checks
echo "Killing these PIDs (error means none)"
kill -9 $(ps -awxm -o %mem,cpu,pid,rss,vsz,comm | sort -nr | grep 'Google Chrome Helper' | awk -v mt=$MT '{if ($1 > mt ) print $3}')
echo "Killed"

#Method 2: Works only when not on AC power
: '
echo "Killing these PIDs (error means none)"
if ! pmset -g batt | grep "AC Power"
then
kill -9 $(ps -awxm -o %mem,cpu,pid,rss,vsz,comm | sort -nr | grep "Google Chrome Helper" | awk -v mt=$MT "{if ($1 > mt ) print $3}")
fi
echo "Killed"
'
