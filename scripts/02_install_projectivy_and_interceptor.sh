#!/usr/bin/env bash
set -euo pipefail

FIRETV_DEVICE="${1:-192.168.10.25:5555}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
CACHE_DIR="${ROOT_DIR}/cache"

mkdir -p "$CACHE_DIR"

echo "==> Verifying ADB connection to ${FIRETV_DEVICE}..."
adb connect "$FIRETV_DEVICE"

echo "==> 1. Fetching latest Home on Fire APK..."
HOME_ON_FIRE_URL=$(curl -s https://api.github.com/repos/toolicious/home-on-fire/releases/latest | grep "browser_download_url.*apk" | head -n 1 | cut -d '"' -f 4)
if [[ -z "$HOME_ON_FIRE_URL" ]]; then
    HOME_ON_FIRE_URL="https://github.com/toolicious/home-on-fire/releases/download/v1.5.2/home-on-fire.apk"
fi
curl -L -o "${CACHE_DIR}/home-on-fire.apk" "$HOME_ON_FIRE_URL"

echo "==> 2. Fetching Projectivy Launcher APK..."
PROJECTIVY_URL="https://github.com/spocky/miproja1/releases/download/4.73/ProjectivyLauncher-4.73-c98-xda-release.apk"
curl -L -o "${CACHE_DIR}/ProjectivyLauncher.apk" "$PROJECTIVY_URL"

echo "==> 3. Sideloading APKs..."
adb -s "$FIRETV_DEVICE" install -r "${CACHE_DIR}/home-on-fire.apk"
adb -s "$FIRETV_DEVICE" install -r "${CACHE_DIR}/ProjectivyLauncher.apk"

echo "==> 4. Granting secure settings permissions to Home on Fire..."
adb -s "$FIRETV_DEVICE" shell pm grant io.github.toolicious.homeonfire android.permission.WRITE_SECURE_SETTINGS

echo "==> 5. Enabling Home on Fire Accessibility Service..."
CURRENT_SERVICES=$(adb -s "$FIRETV_DEVICE" shell settings get secure enabled_accessibility_services | tr -d '\r')
TARGET_SERVICE="io.github.toolicious.homeonfire/io.github.toolicious.homeonfire.HomeInterceptorService"

if [[ "$CURRENT_SERVICES" == "null" || -z "$CURRENT_SERVICES" ]]; then
    adb -s "$FIRETV_DEVICE" shell settings put secure enabled_accessibility_services "$TARGET_SERVICE"
elif [[ "$CURRENT_SERVICES" != *"$TARGET_SERVICE"* ]]; then
    adb -s "$FIRETV_DEVICE" shell settings put secure enabled_accessibility_services "${CURRENT_SERVICES}:${TARGET_SERVICE}"
fi
adb -s "$FIRETV_DEVICE" shell settings put secure accessibility_enabled 1

echo "==> Done! Packages installed and accessibility service configured."
