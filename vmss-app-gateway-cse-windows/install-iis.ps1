# Install IIS
Add-WindowsFeature Web-Server

# Add homepage
Add-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value $($env:computername)