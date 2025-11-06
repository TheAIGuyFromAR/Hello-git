# Windows 11 Remote Access Setup

Complete setup scripts for secure remote access to a Windows 11 computer using **Tailscale** + **Parsec** + **Git Bash** + **Claude Code**.

## 🚀 Quick Start

1. **Download** this repository to the Windows 11 computer
2. **Right-click** `windows-setup.ps1` → **Run with PowerShell** (as Admin)
3. **Restart** the computer when prompted
4. **Follow** the detailed instructions in [SETUP-GUIDE.md](SETUP-GUIDE.md)

## 📦 What Gets Installed

- **Git Bash** - Unix-like terminal for Windows
- **Tailscale** - Secure zero-config VPN (creates private network)
- **Parsec** - Ultra-low latency remote desktop (better than VNC/RDP)
- **Node.js** - Required for Claude Code
- **Claude Code** - AI coding assistant (install after restart)

## 🔒 Security Features

- All remote connections go through Tailscale's encrypted tunnel
- No ports exposed to the internet
- Parsec configured for private access only
- Full end-to-end encryption

## 📖 Documentation

- **[SETUP-GUIDE.md](SETUP-GUIDE.md)** - Complete step-by-step instructions
- **[configure-parsec.ps1](configure-parsec.ps1)** - Security configuration script
- **[windows-setup.ps1](windows-setup.ps1)** - Automated installation script

## 🆘 Quick Troubleshooting

**Parsec won't connect?**
- Ensure both computers are connected to Tailscale
- Check that "Host Enabled" is ON in Parsec settings

**Git Bash not found?**
- Restart your computer
- Try using PowerShell instead

**More help?** See the Troubleshooting section in [SETUP-GUIDE.md](SETUP-GUIDE.md)

---

Made for setting up remote access on a family member's computer 💻