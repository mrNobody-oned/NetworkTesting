# Network Testing Tool

This tool is designed to help with network testing, including Wi-Fi information gathering, ping testing, and bandwidth testing using iPerf3. It provides a simple, command-line interface for the user to select and run various tests.

---

## Prerequisites

1. **PowerShell**: This script requires PowerShell to run. It is available on most Windows operating systems.
2. **iPerf3**: This tool is used for the bandwidth testing feature. It should be in the same folder as the script for the tool to function correctly.

---

## Files Included

- `WiFiTest_v1.ps1` – PowerShell script for running the Wi-Fi test.
- `BandwidthTest.ps1` – PowerShell script for running the continuous bandwidth test.
- `start.ps1` – Main script to select and run tests.
- `run_start_script.bat` – Batch file to easily run `start.ps1` by double-clicking.

---

## Setup Instructions

1. **Download and Extract**: Download or extract the folder containing all the scripts and tools to a location on your computer (e.g., `C:\NetworkTesting`).

2. **Ensure iPerf3 is in the Same Folder**: Make sure that the `iperf3.exe` file is in the same directory as the scripts. This file is required for the bandwidth testing.

3. **Execution Policy**: The script is set to bypass the PowerShell execution policy, but if you encounter any permission issues, you may need to change the PowerShell execution policy to allow script running:

    Open PowerShell as Administrator and run the following command:
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    ```

---

## How to Use

### Option 1: Running the Script with Batch File

1. **Double-click** on `run_start_script.bat`.
2. A PowerShell window will open and display the following menu:

    ```
    _     _       _ _       _
    | |   | |     | (_)     | |
    | |   | |____ | |_ ____ | |  _
    | |   | |  _ \| | |  _ \| | / )
    | |___| | | | | | | | | | |< (
     \______| ||_/|_|_|_| |_|_| \_)
            |_|
    Integrated Solution Inc (c) 20212-2024


    Network Testing Tool v0.1

    Select an option:
    1. Run WiFi Test
    2. Run Continuous Bandwidth Test
    3. Exit

    Enter your choice:
    ```

3. **Select an option**:
    - **Option 1**: Run Wi-Fi Test – This option will gather and display the Wi-Fi network details (SSID, BSSID, Signal Strength, Technology, IP Address, Gateway, DNS) and perform a ping test.
    - **Option 2**: Run Continuous Bandwidth Test – This option will run a continuous bandwidth test using iPerf3 and display the results.
    - **Option 3**: Exit – Exit the application.

4. **Follow the prompts**: Enter the IP address or hostname for the ping and iPerf3 tests as prompted.

### Option 2: Running the PowerShell Script Directly

1. **Open PowerShell**: Navigate to the folder where the scripts are saved.
2. Run the `start.ps1` script using the following command:
    ```powershell
    .\start.ps1
    ```
3. Follow the same menu and prompts as above.

---

## Output

- **Wi-Fi Test**: The Wi-Fi information and ping test results will be displayed in the PowerShell window and saved to a text file named `Network_Test_Result.txt` in a timestamped folder within the `D:\User Files\Music\WiFiTest\NetworkTestResult` directory.
- **Bandwidth Test**: The bandwidth test results will also be displayed in the PowerShell window and saved to the same text file.

---

## Notes

- **Permissions**: If you run into permission issues when executing the script, make sure that you have the necessary permissions or adjust the execution policy as described above.
- **iPerf3**: Ensure that `iperf3.exe` is in the same folder as the script files, as it is required for the bandwidth testing feature.

---

## Contact

For any issues or feature requests, please contact:

**UPLINK Integrated Solution Inc.**  
Website: www.uplinkph.net 
Email: technical@uplinkph.net
