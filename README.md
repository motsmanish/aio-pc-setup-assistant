# 🖥️ AIO PC Setup Assistant

A fully automated PowerShell-based setup assistant for fresh Windows installs. This tool helps you:

- ✅ Install essential and developer software  
- 🛠 Apply system tweaks (like moving Downloads, enabling Hibernate, etc.)  
- 🧹 Remove bloatware via a well-maintained external script

---

## 🚀 Quick Commands

Open PowerShell **as Administrator**, and run any of these individually:

### 🛠️ System Tweaks

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/motsmanish/aio-pc-setup-assistant/main/tweaks.ps1")))
```

> Enables Hibernate, classic context menu, sets "This PC" as default view, and more.

---

### 📦 Install Essential Software

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/motsmanish/aio-pc-setup-assistant/main/install-software.ps1")))
```

> Interactive menu to install browsers, dev tools, utilities via `winget` or direct URLs.

---

### 🧹 Remove Bloatware (External Script)

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
```

> This runs the popular [Raphire/Win11Debloat](https://github.com/Raphire/Win11Debloat) script.  
> We chose not to recreate this ourselves — it's well-tested and trusted.

---

## ✅ Requirements

- Windows 10/11  
- PowerShell 5.1+ (preinstalled)  
- Internet connection  
- Must be run as Administrator

---

## 📁 Folder Structure

```
aio-pc-setup-assistant/
├── tweaks.ps1               # System tweaks
├── install-software.ps1     # Software installer
└── README.md                # This file
```

---

## 🔐 Security

All scripts run in memory unless explicitly downloaded. The `Bypass` scope is temporary and does **not** persist beyond the current session.

---

## ✨ Credits

Special thanks to:

- [Raphire/Win11Debloat](https://github.com/Raphire/Win11Debloat) — for their excellent bloatware removal script
- The open source community for sharing awesome tools

> Portions of this assistant are adapted or inspired by community scripts, and licensed appropriately.

---

### ⚠️ Disclaimer

This tool is provided **as-is** with no warranties or guarantees. It is intended for advanced users or clean installations where removing system apps and changing settings is acceptable.

> 🛑 **Use at your own risk.**  
> Always review code before execution, especially anything that modifies system behavior.

We recommend:
- Testing in a VM or backup machine  
- Creating a system restore point  
- Reviewing each module (`tweaks.ps1`, `install-software.ps1`) before running
