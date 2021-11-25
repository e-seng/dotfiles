#!/usr/bin/env bash

# Terminate existing bar instances
killall -q polybar
# If all your pars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch top bar
echo "---" | tee -a /tmp/polybar_top.log
polybar top 2>&1 | tee -a /tmp/polybar_top.log & disown

echo "Bars launched..."
