# PowerShell Dotfiles Setup Script

Write-Host "Setting up dotfiles..." -ForegroundColor Cyan

# Get the directory where this script is located
$dotfilesDir = $PSScriptRoot

# Helper function to create symlink or copy as fallback
function New-ConfigLink {
    param(
        [string]$Source,
        [string]$Target,
        [string]$Name
    )
    
    Write-Host "`nSetting up $Name..." -ForegroundColor Yellow
    
    # Create directory if needed
    $targetDir = Split-Path $Target
    if (!(Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        Write-Host "Created directory: $targetDir" -ForegroundColor Green
    }
    
    # Backup existing file
    if (Test-Path $Target) {
        $backup = "${Target}.backup"
        Write-Host "Backing up existing file to $backup" -ForegroundColor Yellow
        Move-Item $Target $backup -Force
    }
    
    # Try to create symlink
    try {
        New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force -ErrorAction Stop | Out-Null
        Write-Host "Created symlink: $Target -> $Source" -ForegroundColor Green
    } catch {
        Write-Host "Failed to create symlink. Copying file instead..." -ForegroundColor Red
        Copy-Item $Source $Target -Force
        Write-Host "Copied: $Source -> $Target" -ForegroundColor Green
    }
}

# PowerShell Profile
$profileSource = Join-Path $dotfilesDir "Microsoft.PowerShell_profile.ps1"
New-ConfigLink -Source $profileSource -Target $PROFILE -Name "PowerShell Profile"

# VS Code Settings
$vscodeSettingsSource = Join-Path $dotfilesDir "vscode-settings.json"
$vscodeSettingsTarget = "$env:APPDATA\Code\User\settings.json"
New-ConfigLink -Source $vscodeSettingsSource -Target $vscodeSettingsTarget -Name "VS Code Settings"

# VS Code Keybindings
$vscodeKeybindingsSource = Join-Path $dotfilesDir "vscode-keybindings.json"
$vscodeKeybindingsTarget = "$env:APPDATA\Code\User\keybindings.json"
New-ConfigLink -Source $vscodeKeybindingsSource -Target $vscodeKeybindingsTarget -Name "VS Code Keybindings"

Write-Host "`nSetup complete! Restart PowerShell and VS Code for changes to take effect." -ForegroundColor Cyan