# Add .NET assembly for ZIP functionality if not available by default
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Ignore SSL certificate validation
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Define the URL and file paths
$url = "https://github.com/grafana/alloy/releases/latest/download/alloy-installer-windows-amd64.exe.zip"
$downloadFolder = "C:\AlloyInstaller"
$zipPath = Join-Path -Path $downloadFolder -ChildPath "alloy-installer-windows-amd64.exe.zip"
$exePath = Join-Path -Path $downloadFolder -ChildPath "alloy-installer-windows-amd64.exe"

# Create the download folder if it doesn't exist
if (-not (Test-Path -Path $downloadFolder)) {
    New-Item -Path $downloadFolder -ItemType Directory
}

# Download the ZIP file
try {
    Invoke-WebRequest -Uri $url -OutFile $zipPath
} catch {
    Write-Error "Failed to download the file: $_"
    Exit 1
}

# Extract the ZIP file using .NET assembly
try {
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $downloadFolder)
} catch {
    Write-Error "Failed to extract the file: $_"
    Exit 1
}

# Run the installer in silent mode
try {
    Start-Process -FilePath $exePath -ArgumentList "/S" -Wait -NoNewWindow
} catch {
    Write-Error "Installation failed: $_"
    Exit 1
}

# Clean up: remove the downloaded ZIP and extracted EXE files
try {
    Remove-Item -Path $zipPath
    Remove-Item -Path $exePath
    Remove-Item -Path $downloadFolder -Force -Recurse
} catch {
    Write-Error "Cleanup failed: $_"
    Exit 1
}
