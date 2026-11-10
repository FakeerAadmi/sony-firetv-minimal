# Sony Bravia KDL-42W700B + Fire TV Minimalist Setup

A complete setup toolkit and documentation to debloat, remove ads, block forced updates, and replace the stock Amazon Fire TV interface with a clean, minimal, Apple TV-style UI (**Projectivy Launcher**).

---

## Target Hardware Specs
* **Television:** Sony Bravia KDL-42W700B (1080p Full HD, HDMI-CEC Bravia Sync)
* **Streaming Stick:** Amazon Fire TV Stick Lite / 3rd Gen (`AFTSS`, codename: `sheldon`)
* **Firmware:** Fire OS 7.7.1.7 (`PS7717.5746N`)
* **IP Address:** `192.168.10.25:5555`

---

## Directory Structure
```
.
├── README.md
├── .gitignore
├── docs/
│   ├── hardware_specs.md          # Complete diagnostic dump of TV and stick
│   └── architecture_and_plan.md   # System interception architecture & safety model
├── data/
│   ├── device_info.json           # JSON device properties & diagnostics
│   ├── disabled_packages.txt      # Current packages disabled by cleanmytv
│   └── user_packages.txt          # User-installed applications
└── scripts/
    ├── 01_connect.sh              # Establishes ADB connection
    ├── 02_install_projectivy_and_interceptor.sh  # Sideloads launcher + sets up interceptor
    ├── 03_block_ota_and_telemetry.sh             # Freezes OTA updates & background ad engines
    └── 04_restore_stock.sh        # Complete 1-click rollback to stock defaults
```

---

## Quick Start / Next Steps

### 1. Connect via ADB
```bash
./scripts/01_connect.sh
```

### 2. Deploy Projectivy Launcher & Home on Fire
```bash
./scripts/02_install_projectivy_and_interceptor.sh
```

### 3. Freeze OTA Updates & Telemetry
```bash
./scripts/03_block_ota_and_telemetry.sh
```

### 4. Rollback to Stock (If ever needed)
```bash
./scripts/04_restore_stock.sh
```
