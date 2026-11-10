#!/usr/bin/env bash
set -euo pipefail

FIRETV_DEVICE="${1:-192.168.10.25:5555}"

echo "==> Connecting to ${FIRETV_DEVICE}..."
adb connect "$FIRETV_DEVICE"

echo "==> 1. Disabling Over-The-Air (OTA) Updates..."
adb -s "$FIRETV_DEVICE" shell pm hide com.amazon.device.software.ota || true
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.device.software.ota || true
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.tv.forcedotaupdater.v2 || true
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.device.software.ota.override || true

echo "==> 2. Disabling Heavy Amazon Ad Engines & Unused Telemetry..."
# Heavy video ad renderers and telemetry
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.kato || true
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.shpm || true
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.device.sale.service || true

echo "==> OTA updates and heavy ad engines successfully frozen."
