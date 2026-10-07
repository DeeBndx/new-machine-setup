param(
    [string[]]$PackageIds = @(
        'Discord.Discord'
        'Valve.Steam'
        'GOG.Galaxy'
        'Spotify.Spotify'
        'Brave.Brave'
    )
)

function Wait-ForKey {
    Write-Host ''
    Write-Host 'Press any key to close this window...'
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

# Check for WinGet, then try to register or install it if it is unavailable
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host 'WinGet was not found. Attempting to install it automatically...'
    try {
        if (Get-Command Add-AppxPackage -ErrorAction SilentlyContinue) {
            try {
                Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -ErrorAction Stop
            } catch {
                Write-Host 'App Installer registration was unavailable; attempting the WinGet package-manager bootstrap.'
            }
        }

        if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
            [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser -ErrorAction Stop | Out-Null
            Install-Module -Name Microsoft.WinGet.Client -Repository PSGallery -Scope CurrentUser -Force -ErrorAction Stop
            Import-Module Microsoft.WinGet.Client -Force -ErrorAction Stop
            Repair-WinGetPackageManager -ErrorAction Stop
        }
    } catch {
        Write-Warning "Automatic WinGet installation failed: $($_.Exception.Message)"
    }

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Error 'WinGet is still unavailable. No packages were installed.'
        Write-Host 'Installation summary: no packages were installed because WinGet could not be installed.'
        Wait-ForKey
        exit 1
    }
}

$installedPackages = @()
$alreadyInstalledPackages = @()
$failedPackages = @()

foreach ($packageId in $PackageIds) {
    $appInstalled = winget list --id $packageId | Select-String -SimpleMatch $packageId
    if (-not $appInstalled) {
        Write-Host "Installing $packageId..."
        winget install --id $packageId --exact --silent
        if ($LASTEXITCODE -eq 0) {
            $installedPackages += $packageId
        } else {
            Write-Warning "Failed to install $packageId (winget exit code: $LASTEXITCODE)."
            $failedPackages += $packageId
        }
    } else {
        Write-Host "$packageId is already installed. Skipping."
        $alreadyInstalledPackages += $packageId
    }
}

Write-Host ''
Write-Host 'Installation summary:'
Write-Host 'Installed during this run:'
if ($installedPackages.Count -gt 0) {
    $installedPackages | ForEach-Object { Write-Host "  $_" }
} else {
    Write-Host '  None'
}

if ($alreadyInstalledPackages.Count -gt 0) {
    Write-Host 'Already installed (skipped):'
    $alreadyInstalledPackages | ForEach-Object { Write-Host "  $_" }
}

if ($failedPackages.Count -gt 0) {
    Write-Host 'Failed:'
    $failedPackages | ForEach-Object { Write-Host "  $_" }
}

Wait-ForKey
if ($failedPackages.Count -gt 0) {
    exit 1
}
