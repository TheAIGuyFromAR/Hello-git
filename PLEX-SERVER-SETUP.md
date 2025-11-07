# Connecting to Shared Plex Server

## Overview

Your brother-in-law will connect to **your Plex server** to stream movies for podcast recording. This allows them to watch and record reactions to films from your collection!

---

## Setup Instructions

### Step 1: Share Your Plex Server

**On YOUR computer (Plex server owner):**

1. Open **Plex Web App**: https://app.plex.tv
2. Go to **Settings** (wrench icon) → **Users & Sharing**
3. Click **"Invite Friend"**
4. Enter your brother-in-law's email address
5. Select which libraries to share (Movies, TV Shows, etc.)
6. Click **"Send Invite"**

### Step 2: Accept Invitation

**On THEIR computer (podcast setup):**

1. Check email for Plex invitation
2. Click **"Accept Invite"**
3. Create Plex account (or sign in if they have one)
4. They'll now see your shared libraries!

### Step 3: Access Plex for Recording

**Two ways to access:**

#### Option A: Plex Web App (Recommended for OBS)
1. Go to: **https://app.plex.tv**
2. Sign in with their Plex account
3. Your server will appear in the left sidebar
4. Click server name → Browse movies
5. Click movie → Play in browser (fullscreen)

**Why this is best for OBS:**
- Clean fullscreen view
- Easy to capture with Window Capture in OBS
- No extra applications needed

#### Option B: Plex Desktop App
1. Download from: https://www.plex.tv/media-server-downloads/#plex-app
2. Install and sign in
3. Access your shared server
4. Play movies in app

---

## For OBS Recording (Watch Party Style)

### Using Plex Web App in Browser:

**Step 1: Start Movie in Plex**
1. Open **Plex Web** in browser (Chrome/Edge/Firefox)
2. Navigate to your shared server
3. Select movie to watch
4. Click **Play**
5. Press **F** for fullscreen

**Step 2: Capture in OBS**
1. OBS → Sources → **"+" → Window Capture**
2. Select browser window: `[chrome.exe]: Plex` (or Edge, Firefox)
3. **Capture Method**: Windows 10/11
4. Position as background layer in OBS

**Step 3: Audio Setup**
1. Movie audio will come through **Desktop Audio** in OBS
2. Lower Desktop Audio to **-15 dB to -20 dB**
3. Keep mic audio (Q802USB) at **0 dB**
4. This ensures voices are louder than movie

---

## Connection Details

**IMPORTANT: Plex server is only accessible over Tailscale VPN!**

**Plex Server URL:**
```
http://theater.castle.emeraldfam.org:32400
```

**Requirements:**
- ✅ Tailscale must be connected on BOTH computers
- ✅ Both must be logged into the same Tailscale network
- ✅ Plex server only works through this secure tunnel (not public internet)

**How to Access:**
1. Make sure **Tailscale is running and connected** (green icon in system tray)
2. Open browser and go to: `http://theater.castle.emeraldfam.org:32400/web`
3. Sign in with Plex account
4. Server should appear and be accessible!

---

## Important Notes

### Bandwidth & Quality
- **Your Upload Speed** determines their streaming quality
- For smooth 1080p: Need at least **10 Mbps upload** on your end
- For 4K: Need **25+ Mbps upload**
- Set quality in Plex settings if needed:
  - Settings → Quality → Remote Stream Quality

### Tailscale Connection Setup

**BOTH computers must be on Tailscale!**

**Your computer (Plex server):**
1. Make sure Tailscale is running and connected
2. Plex should be accessible at: `http://theater.castle.emeraldfam.org:32400`

**Their computer (podcast setup):**
1. Click **Tailscale icon** in system tray (bottom-right)
2. Verify status shows **"Connected"**
3. You should see your Plex server computer listed in Tailscale
4. Now they can access Plex at `http://theater.castle.emeraldfam.org:32400/web`

**Why Tailscale?**
- Secure encrypted connection (no public internet exposure)
- No port forwarding needed
- Works like a private network between your computers
- Fast and reliable streaming

### Copyright Considerations
- Sharing movies through Plex = Personal use with family
- Recording reactions = Fair use for commentary/review
- **DO NOT** redistribute full movies or post full-length recordings
- Podcast reactions/commentary with clips = Generally OK under fair use

---

## Troubleshooting

### "Server not found"
- Check that you've sent the invitation from your Plex server
- Verify they accepted the invite and created account
- Make sure Remote Access is enabled on your server

### "Buffering constantly"
- Your upload speed may be too slow
- Lower streaming quality in Plex:
  - Settings → Quality → Remote Stream Quality → 720p 3Mbps

### "No audio in OBS"
- Make sure browser tab is NOT muted
- Check OBS **Desktop Audio** is not muted
- Verify Desktop Audio is capturing the correct device (Windows default)

### "Movie looks choppy in recording"
- Lower Plex quality to reduce bandwidth
- Close other apps using internet on both ends
- Use Window Capture instead of Display Capture in OBS

---

## Alternative: Download & Play Locally

If streaming is problematic:

1. **Download movies to their computer** (if you allow download in sharing settings)
2. **Play locally** using VLC or Windows Media Player
3. **Capture in OBS** same way
4. No buffering issues!

**To enable downloads:**
- Plex Settings → Users & Sharing → User → Allow Downloads

---

## Quick Reference

```
┌──────────────────────────────────────────────────────────────┐
│  PLEX CONNECTION QUICK REFERENCE                             │
├──────────────────────────────────────────────────────────────┤
│  ⚠️  MUST BE CONNECTED TO TAILSCALE FIRST!                   │
│                                                              │
│  URL: http://theater.castle.emeraldfam.org:32400/web        │
│  Tailscale Required: YES (both computers)                   │
│  Streaming Quality: 1080p 8Mbps (recommended)               │
│                                                              │
│  PRE-FLIGHT CHECK:                                          │
│  1. Is Tailscale running? (check system tray icon)         │
│  2. Is status "Connected"? (click icon to verify)          │
│  3. Can you ping theater.castle.emeraldfam.org?            │
│                                                              │
│  FOR OBS:                                                   │
│  - Use Window Capture                                       │
│  - Capture browser with Plex fullscreen                     │
│  - Desktop Audio: -15 dB                                    │
│  - Mic Audio (Q802USB): 0 dB                                │
└──────────────────────────────────────────────────────────────┘
```

---

## Next Steps

1. ✅ You share your Plex server with them
2. ✅ They accept invitation and create account
3. ✅ They test streaming a movie
4. ✅ They set up OBS Window Capture for Plex
5. ✅ Record test episode!

Once you have your **Plex server URL and sharing set up**, provide them with:
- Plex server name
- Login credentials (their Plex account email)
- Recommended streaming quality

---

**Happy Streaming!** 🎬📺
