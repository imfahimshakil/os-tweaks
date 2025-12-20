#!/bin/bash

# Get the username from the systemd instance name passed as the first argument
USER_NAME="$1"

# --- Define the possible paths ---
GLOBAL_PATH="/usr/local/bin/qbittorrent-nox"
USER_PATH="/home/${USER_NAME}/bin/qbittorrent-nox"

# --- Check which path exists and is executable ---
if [ -x "${GLOBAL_PATH}" ]; then
    EXEC_PATH="${GLOBAL_PATH}"
elif [ -x "${USER_PATH}" ]; then
    EXEC_PATH="${USER_PATH}"
else
    echo "ERROR: qbittorrent-nox not found or not executable in either ${GLOBAL_PATH} or ${USER_PATH}" >&2
    exit 1
fi

# --- Execute the discovered binary in the foreground ---
# The 'exec' command replaces the shell script process with the qBittorrent-nox process.
exec "${EXEC_PATH}"
