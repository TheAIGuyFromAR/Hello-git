# Configure Parsec for Secure Remote Access via Tailscale
# Run this AFTER installing Parsec via windows-setup.ps1
# Run as Administrator in PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Parsec Security Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "WARNING: Running as non-admin. Some configurations may not work." -ForegroundColor Yellow
    Write-Host ""
}

# Check if Parsec is installed
$parsecConfigPath = "$env:APPDATA\Parsec\config.txt"

if (!(Test-Path $parsecConfigPath)) {
    Write-Host "Parsec configuration not found." -ForegroundColor Yellow
    Write-Host "Please ensure Parsec is installed and you've signed in at least once." -ForegroundColor Yellow
    Write-Host ""
}

# Get Tailscale IP
Write-Host "Getting your Tailscale information..." -ForegroundColor Cyan
$tailscaleIP = $null

try {
    $tailscaleStatus = & "C:\Program Files\Tailscale\tailscale.exe" status --json 2>$null | ConvertFrom-Json
    $tailscaleIP = $tailscaleStatus.Self.TailscaleIPs[0]
} catch {
    Write-Host "Could not get Tailscale status. Is Tailscale installed and running?" -ForegroundColor Red
}

if ($tailscaleIP) {
    Write-Host "Your Tailscale IP: $tailscaleIP" -ForegroundColor Green
} else {
    Write-Host "WARNING: Could not retrieve Tailscale IP!" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Parsec Security Recommendations" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "For maximum security when using Parsec with Tailscale:" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. In Parsec Settings:" -ForegroundColor Cyan
Write-Host "   - Go to Settings > Network" -ForegroundColor White
Write-Host "   - Disable 'Public Computer' mode" -ForegroundColor White
Write-Host "   - Enable 'Hosting Enabled'" -ForegroundColor White
Write-Host "   - Set 'Hosting' to 'Private'" -ForegroundColor White
Write-Host ""

Write-Host "2. Share computer only with trusted accounts:" -ForegroundColor Cyan
Write-Host "   - Go to Settings > Hosting" -ForegroundColor White
Write-Host "   - Only approve specific Parsec friends" -ForegroundColor White
Write-Host "   - Don't use 'Anyone with Link' unless needed" -ForegroundColor White
Write-Host ""

Write-Host "3. Additional Security:" -ForegroundColor Cyan
Write-Host "   - Use a strong Windows password" -ForegroundColor White
Write-Host "   - Enable Windows Hello / PIN login" -ForegroundColor White
Write-Host "   - Keep Tailscale ACLs restrictive" -ForegroundColor White
Write-Host ""

Write-Host "4. Connection Method:" -ForegroundColor Cyan
Write-Host "   - Parsec works over Tailscale automatically!" -ForegroundColor White
Write-Host "   - No need to open firewall ports" -ForegroundColor White
Write-Host "   - All traffic is encrypted by Tailscale" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "Configuration Guide Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

if ($tailscaleIP) {
    Write-Host "Computer Details:" -ForegroundColor Yellow
    Write-Host "  Tailscale IP: $tailscaleIP" -ForegroundColor White
    Write-Host "  Computer Name: $env:COMPUTERNAME" -ForegroundColor White
    Write-Host ""
    Write-Host "To connect:" -ForegroundColor Yellow
    Write-Host "  1. Make sure you're connected to Tailscale on both computers" -ForegroundColor White
    Write-Host "  2. Open Parsec client" -ForegroundColor White
    Write-Host "  3. Look for this computer: $env:COMPUTERNAME" -ForegroundColor White
    Write-Host "  4. Click 'Connect'" -ForegroundColor White
}

Write-Host ""
Write-Host "For detailed instructions, see SETUP-GUIDE.md" -ForegroundColor Cyan
Write-Host ""

pause
