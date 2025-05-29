
# 🛠 Troubleshooting Guide: AIO PC Setup Assistant

If the script fails, it may be due to system-specific issues.
Here are some steps to diagnose and resolve common problems.

---

## 1. 🔒 PowerShell Execution Policy

Check the policy using:

```powershell
Get-ExecutionPolicy -List
```

Make sure the `Process` or `CurrentUser` scope is not set to `Restricted`.

Temporarily allow the script:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

---

## 2. 🧰 winget Not Installed or Outdated

Check if `winget` is available:

```powershell
winget --version
```

If it's not found, install or update **App Installer** from the Microsoft Store, or visit:

👉 https://aka.ms/getwinget

---

## 3. 🪟 Missing .NET / GUI Support

Ensure the system supports Windows Forms (needed for the UI).

Test with:

```powershell
[System.Windows.Forms.MessageBox]::Show("Testing GUI")
```

If no dialog appears, Windows Forms is broken or unavailable.

---

## 4. 🌐 Internet / Firewall Issues

Test connectivity:

```powershell
Invoke-WebRequest https://www.google.com
```

If it fails, check your firewall, proxy, or antivirus.

---

## 5. 🛡 Antivirus Interference

Some antivirus tools silently block scripts or apps (e.g., Norton, McAfee).

✅ Try disabling antivirus temporarily and rerun the script.

---

## 6. 📄 Enable Logging

For debugging, use this at the beginning of your script to log output:

```powershell
Start-Transcript -Path "D:\Downloads\install-log.txt" -Append
# your script code
Stop-Transcript
```

---

## Still not working?

Feel free to raise an issue with details on your OS version, error messages, and logs.
