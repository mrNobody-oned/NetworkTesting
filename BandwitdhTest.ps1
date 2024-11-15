# Define the path to the iperf3 executable
$iperf3Path = "D:\User Files\Music\WiFiTest_V2\iperf3.exe"

# Ask for the IP address for the iperf3 test
$iperfTarget = Read-Host "Enter the IP address for the iperf3 test (default: 192.168.1.11)"
if ([string]::IsNullOrWhiteSpace($iperfTarget)) {
    $iperfTarget = "192.168.1.11"  # Default value
}

# Inform the user that the test is starting
Write-Host "Starting continuous iperf3 test to $iperfTarget..."

# Run iperf3 continuously with the -t 0 flag for indefinite testing
& $iperf3Path -c $iperfTarget -t 0

Write-Host "Network test stopped."
# Define the path to the iperf3 executable
$iperf3Path = "D:\User Files\Music\WiFiTest_V2\iperf3.exe"

# Ask for the IP address for the iperf3 test
$iperfTarget = Read-Host "Enter the IP address for the iperf3 test (default: 192.168.1.11)"
if ([string]::IsNullOrWhiteSpace($iperfTarget)) {
    $iperfTarget = "192.168.1.11"  # Default value
}

# Inform the user that the test is starting
Write-Host "Starting continuous iperf3 test to $iperfTarget..."

# Run iperf3 continuously with the -t 0 flag for indefinite testing
& $iperf3Path -c $iperfTarget -t 0

Write-Host "Network test stopped."
