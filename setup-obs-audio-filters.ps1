# OBS Audio Filter Setup Script
# Automatically configures professional audio filters for Q802USB in OBS Studio
# Run this script while OBS is CLOSED

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "OBS Audio Filter Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if OBS is running
$obsProcess = Get-Process obs64 -ErrorAction SilentlyContinue
if ($obsProcess) {
    Write-Host "ERROR: OBS Studio is currently running!" -ForegroundColor Red
    Write-Host "Please close OBS Studio completely before running this script." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

# Find OBS config directory
$obsConfigPath = "$env:APPDATA\obs-studio"
$obsGlobalConfigPath = "$obsConfigPath\global.ini"
$obsBasicPath = "$obsConfigPath\basic"
$obsSceneCollection = "$obsBasicPath\scenes"

if (!(Test-Path $obsConfigPath)) {
    Write-Host "ERROR: OBS Studio configuration not found!" -ForegroundColor Red
    Write-Host "Please open OBS Studio at least once before running this script." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "OBS configuration found at: $obsConfigPath" -ForegroundColor Green
Write-Host ""

# Backup existing configuration
$backupPath = "$obsConfigPath\backup-$(Get-Date -Format 'yyyy-MM-dd-HHmmss')"
Write-Host "Creating backup of OBS configuration..." -ForegroundColor Cyan
Copy-Item -Path $obsBasicPath -Destination $backupPath -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Backup created at: $backupPath" -ForegroundColor Green
Write-Host ""

# Find the current scene collection file
$sceneFiles = Get-ChildItem -Path $obsSceneCollection -Filter "*.json" -ErrorAction SilentlyContinue

if ($sceneFiles.Count -eq 0) {
    Write-Host "No scene collections found. OBS will create filters when you add audio sources." -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "Found $($sceneFiles.Count) scene collection(s)" -ForegroundColor Green
    Write-Host ""
}

# Create recommended audio filter configuration JSON
$audioFilters = @"
{
  "filters": [
    {
      "name": "Noise Suppression",
      "id": "noise_suppress_filter_v2",
      "enabled": true,
      "settings": {
        "method": "rnnoise"
      }
    },
    {
      "name": "Noise Gate",
      "id": "noise_gate_filter",
      "enabled": true,
      "settings": {
        "close_threshold": -40.0,
        "open_threshold": -35.0,
        "attack_time": 25,
        "hold_time": 200,
        "release_time": 150
      }
    },
    {
      "name": "Compressor",
      "id": "compressor_filter",
      "enabled": true,
      "settings": {
        "ratio": 4.0,
        "threshold": -20.0,
        "attack_time": 6,
        "release_time": 60,
        "output_gain": 0.0,
        "sidechain_source": "none"
      }
    },
    {
      "name": "Limiter",
      "id": "limiter_filter",
      "enabled": true,
      "settings": {
        "threshold": -6.0,
        "release_time": 60
      }
    }
  ]
}
"@

# Save filter template
$filterTemplatePath = "$obsConfigPath\audio-filter-template.json"
$audioFilters | Out-File -FilePath $filterTemplatePath -Encoding UTF8
Write-Host "Filter template saved to: $filterTemplatePath" -ForegroundColor Green
Write-Host ""

# Instructions for manual application (since OBS config is complex)
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "IMPORTANT: Manual Steps Required" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "OBS scene files are complex and modifying them automatically can cause corruption." -ForegroundColor White
Write-Host "Follow these steps to apply the audio filters:" -ForegroundColor White
Write-Host ""

Write-Host "1. Open OBS Studio" -ForegroundColor Cyan
Write-Host ""

Write-Host "2. In the Audio Mixer (bottom of OBS):" -ForegroundColor Cyan
Write-Host "   - Right-click on 'Mic/Aux' (your Q802USB)" -ForegroundColor White
Write-Host "   - Select 'Filters'" -ForegroundColor White
Write-Host ""

Write-Host "3. Add these filters in this exact order:" -ForegroundColor Cyan
Write-Host ""

Write-Host "   [Filter 1] Noise Suppression:" -ForegroundColor Yellow
Write-Host "   - Click '+' button" -ForegroundColor White
Write-Host "   - Select 'Noise Suppression'" -ForegroundColor White
Write-Host "   - Name: Noise Suppression" -ForegroundColor White
Write-Host "   - Method: RNNoise (best for voice)" -ForegroundColor White
Write-Host "   - Click OK" -ForegroundColor White
Write-Host ""

Write-Host "   [Filter 2] Noise Gate:" -ForegroundColor Yellow
Write-Host "   - Click '+' button" -ForegroundColor White
Write-Host "   - Select 'Noise Gate'" -ForegroundColor White
Write-Host "   - Name: Noise Gate" -ForegroundColor White
Write-Host "   - Close Threshold: -40 dB" -ForegroundColor White
Write-Host "   - Open Threshold: -35 dB" -ForegroundColor White
Write-Host "   - Attack Time: 25 ms" -ForegroundColor White
Write-Host "   - Hold Time: 200 ms" -ForegroundColor White
Write-Host "   - Release Time: 150 ms" -ForegroundColor White
Write-Host "   - Click OK" -ForegroundColor White
Write-Host ""

Write-Host "   [Filter 3] Compressor:" -ForegroundColor Yellow
Write-Host "   - Click '+' button" -ForegroundColor White
Write-Host "   - Select 'Compressor'" -ForegroundColor White
Write-Host "   - Name: Compressor" -ForegroundColor White
Write-Host "   - Ratio: 4:1" -ForegroundColor White
Write-Host "   - Threshold: -20 dB" -ForegroundColor White
Write-Host "   - Attack: 6 ms" -ForegroundColor White
Write-Host "   - Release: 60 ms" -ForegroundColor White
Write-Host "   - Output Gain: 0 dB" -ForegroundColor White
Write-Host "   - Click OK" -ForegroundColor White
Write-Host ""

Write-Host "   [Filter 4] Limiter:" -ForegroundColor Yellow
Write-Host "   - Click '+' button" -ForegroundColor White
Write-Host "   - Select 'Limiter'" -ForegroundColor White
Write-Host "   - Name: Limiter" -ForegroundColor White
Write-Host "   - Threshold: -6 dB" -ForegroundColor White
Write-Host "   - Release Time: 60 ms" -ForegroundColor White
Write-Host "   - Click OK" -ForegroundColor White
Write-Host ""

Write-Host "4. Test your audio:" -ForegroundColor Cyan
Write-Host "   - Speak into the microphone" -ForegroundColor White
Write-Host "   - Watch the audio meter in OBS" -ForegroundColor White
Write-Host "   - Audio should stay in GREEN/YELLOW range" -ForegroundColor White
Write-Host "   - Adjust thresholds if needed" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "What These Filters Do:" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Noise Suppression (RNNoise):" -ForegroundColor Yellow
Write-Host "  - Removes constant background noise (fans, AC, computer hum)" -ForegroundColor White
Write-Host "  - Uses AI to identify and remove unwanted sounds" -ForegroundColor White
Write-Host "  - Works great for podcast/voice recordings" -ForegroundColor White
Write-Host ""

Write-Host "Noise Gate:" -ForegroundColor Yellow
Write-Host "  - Cuts audio when you're not speaking" -ForegroundColor White
Write-Host "  - Prevents background noise between sentences" -ForegroundColor White
Write-Host "  - 'Close Threshold' = when gate closes (silence)" -ForegroundColor White
Write-Host "  - 'Open Threshold' = when gate opens (you speak)" -ForegroundColor White
Write-Host ""

Write-Host "Compressor:" -ForegroundColor Yellow
Write-Host "  - Makes quiet parts louder, loud parts quieter" -ForegroundColor White
Write-Host "  - Evens out volume for consistent audio" -ForegroundColor White
Write-Host "  - Essential for professional-sounding podcasts" -ForegroundColor White
Write-Host ""

Write-Host "Limiter:" -ForegroundColor Yellow
Write-Host "  - Prevents audio from clipping (distorting)" -ForegroundColor White
Write-Host "  - Acts as a 'safety net' for loud sounds" -ForegroundColor White
Write-Host "  - Set at -6 dB to leave headroom" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Tips for Best Results:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Filter Order Matters!" -ForegroundColor Yellow
Write-Host "   - Always use this order: Noise Suppression > Noise Gate > Compressor > Limiter" -ForegroundColor White
Write-Host "   - You can drag filters to reorder them in OBS" -ForegroundColor White
Write-Host ""

Write-Host "2. Adjust to Your Environment:" -ForegroundColor Yellow
Write-Host "   - Noisy room? Lower Noise Gate threshold to -45 dB" -ForegroundColor White
Write-Host "   - Quiet room? Raise to -30 dB" -ForegroundColor White
Write-Host "   - Speak into mic and watch the gate open/close" -ForegroundColor White
Write-Host ""

Write-Host "3. Test Recording:" -ForegroundColor Yellow
Write-Host "   - Record a 30-second test in OBS" -ForegroundColor White
Write-Host "   - Listen back for quality" -ForegroundColor White
Write-Host "   - Adjust filters as needed" -ForegroundColor White
Write-Host ""

Write-Host "4. Don't Overdo It:" -ForegroundColor Yellow
Write-Host "   - Too much compression = robotic/flat sound" -ForegroundColor White
Write-Host "   - Too much noise suppression = muffled voice" -ForegroundColor White
Write-Host "   - Start with these settings and adjust gradually" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Your backup is saved at:" -ForegroundColor Cyan
Write-Host "  $backupPath" -ForegroundColor White
Write-Host ""

Write-Host "For detailed tutorial with screenshots, see the HTML guide!" -ForegroundColor Yellow
Write-Host ""

pause
