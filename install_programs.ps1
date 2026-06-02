# Check if Winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host 'Winget is not installed. Please install App Installer from Microsoft Store.'
    exit
}

# Install Microsoft Office if not already installed
$appInstalled = winget list --id Microsoft.Office | Select-String 'Microsoft.Office'
if (-not $appInstalled) {
    Write-Host 'Installing Microsoft Office...'
    winget install --id Microsoft.Office --exact --silent
} else {
    Write-Host 'Microsoft Office is already installed. Skipping.'
}

# Install Microsoft Outlook if not already installed
$appInstalled = winget list --id Microsoft.Outlook | Select-String 'Microsoft.Outlook'
if (-not $appInstalled) {
    Write-Host 'Installing Microsoft Outlook...'
    winget install --id Microsoft.Outlook --exact --silent
} else {
    Write-Host 'Microsoft Outlook is already installed. Skipping.'
}

# Install Visual Studio if not already installed
$appInstalled = winget list --id Microsoft.VisualStudio.2022.Community | Select-String 'Microsoft.VisualStudio.2022.Community'
if (-not $appInstalled) {
    Write-Host 'Installing Visual Studio...'
    winget install --id Microsoft.VisualStudio.2022.Community --exact --silent
} else {
    Write-Host 'Visual Studio is already installed. Skipping.'
}

# Install Git if not already installed
$appInstalled = winget list --id Git.Git | Select-String 'Git.Git'
if (-not $appInstalled) {
    Write-Host 'Installing Git...'
    winget install --id Git.Git --exact --silent
} else {
    Write-Host 'Git is already installed. Skipping.'
}

# Install Visual Studio Code if not already installed
$appInstalled = winget list --id Microsoft.VisualStudioCode | Select-String 'Microsoft.VisualStudioCode'
if (-not $appInstalled) {
    Write-Host 'Installing Visual Studio Code...'
    winget install --id Microsoft.VisualStudioCode --exact --silent
} else {
    Write-Host 'Visual Studio Code is already installed. Skipping.'
}

# Install SQL Server Management Studio if not already installed
$appInstalled = winget list --id Microsoft.SQLServerManagementStudio | Select-String 'Microsoft.SQLServerManagementStudio'
if (-not $appInstalled) {
    Write-Host 'Installing SQL Server Management Studio...'
    winget install --id Microsoft.SQLServerManagementStudio --exact --silent
} else {
    Write-Host 'SQL Server Management Studio is already installed. Skipping.'
}

# Install Node.js LTS if not already installed
$appInstalled = winget list --id OpenJS.NodeJS.LTS | Select-String 'OpenJS.NodeJS.LTS'
if (-not $appInstalled) {
    Write-Host 'Installing Node.js LTS...'
    winget install --id OpenJS.NodeJS.LTS --exact --silent
} else {
    Write-Host 'Node.js LTS is already installed. Skipping.'
}

# Install Slack if not already installed
$appInstalled = winget list --id SlackTechnologies.Slack | Select-String 'SlackTechnologies.Slack'
if (-not $appInstalled) {
    Write-Host 'Installing Slack...'
    winget install --id SlackTechnologies.Slack --exact --silent
} else {
    Write-Host 'Slack is already installed. Skipping.'
}

# Install Notion if not already installed
$appInstalled = winget list --id Notion.Notion | Select-String 'Notion.Notion'
if (-not $appInstalled) {
    Write-Host 'Installing Notion...'
    winget install --id Notion.Notion --exact --silent
} else {
    Write-Host 'Notion is already installed. Skipping.'
}
