# Install Advanced Podcasting Software
# Installs Discord, Descript, Reaper, and Voicemeeter
# Run as Administrator in PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Advanced Podcast Software Installation" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "WARNING: Not running as Administrator." -ForegroundColor Yellow
    Write-Host "Some installations may fail. Right-click and 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host ""
    pause
}

# Check if Chocolatey is installed
Write-Host "Checking for Chocolatey package manager..." -ForegroundColor Cyan
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey installed!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Green
    Write-Host ""
}

# Create temp directory for downloads
$tempDir = "$env:TEMP\PodcastSetup"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

# Function to download files
function Download-File {
    param($url, $output)
    Write-Host "  Downloading from: $url" -ForegroundColor Yellow
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        $ProgressPreference = 'Continue'
        return $true
    } catch {
        Write-Host "  Failed to download: $_" -ForegroundColor Red
        return $false
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installing Software..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Install Discord
Write-Host "[1/4] Installing Discord..." -ForegroundColor Cyan
if (!(Test-Path "$env:LOCALAPPDATA\Discord\Update.exe")) {
    choco install discord -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Discord installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "  Discord installation encountered issues. It may still work." -ForegroundColor Yellow
    }
} else {
    Write-Host "  Discord is already installed." -ForegroundColor Green
}
Write-Host ""

# Install Voicemeeter (Banana)
Write-Host "[2/4] Installing Voicemeeter Banana..." -ForegroundColor Cyan
Write-Host "  Voicemeeter is a virtual audio mixer for advanced routing" -ForegroundColor Gray
if (!(Test-Path "C:\Program Files (x86)\VB\Voicemeeter\voicemeeterpro.exe") -and !(Test-Path "C:\Program Files\VB\Voicemeeter\voicemeeterpro.exe")) {
    choco install voicemeeter-banana -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Voicemeeter Banana installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "  Voicemeeter installation encountered issues." -ForegroundColor Yellow
    }
} else {
    Write-Host "  Voicemeeter is already installed." -ForegroundColor Green
}
Write-Host ""

# Install Reaper
Write-Host "[3/4] Installing Reaper DAW..." -ForegroundColor Cyan
Write-Host "  Reaper is a professional Digital Audio Workstation" -ForegroundColor Gray
Write-Host "  Note: Reaper requires a license ($60) after 60-day trial" -ForegroundColor Yellow
if (!(Test-Path "C:\Program Files\REAPER\reaper.exe")) {
    choco install reaper -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Reaper installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "  Reaper installation encountered issues." -ForegroundColor Yellow
    }
} else {
    Write-Host "  Reaper is already installed." -ForegroundColor Green
}
Write-Host ""

# Install Descript
Write-Host "[4/4] Installing Descript..." -ForegroundColor Cyan
Write-Host "  Descript is an AI-powered podcast editor" -ForegroundColor Gray
Write-Host "  Note: Descript requires an account (free tier available)" -ForegroundColor Yellow

# Descript is not in Chocolatey, need to download manually
$descriptInstaller = "$tempDir\descript-setup.exe"
Write-Host "  Downloading Descript installer..." -ForegroundColor Yellow

if (Download-File "https://electron.descript.com/Descript.exe" $descriptInstaller) {
    Write-Host "  Running Descript installer..." -ForegroundColor Yellow
    Start-Process -FilePath $descriptInstaller -ArgumentList "/S" -Wait -ErrorAction SilentlyContinue
    Write-Host "  Descript installation completed!" -ForegroundColor Green
    Write-Host "  You'll need to create an account when you first open Descript" -ForegroundColor Yellow
} else {
    Write-Host "  Could not download Descript automatically." -ForegroundColor Yellow
    Write-Host "  Please download manually from: https://www.descript.com/download" -ForegroundColor Cyan
}
Write-Host ""

# Cleanup
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Cleanup complete!" -ForegroundColor Green
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Green
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Installed Software:" -ForegroundColor Yellow
Write-Host "  1. Discord - For remote guest calls" -ForegroundColor White
Write-Host "  2. Voicemeeter Banana - Virtual audio mixer" -ForegroundColor White
Write-Host "  3. Reaper - Professional DAW (60-day trial)" -ForegroundColor White
Write-Host "  4. Descript - AI podcast editor (free tier)" -ForegroundColor White
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "For Discord:" -ForegroundColor Yellow
Write-Host "  1. Open Discord from Start menu" -ForegroundColor White
Write-Host "  2. Create account or sign in" -ForegroundColor White
Write-Host "  3. User Settings > Voice & Video > Set input to Q802USB" -ForegroundColor White
Write-Host ""

Write-Host "For Voicemeeter:" -ForegroundColor Yellow
Write-Host "  1. Restart your computer (required for virtual audio drivers)" -ForegroundColor White
Write-Host "  2. Open Voicemeeter Banana from Start menu" -ForegroundColor White
Write-Host "  3. Set Hardware Input 1 to Q802USB (USB Audio CODEC)" -ForegroundColor White
Write-Host "  4. Route to your desired outputs" -ForegroundColor White
Write-Host ""

Write-Host "For Reaper:" -ForegroundColor Yellow
Write-Host "  1. Open Reaper from Start menu" -ForegroundColor White
Write-Host "  2. Go through first-time setup wizard" -ForegroundColor White
Write-Host "  3. Set audio device to Q802USB or Voicemeeter" -ForegroundColor White
Write-Host "  4. Consider purchasing license after trial ($60)" -ForegroundColor White
Write-Host ""

Write-Host "For Descript:" -ForegroundColor Yellow
Write-Host "  1. Open Descript from Start menu" -ForegroundColor White
Write-Host "  2. Create free account or sign in" -ForegroundColor White
Write-Host "  3. Import your podcast recordings to edit" -ForegroundColor White
Write-Host "  4. Use AI features: transcription, filler word removal, etc." -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Important Notes:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Voicemeeter:" -ForegroundColor Yellow
Write-Host "  - Requires restart to activate virtual audio drivers" -ForegroundColor White
Write-Host "  - Advanced tool - see guide for setup instructions" -ForegroundColor White
Write-Host ""
Write-Host "Reaper:" -ForegroundColor Yellow
Write-Host "  - 60-day fully functional trial" -ForegroundColor White
Write-Host "  - License is `$60 (very affordable for a DAW)" -ForegroundColor White
Write-Host "  - More advanced than Audacity, steeper learning curve" -ForegroundColor White
Write-Host ""
Write-Host "Descript:" -ForegroundColor Yellow
Write-Host "  - Free tier: 1 hour transcription/month" -ForegroundColor White
Write-Host "  - Paid: `$12-24/month for unlimited" -ForegroundColor White
Write-Host "  - Game-changer for podcast editing!" -ForegroundColor White
Write-Host ""

Write-Host "For detailed setup instructions, see the interactive guide!" -ForegroundColor Cyan
Write-Host ""

pause
