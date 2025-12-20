#!/bin/bash
for sysdisk in /sys/block/sd*; do
    # Skip removable devices
    if [ -f "$sysdisk/removable" ] && grep -q 1 "$sysdisk/removable"; then
        continue
    fi
    
    disk="/dev/$(basename "$sysdisk")"
    
    # Disable APM and spindown
    hdparm -B 255 -S 0 "$disk" >/dev/null 2>&1
        
    queue="$sysdisk/queue/scheduler"
    if [ -f "$queue" ]; then
        if grep -qw "mq-deadline" "$queue"; then
            # Set I/O scheduler
            echo mq-deadline | tee "$queue" >/dev/null
        fi
    fi
    
     # Set read-ahead
    blockdev --setra 1024 "$disk" >/dev/null 2>&1
done
