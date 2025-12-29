# PowerShell Dotfiles Setup Script

Write-Host "Setting up dotfiles..." -ForegroundColor Cyan

# Get the directory where this script is located
$dotfilesDir = $PSScriptRoot

# PowerShell Profile
$profileSource = Join-Path $dotfilesDir "Microsoft.PowerShell_profile.ps1"
$profileTarget = $PROFILE

Write-Host "`nSetting up PowerShell profile..." -ForegroundColor Yellow

# Create profile directory if it doesn't exist
$profileDir = Split-Path $profileTarget
if (!(Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "Created profile directory: $profileDir" -ForegroundColor Green
}

# Remove existing profile if it exists (to replace with symlink)
if (Test-Path $profileTarget) {
    Write-Host "Backing up existing profile to ${profileTarget}.backup" -ForegroundColor Yellow
    Move-Item $profileTarget "${profileTarget}.backup" -Force
}

# Create symbolic link
try {
    New-Item -ItemType SymbolicLink -Path $profileTarget -Target $profileSource -Force | Out-Null
    Write-Host "Created symlink: $profileTarget -> $profileSource" -ForegroundColor Green
} catch {
    Write-Host "Failed to create symlink. Copying file instead..." -ForegroundColor Red
    Copy-Item $profileSource $profileTarget -Force
    Write-Host "Copied: $profileSource -> $profileTarget" -ForegroundColor Green
}

Write-Host "`nSetup complete! Restart PowerShell for changes to take effect." -ForegroundColor Cyan