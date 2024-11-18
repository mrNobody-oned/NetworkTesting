# Set console background to black and text color to green
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host  # Clear the console to apply the background color

# Display ASCII Art and Company Information
Write-Host "
 _     _       _ _       _     
| |   | |     | (_)     | |    
| |   | |____ | |_ ____ | |  _ 
| |   | |  _ \| | |  _ \| | / )
| |___| | | | | | | | | | |< ( 
 \______| ||_/|_|_|_| |_|_| \_)
        |_|                    
Integrated Solution Inc (c) 2021-2024
" -ForegroundColor Green

Start-Sleep -Seconds 1  # Add a brief pause for effect

# Display the Network Testing Tool label and version
Write-Host "`nNetwork Testing" -ForegroundColor Green

# Get the current time and format it as YYYY-MM-DD_HH-MM-SS for folder name
$currentTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Dynamically determine the base folder path relative to the script's location
$scriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition
$baseFolderPath = Join-Path -Path $scriptDirectory -ChildPath "WiFiTest\NetworkTestResult"

# Create the NetworkTesting folder if it doesn't exist
if (-not (Test-Path -Path $baseFolderPath)) {
    New-Item -Path $baseFolderPath -ItemType Directory | Out-Null  # Suppress output
}

# Define the timestamped folder path
$timestampFolderPath = Join-Path -Path $baseFolderPath -ChildPath $currentTime

# Create the timestamped folder
New-Item -Path $timestampFolderPath -ItemType Directory | Out-Null  # Suppress output

# Define output file path
$outputFile = Join-Path -Path $timestampFolderPath -ChildPath "Network_Test_Result.txt"

# Clear previous output file content if exists
Clear-Content -Path $outputFile -ErrorAction SilentlyContinue

# Function to handle errors and pause execution
function Handle-Error {
    param ($errorMessage)
    Write-Host "Error: $errorMessage" -ForegroundColor Red
    Read-Host -Prompt "Press Enter to continue after fixing the issue"
}

# Prompt for ping target and iPerf3 target IP
$pingTarget = Read-Host -Prompt "Enter the IP or hostname to ping (default: google.com)"
if ([string]::IsNullOrEmpty($pingTarget)) {
    $pingTarget = "google.com"
}

$iperfTarget = Read-Host -Prompt "Enter the IP address for Bandwidth test (default: 192.168.100.1 [Firewall])"
if ([string]::IsNullOrEmpty($iperfTarget)) {
    $iperfTarget = "192.168.100.1"
}

# Gathering Wi-Fi Information
try {
    $wifiInfo = netsh wlan show interfaces
    if ($wifiInfo -eq $null) {
        throw "Unable to gather Wi-Fi information."
    }

    $ssid = ($wifiInfo | Select-String "SSID" | ForEach-Object { $_.Line -replace "SSID\s*:\s*", "" }).Trim()
    $bssid = ($wifiInfo | Select-String "BSSID" | ForEach-Object { $_.Line -replace "BSSID\s*:\s*", "" }).Trim()
    $signalStrength = ($wifiInfo | Select-String "Signal" | ForEach-Object { $_.Line -replace "Signal\s*:\s*", "" }).Trim()
    $technology = ($wifiInfo | Select-String "Radio type" | ForEach-Object { $_.Line -replace "Radio type\s*:\s*", "" }).Trim()

    # Gather IP, Gateway, and IPv4 DNS information
    $networkConfig = Get-NetIPConfiguration
    $ipAddress = ($networkConfig.IPv4Address | Select-Object -First 1).IPAddress
    $gateway = ($networkConfig.IPv4DefaultGateway | Select-Object -First 1).NextHop
    $dnsServers = ($networkConfig.DNSServer | ForEach-Object { $_.ServerAddresses } | Where-Object { $_ -match "^\d{1,3}(\.\d{1,3}){3}$" }) -join ", "

    # Display the Wi-Fi information in the console and add to the text file
    $wifiInfoText = @"
=========================================WIRELESS NETWORK TESTING===============================================
DATE & TIME: $currentTime

************** WI-FI INFORMATION *****************
SSID Name: $ssid
BSSID: $bssid
Signal Strength: $signalStrength
Technology: $technology
IP Address: $ipAddress
Gateway: $gateway
DNS Servers: $dnsServers
"@
    Write-Host $wifiInfoText
    Add-Content -Path $outputFile -Value $wifiInfoText
} catch {
    Handle-Error $_.Exception.Message
}

# Get Ping Result
try {
    $pingResult = Test-Connection -ComputerName $pingTarget -Count 4
    $pingStats = $pingResult | Select-Object Address, ResponseTime, Status

    # Format Ping Results text
    $pingInfoText = "******PING TEST to $pingTarget******`r`n"
    $pingInfoText += "Address: $($pingStats[0].Address)`r`nStatus: "

    foreach ($ping in $pingStats) {
        $pingInfoText += "`r`n    Response Time: $($ping.ResponseTime) ms Status: $($ping.Status)"
    }

    $pingInfoText += "`r`nAverage Response Time: $([math]::Round(($pingStats | Measure-Object -Property ResponseTime -Average).Average, 2)) ms`r`n"
    
    Write-Host $pingInfoText
    Add-Content -Path $outputFile -Value $pingInfoText
} catch {
    Handle-Error $_.Exception.Message
}

# Bandwidth Test using iPerf (iPerf3 located in the same folder as the script)
try {
    $iperfPath = Join-Path -Path $scriptDirectory -ChildPath "iperf3.exe"
    $iperfTestOutput = & $iperfPath -c $iperfTarget -t 10 -i 1 | Out-String

    if ($iperfTestOutput -eq $null) {
        throw "iPerf test did not return any results."
    }

    # Format iPerf output with line breaks and a header
    $iperfInfoText = @"
***************** BANDWIDTH TEST ******************
Connecting to host $iperfTarget, port 5201
$iperfTestOutput
"@

    Write-Host $iperfInfoText
    Add-Content -Path $outputFile -Value $iperfInfoText
} catch {
    Handle-Error $_.Exception.Message
}

# Speedtest CLI Test
try {
    $speedtestPath = "speedtest"  # Ensure 'speedtest' CLI is in PATH
    $speedtestOutput = & $speedtestPath | Out-String

    if ($speedtestOutput -eq $null) {
        throw "Speedtest did not return any results."
    }

    $speedtestInfoText = @"
***************** SPEED TEST ******************
$speedtestOutput
"@
    Write-Host $speedtestInfoText
    Add-Content -Path $outputFile -Value $speedtestInfoText
} catch {
    Handle-Error $_.Exception.Message
}

# Display final message
Write-Host "Network Information saved to $outputFile"
