# Windows Remote Access Setup Script
# This script installs Git Bash, Tailscale, Parsec, and Claude Code
# Run as Administrator in PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Remote Access Setup for Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    pause
    exit 1
}

# Create temporary directory for downloads
$tempDir = "$env:TEMP\RemoteSetup"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
Write-Host "[1/5] Created temporary directory: $tempDir" -ForegroundColor Green

# Function to download files
function Download-File {
    param($url, $output)
    Write-Host "Downloading: $url" -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
        return $true
    } catch {
        Write-Host "Failed to download: $_" -ForegroundColor Red
        return $false
    }
}

# Install Chocolatey (package manager for Windows)
Write-Host ""
Write-Host "[2/5] Checking Chocolatey installation..." -ForegroundColor Cyan
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey installed successfully!" -ForegroundColor Green
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Green
}

# Install Git Bash
Write-Host ""
Write-Host "[3/5] Installing Git Bash..." -ForegroundColor Cyan
if (!(Test-Path "C:\Program Files\Git\bin\bash.exe")) {
    choco install git -y
    Write-Host "Git Bash installed successfully!" -ForegroundColor Green
} else {
    Write-Host "Git Bash is already installed." -ForegroundColor Green
}

# Install Tailscale
Write-Host ""
Write-Host "[4/5] Installing Tailscale..." -ForegroundColor Cyan
$tailscaleInstaller = "$tempDir\tailscale-setup.exe"
if (Download-File "https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe" $tailscaleInstaller) {
    Start-Process -FilePath $tailscaleInstaller -ArgumentList "/quiet" -Wait
    Write-Host "Tailscale installed successfully!" -ForegroundColor Green
    Write-Host "IMPORTANT: You need to authenticate Tailscale after this script completes." -ForegroundColor Yellow
} else {
    Write-Host "Failed to download Tailscale. Please install manually from https://tailscale.com/download" -ForegroundColor Red
}

# Install Parsec
Write-Host ""
Write-Host "[5/5] Installing Parsec..." -ForegroundColor Cyan
$parsecInstaller = "$tempDir\parsec-setup.exe"
if (Download-File "https://builds.parsec.app/package/parsec-windows.exe" $parsecInstaller) {
    Start-Process -FilePath $parsecInstaller -ArgumentList "/S" -Wait
    Write-Host "Parsec installed successfully!" -ForegroundColor Green
    Write-Host "IMPORTANT: You need to create a Parsec account and sign in after restart." -ForegroundColor Yellow
} else {
    Write-Host "Failed to download Parsec. Please install manually from https://parsec.app/downloads" -ForegroundColor Red
}

# Install Node.js (required for Claude Code)
Write-Host ""
Write-Host "[BONUS] Installing Node.js (required for Claude Code)..." -ForegroundColor Cyan
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    choco install nodejs -y
    Write-Host "Node.js installed successfully!" -ForegroundColor Green
} else {
    Write-Host "Node.js is already installed." -ForegroundColor Green
}

# Cleanup
Write-Host ""
Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Restart your computer to ensure all changes take effect" -ForegroundColor White
Write-Host "2. Open 'Tailscale' from Start menu and sign in with your account" -ForegroundColor White
Write-Host "3. Open 'Parsec' and create/sign in to your account" -ForegroundColor White
Write-Host "4. Configure Parsec to only accept connections from your Tailscale network" -ForegroundColor White
Write-Host "5. Install Claude Code by opening Git Bash and running:" -ForegroundColor White
Write-Host "   npm install -g @anthropic-ai/claude-code" -ForegroundColor Cyan
Write-Host ""
Write-Host "See SETUP-GUIDE.md for detailed instructions!" -ForegroundColor Yellow
Write-Host ""

pause
