# Complete Remote Access Setup Guide for Windows 11

This guide will help you set up secure remote access to a Windows 11 computer using **Tailscale** (secure networking) and **Parsec** (high-quality remote desktop).

## What You'll Get

- **Git Bash**: Unix-like terminal on Windows
- **Tailscale**: Zero-config VPN (creates a secure private network)
- **Parsec**: Low-latency, high-quality remote desktop (way better than VNC/RDP)
- **Claude Code**: AI coding assistant accessible from Git Bash
- **Node.js**: Required for Claude Code

---

## Prerequisites

- Windows 11 computer
- Administrator access
- Internet connection
- Parsec account (free - create at [parsec.app](https://parsec.app))
- Tailscale account (free - create at [tailscale.com](https://tailscale.com))

---

## Part 1: Automated Installation

### Step 1: Download This Repository

1. Download this repository as a ZIP file or clone it:
   ```bash
   git clone <repository-url>
   ```

### Step 2: Run the Installation Script

1. **Right-click** on `windows-setup.ps1`
2. Select **"Run with PowerShell"**
3. If prompted, click **"Yes"** to run as Administrator
4. If you see a security warning, type `Y` and press Enter

The script will install:
- Chocolatey (package manager)
- Git Bash
- Tailscale
- Parsec
- Node.js

**This may take 10-15 minutes. Don't close the window!**

### Step 3: Restart Your Computer

After installation completes, **restart** your computer for all changes to take effect.

---

## Part 2: Configure Tailscale

### Step 1: Sign In to Tailscale

1. Press `Windows Key` and type **"Tailscale"**
2. Click **"Tailscale"** to open it
3. Click **"Log in"**
4. Create a free account or sign in with:
   - Google
   - Microsoft
   - GitHub
   - Email

### Step 2: Verify Connection

1. Click the **Tailscale icon** in the system tray (bottom-right)
2. You should see your computer listed
3. Note your **Tailscale IP address** (looks like `100.x.x.x`)

---

## Part 3: Configure Parsec

### Step 1: Sign In to Parsec

1. Press `Windows Key` and type **"Parsec"**
2. Click **"Parsec"** to open it
3. Create a free account at [parsec.app](https://parsec.app) if you don't have one
4. Sign in with your Parsec account

### Step 2: Enable Hosting

1. In Parsec, click the **Settings icon** (gear)
2. Go to **"Host"** tab
3. Enable **"Host Enabled"**
4. Set **"Host Privacy"** to **"My Friends"** (or "Private")

### Step 3: Run Security Configuration Script

1. **Right-click** on `configure-parsec.ps1`
2. Select **"Run with PowerShell"**
3. Follow the security recommendations shown

### Step 4: Approve Your Other Computer

1. On **your computer** (the one you'll connect FROM):
   - Install Parsec from [parsec.app](https://parsec.app)
   - Install Tailscale and connect to the same account
   - Sign in to Parsec with the **same account**

2. On the **remote computer** (the one you just set up):
   - Open Parsec
   - Go to **Settings > Friends**
   - Your other computer should appear
   - Click **"Add Friend"** if needed

---

## Part 4: Install Claude Code

Claude Code is an AI coding assistant that can help with programming tasks, troubleshooting, and automation.

### Step 1: Open Git Bash

1. Press `Windows Key` and type **"Git Bash"**
2. Click **"Git Bash"** to open it

### Step 2: Install Claude Code

Run this command in Git Bash:

```bash
npm install -g @anthropic-ai/claude-code
```

Wait for installation to complete (1-2 minutes).

### Step 3: Set Up Claude Code

1. Get your Anthropic API key from [console.anthropic.com](https://console.anthropic.com)
2. In Git Bash, run:
   ```bash
   claude-code
   ```
3. When prompted, paste your API key
4. Press Enter

### Step 4: Verify Installation

Test Claude Code:

```bash
claude-code "echo Hello from Claude!"
```

You should see Claude respond!

---

## Part 5: Connect Remotely

### From Your Computer:

1. **Ensure both computers are connected to Tailscale**
   - Click Tailscale tray icon on both machines
   - Verify both show "Connected"

2. **Open Parsec** on your computer

3. **Look for the remote computer** in your computers list
   - It should show as online
   - Computer name will match what you set up

4. **Click "Connect"**
   - You may be prompted for Windows password
   - First connection may take 30 seconds

5. **Enjoy your remote desktop!**
   - Ultra-low latency
   - High quality video
   - Full mouse/keyboard control

---

## Security Best Practices

### Tailscale Security

- ✅ Keep Tailscale logged in only when needed
- ✅ Use MFA (Multi-Factor Authentication) on your Tailscale account
- ✅ Review connected devices regularly in Tailscale admin panel
- ✅ Use Tailscale ACLs to restrict access between devices

### Parsec Security

- ✅ Use strong Windows password
- ✅ Enable Windows Hello / PIN
- ✅ Set Parsec to "Private" or "My Friends" only
- ✅ Don't share your Parsec account credentials
- ✅ Review approved friends regularly

### General Security

- ✅ Keep Windows Update enabled
- ✅ Enable Windows Defender
- ✅ Don't leave the computer unattended while connected remotely
- ✅ Log out of Parsec/Tailscale when not in use

---

## Troubleshooting

### Parsec Won't Connect

1. **Check Tailscale**: Both computers must be connected to Tailscale
   ```bash
   # In Git Bash or PowerShell:
   & "C:\Program Files\Tailscale\tailscale.exe" status
   ```

2. **Check Parsec hosting**: Open Parsec > Settings > Host > Verify "Host Enabled" is ON

3. **Restart Parsec**: Close Parsec completely and reopen it

4. **Check firewall**: Windows Defender may block first connection
   - Go to: Settings > Privacy & Security > Windows Security > Firewall
   - Click "Allow an app through firewall"
   - Ensure "Parsec" is checked for Private networks

### Git Bash Not Found

1. Restart your computer
2. Try running PowerShell instead:
   - Press `Windows Key + X`
   - Click "Windows PowerShell" or "Terminal"

### Node.js / npm Not Found

1. Restart Git Bash
2. Verify installation:
   ```bash
   node --version
   npm --version
   ```
3. If still not found, reinstall Node.js:
   ```powershell
   choco install nodejs -y --force
   ```

### Tailscale Not Connecting

1. Check your internet connection
2. Try signing out and back in:
   - Right-click Tailscale tray icon
   - Click "Log out"
   - Open Tailscale and log in again
3. Check Tailscale admin panel: [login.tailscale.com/admin](https://login.tailscale.com/admin)

### Claude Code API Key Issues

1. Verify your API key at [console.anthropic.com](https://console.anthropic.com)
2. Reset Claude Code configuration:
   ```bash
   claude-code --reset
   ```
3. Enter your API key again when prompted

---

## Alternative Remote Desktop Options

If you prefer different tools, here are alternatives:

### Instead of Parsec:

1. **RustDesk** (Open Source)
   - Install: `choco install rustdesk -y`
   - Free and open source
   - Similar to TeamViewer

2. **AnyDesk** (Freemium)
   - Install: `choco install anydesk -y`
   - Good performance
   - Easy to use

3. **Moonlight** (For NVIDIA GPUs only)
   - Install: `choco install moonlight-qt -y`
   - Best for gaming
   - Requires NVIDIA GPU

### Instead of Tailscale:

1. **ZeroTier** (Similar to Tailscale)
   - Install: `choco install zerotier-one -y`
   - Open source
   - More complex but powerful

2. **WireGuard** (Manual VPN)
   - Install: `choco install wireguard -y`
   - Requires manual configuration
   - Very lightweight

---

## Using Claude Code via Remote Desktop

Once you're connected via Parsec:

1. Open **Git Bash** on the remote computer
2. Navigate to your project:
   ```bash
   cd /c/Users/YourName/Projects/your-project
   ```
3. Start Claude Code:
   ```bash
   claude-code
   ```
4. Ask Claude for help!

Example commands:
```bash
# Get help with code
claude-code "explain this Python script"

# Write new code
claude-code "write a Python script to organize files by date"

# Debug issues
claude-code "why is my npm install failing?"

# System administration
claude-code "show me how to schedule a Windows task"
```

---

## Need Help?

If you run into issues:

1. **Check the Troubleshooting section above**
2. **Review the logs**:
   - Parsec logs: `%APPDATA%\Parsec\log`
   - Tailscale logs: Run `tailscale status` in terminal
3. **Contact support**:
   - Parsec: [support.parsec.app](https://support.parsec.app)
   - Tailscale: [tailscale.com/contact](https://tailscale.com/contact)
   - Claude Code: [github.com/anthropics/claude-code](https://github.com/anthropics/claude-code)

---

## Quick Reference Card

Print or save this for quick access:

```
┌─────────────────────────────────────────────────────────┐
│          QUICK REFERENCE CARD                           │
├─────────────────────────────────────────────────────────┤
│ Connect Remotely:                                       │
│  1. Ensure Tailscale is running on both computers      │
│  2. Open Parsec on your computer                       │
│  3. Click the remote computer name                     │
│  4. Click "Connect"                                    │
├─────────────────────────────────────────────────────────┤
│ Start Claude Code:                                      │
│  1. Open Git Bash                                       │
│  2. cd to your project folder                          │
│  3. Type: claude-code                                  │
├─────────────────────────────────────────────────────────┤
│ Check Tailscale Status:                                │
│  tailscale status                                      │
├─────────────────────────────────────────────────────────┤
│ Emergency Disconnect:                                   │
│  Right-click Parsec tray icon → Disconnect            │
└─────────────────────────────────────────────────────────┘
```

---

**Setup complete! Enjoy secure remote access to your Windows 11 computer!** 🎉
