# Install Python 3.6.2
Write-Host "Installing Python 3.6.2..." -ForegroundColor Cyan
Write-Host "Downloading..."
$exePath = "$env:TEMP\python-3.6.2.exe"
(New-Object Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.6.2/python-3.6.2.exe', $exePath)
Write-Host "Installing..."
cmd /c start /wait $exePath /quiet TargetDir=C:\Python362 Shortcuts=0 Include_launcher=0 InstallLauncherAllUsers=0
Write-Host "Python 3.6.2 x86 installed"

# Python 3.6.2 x64
Write-Host "Downloading..."
$exePath = "$env:TEMP\python-3.6.2-amd64.exe"
(New-Object Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.6.2/python-3.6.2-amd64.exe', $exePath)
Write-Host "Installing..."
cmd /c start /wait $exePath /quiet TargetDir=C:\Python362-x64 Shortcuts=0 Include_launcher=0 InstallLauncherAllUsers=0
Write-Host "Python 3.6.2 x64 installed"
