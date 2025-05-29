# 🖥️ AIO PC Setup Assistant

A fully automated PowerShell-based setup assistant for fresh Windows installs. This tool helps you:

- ✅ Install essential and developer software
- 🧹 Remove bloatware and unwanted apps
- 🛠 Apply system tweaks (like moving Downloads, enabling Hibernate, etc.)

---

## 🚀 One-Line Setup

To run everything in one go, open PowerShell **as Administrator** and paste:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/motsmanish/aio-pc-setup-assistant/main/setup.ps1")))
```

> 🟡 This will:
> 1. Download the `setup.ps1` from GitHub
> 2. Dynamically fetch and run additional modules (`tweaks`, `install-software`, `remove-bloatware`)
> 3. Guide you through an interactive PC setup process

---

## 📦 Modules

### 🧰 `setup.ps1`
Main entry script. Downloads and executes all other modules from GitHub.

### 🔧 `tweaks.ps1`
- Enable Hibernate
- Move Downloads folder to D:\Downloads
- Classic context menu (Windows 11)
- Ungroup Taskbar icons (never combine mode)
- Set “This PC” as default in Explorer
- Show “This PC” on Desktop
- Hide default folders (Documents/Music/etc)
- Hide system recovery drive
- And more...

### 📥 `install-software.ps1`
Interactive UI to:
- Select software to install (via `winget` or direct URLs)
- Show progress and summaries

### 🧹 `remove-bloatware.ps1`
Uninstalls common unwanted apps (e.g., Xbox, Copilot, Feedback Hub, Clipchamp, etc.)
- Outputs a summary and writes to `D:\Downloads\uninstall-summary.txt`

---

## ✅ Requirements

- Windows 10/11
- PowerShell 5.1+ (built-in)
- Internet connection
- Run PowerShell as Administrator

---

## 📂 Folder Structure

```
aio-pc-setup-assistant/
├── setup.ps1                # Main entry point
├── tweaks.ps1               # System tweaks
├── install-software.ps1     # App installation UI
├── remove-bloatware.ps1     # Bloatware removal
└── README.md                # This file
```

---

## 🔐 Security

All scripts run in memory unless explicitly downloaded. The `Bypass` scope is temporary and does **not** persist after the session ends.

---

## ✨ Credits

Inspired by various Windows setup tools and custom workflows.
Special thanks to [Raphire/Win11Debloat](https://github.com/Raphire/Win11Debloat) for the inspiration and powerful debloat script integration.

# Portions of this script are adapted from:
# https://github.com/Raphire/Win11Debloat
# Licensed under the MIT License

### ⚠️ Disclaimer

This tool is provided **as-is** with no warranties or guarantees. It is intended for advanced users or clean installations where removing system apps and changing settings is acceptable.

> 🛑 **Run at your own risk.**  
> Always review scripts before execution, especially those that remove system components or modify the registry.

We recommend:
- Testing in a VM or non-critical system first
- Creating a system restore point
- Reviewing each module (`tweaks.ps1`, `install-software.ps1`, etc.) before running
