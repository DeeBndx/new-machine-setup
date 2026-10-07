param(
    [string[]]$PackageIds = @(
        'Microsoft.Office'
        'Microsoft.Outlook'
        'Microsoft.VisualStudio.2022.Community'
        'Git.Git'
        'Microsoft.VisualStudioCode'
        'Microsoft.SQLServerManagementStudio'
        'OpenJS.NodeJS.LTS'
        'SlackTechnologies.Slack'
        'Notion.Notion'
    )
)

# Check if Winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host 'Winget is not installed. Please install App Installer from Microsoft Store.'
    exit
}

foreach ($packageId in $PackageIds) {
    $appInstalled = winget list --id $packageId | Select-String -SimpleMatch $packageId
    if (-not $appInstalled) {
        Write-Host "Installing $packageId..."
        winget install --id $packageId --exact --silent
    } else {
        Write-Host "$packageId is already installed. Skipping."
    }
}
