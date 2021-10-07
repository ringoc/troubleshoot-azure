Param(
    [string]$dotnetInstallDir = 'C:\dotnet'
    # [string]$dotnetVersion = 'Latest',
    # [string]$dotnetChannel = 'Current'
)

# Set system path to dotnet installation
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$dotnetInstallDir", [EnvironmentVariableTarget]::Machine);


# Force use of TLS12 to download script
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

# House-keeping
mkdir $dotnetInstallDir

# Enabling DotNet3.5
Write-Host "Enabling DotNet3.5"
Add-WindowsCapability -Online -Name NetFx3~~~~

# Ensure DotNet3.5 is installed
Get-WindowsCapability -Online -Name NetFx3~~~~ | Out-File output.txt