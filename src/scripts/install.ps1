# Write-Host "Downloading nodejs"
# Invoke-WebRequest https://nodejs.org/dist/v8.11.3/node-v8.11.3-x64.msi -OutFile $env:temp\node-install.msi
# Write-Host "Installing nodejs"
# cmd /c "start /wait msiexec.exe /i $env:temp\node-install.msi /l*vx $env:temp\MSI-node-install.log /qn ADDLOCAL=ALL"

# netcore 2.1, 2.2 and 3.0 (3.1 is already installed)
Write-Host "Downloading dotnet install script"
Invoke-WebRequest https://dot.net/v1/dotnet-install.ps1 -OutFile c:\scripts\dotnet-install.ps1;

Write-Host "Installing dotnet 2.1..."
c:\scripts\dotnet-install.ps1 -Channel 2.1 -InstallDir $env:ProgramFiles\dotnet; 
Write-Host "Installing dotnet 2.2..."
c:\scripts\dotnet-install.ps1 -Channel 2.2 -InstallDir $env:ProgramFiles\dotnet; 
Write-Host "Installing dotnet 3.0..."
c:\scripts\dotnet-install.ps1 -Channel 3.0 -InstallDir $env:ProgramFiles\dotnet; 
[Environment]::SetEnvironmentVariable('PATH', "$HOME\.dotnet\tools;$env:PATH", [EnvironmentVariableTarget]::Machine);
Remove-Item c:\scripts\dotnet-install.ps1

Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Installing Chocolatey: webdeply..."
choco install -y webdeploy
Write-Host "Installing Chocolatey: nuget..."
choco install -y nuget.commandline

Write-Host "Installing Azure Build/Release Agent"
choco install -y azure-pipelines-agent

Write-Host "Clearing out temp folder...."
Push-Location $env:temp;
Remove-Item $env:temp\* -Recurse -Force -ErrorAction SilentlyContinue;
Pop-Location
