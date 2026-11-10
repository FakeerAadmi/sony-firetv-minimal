# Architecture & Plan: Minimal Ad-Free Fire TV on Sony Bravia

## Problem Overview
Amazon Fire OS 7 strictly binds the remote `Home` key to Amazon's stock launcher (`com.amazon.tv.launcher`).
Tools like `cleanmytv` and `cleanyourtv` disable telemetry packages, but cannot replace the Home screen interface because Amazon patched standard Android home activity remapping (`cmd package set-home-activity`).

## Architecture
```
[ Fire TV Remote (Home Button) ]
              │
              ▼
[ Fire OS Window Manager ] ─── attempts to launch ───► [ com.amazon.tv.launcher ] (Stock)
              │
              ▼ (intercepted in < 50ms)
[ Home on Fire Accessibility Service ]
              │
              ▼
[ Projectivy Launcher (com.spocky.projengmenu) ]
              │
              ├── Clean Apple-TV-style Rows (SmartTube, Stremio, Netflix, Spotify)
              └── Aerial Views Screensaver Integration
```

## Safety & Rollback Guarantee
1. **Zero System Partition Modifications:** No rooting, unlocking, or hardware modification required.
2. **Reversible ADB Toggles:** Disabling `com.amazon.device.software.ota` and telemetry packages can be fully reverted anytime using `scripts/04_restore_stock.sh`.
3. **Fail-safe:** If the custom launcher is ever uninstalled, Fire OS immediately falls back to the stock launcher.
