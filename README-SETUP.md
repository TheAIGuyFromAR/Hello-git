# Film Podcast Setup - Quick Reference

## 🎬 What You Have

Your brother-in-law's complete film podcast setup for creating movie review content!

### Equipment
- **Behringer Q802USB** mixer
- **Dynamic XLR microphones** on spring-loaded boom arms (no phantom power needed!)
- **Logitech webcam** on tripod
- **14" ring light** on separate tripod
- **Windows 11 PC** with all software installed

### Software Installed
- ✅ **OBS Studio** - Recording & streaming
- ✅ **Audacity** - Audio editing
- ✅ **Discord** - Remote guest calls
- ✅ **Reaper** - Professional DAW (60-day trial)
- ✅ **Voicemeeter Banana** - Virtual audio mixer
- ✅ **Parsec** - Remote desktop access
- ✅ **Tailscale** - Secure VPN
- ✅ **Git Bash** - Terminal
- ✅ **Node.js** - For Claude Code

---

## 🚀 Quick Start

1. **Open the main guide:** `podcast-guide.html` in any browser
2. **For detailed OBS setups:** `production-scenarios.html`
3. **Run setup scripts if needed:**
   - `windows-setup.ps1` - Installs missing software
   - `setup-obs-audio-filters.ps1` - Audio filter guide
   - `configure-parsec.ps1` - Remote access setup

---

## 🎙️ Dynamic Microphones Explained

**What are they?**
- Microphones that DON'T need phantom power (+48V)
- Plug directly into Q802USB and work immediately
- Examples: Shure SM7B, SM58, Audio-Technica ATR2100

**Why they're perfect for podcasts:**
- ✓ Reject background noise (great for noisy rooms)
- ✓ Only pick up what's directly in front (off-axis rejection)
- ✓ Durable and reliable
- ✓ No special power needed

**Setup:**
1. Plug XLR cable into mic
2. Plug other end into Q802USB Channel 1 (or Channel 2 for second mic)
3. Turn up GAIN knob to 12 o'clock position
4. Raise channel fader to -5 dB or 0 dB
5. Done! No phantom power switch needed.

---

## 📹 Production Scenarios Available

The `production-scenarios.html` guide includes step-by-step OBS instructions for:

1. **Watch Party Reaction** - Picture-in-Picture with Plex movie
2. **Talking Head Review** - Green screen/chroma key setup
3. **Two-Host Review** - Dual mics setup
4. **Remote Guest Interview** - Discord integration
5. **Top 10 Lists** - Graphics and overlays
6. **Audio-Only** - Podcast-only recording
7. **Awards Show Coverage** - Live commentary
8. **Movie Analysis** - Deep-dive with clips

---

## 🔗 All Files in This Folder

- `podcast-guide.html` - **Main guide** (start here!)
- `production-scenarios.html` - **OBS setup scenarios**
- `PLEX-SERVER-SETUP.md` - **How to connect to shared Plex server over Tailscale**
- `windows-setup.ps1` - Software installation script
- `install-podcast-software.ps1` - Discord, Descript, Reaper, Voicemeeter installer
- `setup-obs-audio-filters.ps1` - Audio filter configuration guide
- `configure-parsec.ps1` - Remote desktop setup
- `SETUP-GUIDE.md` - Tailscale + Parsec detailed guide
- `README.md` - Remote access info

---

## 💡 Key Points

- **Dynamic mics** = No phantom power needed
- **Q802USB** handles all the audio mixing
- **OBS** does the video recording with audio from Q802USB
- **Parsec + Tailscale** = You can help remotely anytime

---

## 🆘 Need Help?

1. Check the **Troubleshooting** section in `podcast-guide.html`
2. Watch the linked YouTube tutorials
3. Use Parsec to connect remotely and help directly!

---

**Created with Claude Code** 🎬🎙️
