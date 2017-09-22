# Install Python 3.6.2 over Python 3.6.1
# Install only if:
#    Our current matrix entry uses Python 3.6 AND
#    Python 3.6.1 is the current Python 3.6
if ("$(& $env:PYTHON\Python.exe --version)" -ne "Python 3.6.1") {
    exit 0
}
if ($env:PYTHON -eq "C:\Python36-x64") {
    $exe_suffix="-amd64"
} elseif ($env:PYTHON -eq "C:\Python36") {
    $exe_suffix=""
} else {
    exit 0
}

$py_url = "https://www.python.org/ftp/python"
Write-Host "Installing Python 3.6.2$exe_suffix..." -ForegroundColor Cyan
$exePath = "$env:TEMP\python-3.6.2${exe_suffix}.exe"
$downloadFile = "$py_url/3.6.2/python-3.6.2${exe_suffix}.exe"
Write-Host "Downloading $downloadFile..."
(New-Object Net.WebClient).DownloadFile($downloadFile, $exePath)
Write-Host "Installing..."
cmd /c start /wait $exePath /quiet TargetDir="$env:PYTHON" Shortcuts=0 Include_launcher=0 InstallLauncherAllUsers=0
Write-Host "Python 3.6.2 installed to $env:PYTHON"

echo "$(& $env:PYTHON\Python.exe --version)"
