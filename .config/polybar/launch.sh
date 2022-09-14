#!/usr/bin/env bash

# Terminate existing bar instances
killall -q polybar
# If all your pars have ipc enabled, you can also use
# polybar-msg cmd quit

# wait for all polybars to be killed
while($(pgrep polybar)); do
  sleep 1;
done;

# Launch top bar
echo "---" | tee -a /tmp/polybar_top.log
polybar top 2>&1 | tee /tmp/polybar_top.log &

echo "Bars launched..."
