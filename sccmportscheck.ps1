# Define the list of ports to check
$ports = 80, 443, 135, 445

# Read the list of devices from the text file
$devices = Get-Content -Path 'C:\devices.txt'

# Initialize the log file
$logFile = 'C:\port_check_log.txt'
if (Test-Path -Path $logFile) {
    Clear-Content -Path $logFile
}

# Check each device
foreach ($device in $devices) {
    # Check each port
    foreach ($port in $ports) {
        # Use the Test-NetConnection cmdlet to check the port
        $result = Test-NetConnection -ComputerName $device -Port $port

        # Log the result
        if ($result.TcpTestSucceeded) {
            Add-Content -Path $logFile -Value "Device ${device}, Port ${port}: Open"
        } else {
            Add-Content -Path $logFile -Value "Device ${device}, Port ${port}: Closed"
        }
    }
}
