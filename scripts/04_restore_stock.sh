#!/usr/bin/env bash
set -euo pipefail

FIRETV_DEVICE="${1:-192.168.10.25:5555}"

echo "==> Connecting to ${FIRETV_DEVICE}..."
adb connect "$FIRETV_DEVICE"

echo "==> Restoring OTA Update Services..."
adb -s "$FIRETV_DEVICE" shell pm unhide com.amazon.device.software.ota || true
adb -s "$FIRETV_DEVICE" shell pm default-state --user 0 com.amazon.device.software.ota || true
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.device.software.ota || true
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.tv.forcedotaupdater.v2 || true
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.device.software.ota.override || true

echo "==> Disabling Home on Fire Interceptor..."
adb -s "$FIRETV_DEVICE" shell settings put secure enabled_accessibility_services null || true

echo "==> Restoring default packages..."
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.kato || true
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.shpm || true
adb -s "$FIRETV_DEVICE" shell pm enable com.amazon.device.sale.service || true

echo "==> All stock defaults restored successfully."
