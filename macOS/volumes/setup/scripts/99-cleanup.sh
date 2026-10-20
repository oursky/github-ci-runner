#!/bin/bash

sudo rm -rf /tmp/*

# https://github.com/actions/runner-images/blob/82d1b86ad393865982dd29535cb8d3adbc68e41e/images/macos/scripts/build/configure-system.sh#L72-L110
# Erase all indexes and wait until the rebuilding process ends,
# for now there is no clear way to get status of indexing process on macOS, it takes around 3-6 minutes to accomplish
echo "Erase all MDS indexes and wait until the rebuilding process ends"
sudo mdutil -E / > /dev/null

echo "Wait for 6 minutes or until the indexing process end signal is found in logs"
for _ in {1..12}; do
    sleep 30
    result=$(sudo log show --last 1m | grep -E 'mds.*Released.*BackgroundTask' || true)
    if [[ -n "$result" ]]; then
        echo "Sign of indexing completion found:"
        echo "$result"
        break
    fi
done

echo "Check if the indexing process or other CPU intensive process (5% and more) is still running"

cool=0
while true; do
  usage=$(top -l 2 | grep "CPU usage" | awk '{print int($3)}' | tr -d '%' | tail -n 1)
  echo "Current CPU usage: ${usage}%"
  if [ $usage -lt 5 ]; then
    cool=$((cool + 1))
  else
    ps -arcwwwxo ppid,pid,%cpu,%mem,time,command | head -n 2 || true
    cool=0
  fi
 
  echo "Feeling cool for $cool intervals"

  if [ $cool -gt 5 ]; then
    echo "Cooled down, exiting..."
    break
  fi

  sleep 1
done
