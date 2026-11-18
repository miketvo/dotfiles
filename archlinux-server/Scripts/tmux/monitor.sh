#!/bin/bash
#
# Start a tmux monitoring session. This includes SSH port and user watch,
# process monitoring (top), and an interactive shell.

SESSION_NAME="monitor"

tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s "$SESSION_NAME" -n "SSHPortWatch" \
        'watch -n 2 "ss -o state established '\''( dport = :22 or sport = :22 )'\''"'
    tmux split-window -t "$SESSION_NAME:SSHPortWatch" -v \
        'watch -n 2 "who -u"'
    tmux new-window -t "$SESSION_NAME" -n "SystemMonitor" \
        'btop --tty'
    tmux new-window -t "$SESSION_NAME" -n "Shell"
fi

tmux attach-session -t "$SESSION_NAME"
