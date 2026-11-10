#!/usr/bin/env bash
set -euo pipefail

FIRETV_DEVICE="${1:-192.168.10.25:5555}"

echo "==> Connecting to ${FIRETV_DEVICE}..."
adb connect "$FIRETV_DEVICE"

echo "==> 1. Enabling Combined Accessibility Services (Home on Fire + Projectivy)..."
HOMEONFIRE_SVC="io.github.toolicious.homeonfire/io.github.toolicious.homeonfire.HomeInterceptorService"
PROJECTIVY_SVC="com.spocky.projengmenu/com.spocky.projengmenu.services.ProjectivyAccessibilityService"
COMBINED_SVCS="${HOMEONFIRE_SVC}:${PROJECTIVY_SVC}"

adb -s "$FIRETV_DEVICE" shell settings put secure enabled_accessibility_services "$COMBINED_SVCS"
adb -s "$FIRETV_DEVICE" shell settings put secure accessibility_enabled 1

echo "==> 2. Disabling Forced Background OTA Updates..."
adb -s "$FIRETV_DEVICE" shell pm disable-user --user 0 com.amazon.tv.forcedotaupdater.v2 || true

echo "==> Accessibility services and OTA protection successfully applied."
