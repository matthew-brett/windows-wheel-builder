# Install Python 3.6.2
if ($env:PYTHON -eq "C:\Python362-x64") {
    $exe_suffix="-amd64"
    $install_suffix="-x64"
} elseif ($env:PYTHON -eq "C:\Python362") {
    $exe_suffix=""
    $install_suffix=""
} else {
    exit 0
}

Write-Host "Installing Python 3.6.2$exe_suffix..." -ForegroundColor Cyan
$exePath = "$env:TEMP\python-3.6.2${exe_suffix}.exe"
$downloadFile = "https://www.python.org/ftp/python/3.6.2/python-3.6.2${exe_suffix}.exe"
Write-Host "Downloading $downloadFile..."
(New-Object Net.WebClient).DownloadFile($downloadFile, $exePath)
Write-Host "Installing..."
cmd /c start /wait $exePath /quiet TargetDir="C:\Python362$install_suffix$" Shortcuts=0 Include_launcher=0 InstallLauncherAllUsers=0
Write-Host "Python 3.6.2${install_suffix} installed"

c:\Python36${install_suffix}\Python.exe --version