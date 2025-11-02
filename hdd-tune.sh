#!/bin/bash
for disk in /dev/sda /dev/sdb /dev/sdc; do
    if [ -b "$disk" ]; then
        # Disable APM and spindown
        echo "Configuring $disk..."
        hdparm -B 255 -S 0 "$disk"

        # Set I/O scheduler
        echo mq-deadline | tee "/sys/block/$(basename $disk)/queue/scheduler"

        # Set read-ahead
        blockdev --setra 1024 "$disk"
    else
        echo "Warning: $disk does not exist."
    fi
done