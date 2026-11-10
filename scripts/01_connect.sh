#!/usr/bin/env bash
set -euo pipefail

FIRETV_IP="${1:-192.168.10.25}"
PORT="${2:-5555}"

echo "==> Ensuring ADB server is alive..."
adb start-server

echo "==> Connecting to Fire TV at ${FIRETV_IP}:${PORT}..."
adb connect "${FIRETV_IP}:${PORT}"

echo "==> Checking device state..."
adb devices -l
