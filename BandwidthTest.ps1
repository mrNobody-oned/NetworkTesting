# Get the directory where the script is located
$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Path

# Build the path to iperf3.exe relative to the script's directory
$iperf3Path = Join-Path -Path $scriptDirectory -ChildPath "iperf3.exe"

# Check if the iperf3.exe exists at the determined path
if (-not (Test-Path -Path $iperf3Path)) {
    Write-Host "Error: iperf3.exe not found at $iperf3Path" -ForegroundColor Red
    exit
}

# Ask for the IP address for the iperf3 test
$iperfTarget = Read-Host "Enter the IP address for the iperf3 test (default: Firewall [192.168.100.1])"
if ([string]::IsNullOrWhiteSpace($iperfTarget)) {
    $iperfTarget = "192.168.100.1"  # Default value
}

# Set console background to black and text color to blue
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Blue"
Clear-Host  # Clear the console to apply the colors

# Inform the user that the test is starting
Write-Host "Starting continuous iperf3 test to $iperfTarget..." -ForegroundColor Blue -BackgroundColor Black

# Open a new PowerShell window to run the iperf3 test
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "& '$iperf3Path' -c $iperfTarget -t 0"

# Keep the main terminal open
Write-Host "Sub-Terminal is open for floodtest" -ForegroundColor Yellow -BackgroundColor Black
