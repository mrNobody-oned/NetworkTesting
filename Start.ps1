# ASCII Art and Company Information at the top
Write-Host "
 _     _       _ _       _     
| |   | |     | (_)     | |    
| |   | |____ | |_ ____ | |  _ 
| |   | |  _ \| | |  _ \| | / )
| |___| | | | | | | | | | |< ( 
 \______| ||_/|_|_|_| |_|_| \_)
        |_|                    
Integrated Solution Inc (c) 20212-2024
" -ForegroundColor Green

Start-Sleep -Seconds 2  # Add a brief pause for effect

# Display the Network Testing Tool label and version
Write-Host "`nNetwork Testing Tool v0.1" -ForegroundColor Green

# Menu options
$menu = @(
    "1. Run WiFi Test",
    "2. Run Bandwidth Test (Flood Test)",
    "3. Exit"
)

# Show the menu
function Show-Menu {
    Write-Host "`nSelect an option:"
    foreach ($item in $menu) {
        Write-Host $item
    }
}

# Function to run WiFi Test (wifitest_v1.ps1)
function Run-WiFiTest {
    # Path to wifitest_v1.ps1 in the same directory as the script
    $wifiTestScript = Join-Path -Path $scriptDir -ChildPath "wifitest_v1.ps1"
    
    Write-Host "Running WiFi Test..."
    # Run the WiFi Test script
    & $wifiTestScript
}

# Function to run Continuous Bandwidth Test (BandwidthTest.ps1)
function Run-BandwidthTest {
    # Path to BandwidthTest.ps1 in the same directory as the script
    $bandwidthTestScript = Join-Path -Path $scriptDir -ChildPath "BandwidthTest.ps1"
    
    Write-Host "Running Continuous Bandwidth Test..."
    # Run the Bandwidth Test script
    & $bandwidthTestScript
}

# Get the script directory (where this PowerShell script is located)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        "1" { Run-WiFiTest }
        "2" { Run-BandwidthTest }
        "3" { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid option, please try again." }
    }
    Start-Sleep -Seconds 2
} while ($choice -ne "3")
