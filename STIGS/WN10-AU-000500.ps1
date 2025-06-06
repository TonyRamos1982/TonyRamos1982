<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/TonyRamos1982
    GitHub          : github.com/TonyRamos1982
    Date Created    : 2025-05-16
    Last Modified   : 2024-05-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$desiredValue = 32768  # In KB

# Check if the registry path exists, create if not
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Output "Created registry path: $regPath"
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

# Set the value if missing or less than desired
if ($null -eq $currentValue -or $currentValue.$valueName -lt $desiredValue) {
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "Set $valueName to $desiredValue KB at $regPath"
} else {
    Write-Output "$valueName is already set to a secure value ($($currentValue.$valueName) KB). No changes made."
}
