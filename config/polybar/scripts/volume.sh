#!/bin/bash
# Volume — event-driven via pw-mon, refresh on Node/Device/Metadata changes

emit() {
    output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    if echo "$output" | grep -q '\[MUTED\]'; then
        current="󰕾 Mute"
    else
        volume=$(echo "$output" | awk '{printf "%d", $2 * 100}')
        current="󰕾 ${volume}%"
    fi
    if [ "$current" != "$LAST" ]; then
        echo "$current"
        LAST="$current"
    fi
}

cleanup() {
    trap - EXIT TERM INT
    pkill -P $$ 2>/dev/null
    exit 0
}
trap cleanup EXIT TERM INT

LAST=""
emit
while true; do
    stdbuf -oL pw-mon 2>/dev/null | awk '
        /^(added|changed):/ { pending = 1; next }
        pending && /type:/ {
            if ($0 ~ /PipeWire:Interface:(Node|Device|Metadata)/) { print "event"; fflush() }
            pending = 0
        }
    ' | while read -r _; do
        emit
    done &
    monitor=$!
    wait "$monitor"
    sleep 1
done
