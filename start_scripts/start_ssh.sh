#!/usr/bin/bash

IPS=(192.168.1.1 192.168.1.2 192.168.1.3)

SESSIONNAME=SSH

tmux new-session -d -s ${SESSIONNAME} -n "ALL" "watch -n 1 ls -lh; exec /bin/bash"
tmux split-window -h "watch -n 1 df -h; exec /bin/bash"
tmux split-window -v "watch -n 1 du -hc; exec /bin/bash"

N=0
for IP in ${IPS[*]}; do
    N=$((N+1))
    # tmux new-window -t ${SESSIONNAME}:${N} -n "${IP}" "ssh pi@${IP}; exec /bin/bash"
    tmux new-window -t ${SESSIONNAME}:${N} -n "${IP}" "exec /bin/bash"
    tmux send-keys -t ${SESSIONNAME}:${N} "ssh pi@${IP}" C-m
done

tmux select-window -t 0
tmux attach-session -t ${SESSIONNAME}

