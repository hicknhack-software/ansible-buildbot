function AddPath($folder) {
    if ($Env:Path | Select-String -SimpleMatch $folder) { return }
    $Env:Path += ';' + $folder
    Set-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name 'PATH' -Value $Env:Path
}
function Expand7z($archive, $target) {
    &7z.exe x -y $archive "-o$target"
    if ($LastExitCode) { throw "7z.exe failed on archive: $archive" }
}
function CheckRemoveDir($path) {
    if (Test-Path $path) { Remove-Item -Recurse -Force $path }
}
function Which([string]$cmd) {
    Get-Command -ErrorAction "SilentlyContinue" $cmd | Select -ExpandProperty Definition
}
function ReplaceMove($src, $dest) {
    $file = Join-Path $dest (Split-Path -Path $src -Leaf)
    if (Test-Path $file) { Remove-Item -Recurse -Force $file }
    Move-Item -Path $src.FullName -Destination $dest
}

$localPython = Which "python.exe"
if ("$localPython" -eq "") {
    Write-Output "Default Python"
    $localPython = "C:\tools\python2\python.exe"
}
if (!(Test-Path $localPython)) {
    Write-Output "Missing Python!"
    Exit -1
}
#Write-Output $localPython

$pyHome = Split-Path $localPython -Parent
$Env:PYTHONHOME = $pyHome
AddPath(Join-Path $pyHome "Scripts")

$sitePackages = (Join-Path (Join-Path $pyHome 'Lib') 'site-packages')
if (!(Test-Path $sitePackages)) {
    Write-Output "No site-packages"
    Exit -1
}

$simpleVersion = $(&$localPython --version 2>&1) | Select-String -Pattern '^.*\s+(\d\.\d)(\.\d+){0,1}$' | % { $_.Matches.Groups[1].Value }
$build = 223
$arch = $Env:PROCESSOR_ARCHITECTURE.ToLower()

if ((Test-Path "C:\Windows\system32\pywintypes*.dll") -and (Test-Path(Join-Path $sitePackages "pywin32-$build-py$simpleVersion.egg-info"))) {
    Write-Output "Already present"
    Exit 0
}

if (!(Test-Path (Which "7z.exe"))) {
    Write-Output "Missing 7z.exe"
    Exit -1
}

if ($arch -ne "amd64") { $arch = "32" } else { $arch = "-" + $arch }
$url = "https://github.com/mhammond/pywin32/releases/download/b$build/pywin32-$build.win$arch-py$simpleVersion.exe"

$dest = Join-Path $Env:Temp "pywin32-$build.$simpleVersion.exe"
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    (new-object System.Net.WebClient).DownloadFile($url, $dest)
} catch {
    throw "Download failed: $url with ${_}"
}

$xTemp = Join-Path $Env:Temp 'pywin32-temp1'
Expand7z $dest $xTemp
Remove-Item -Force $dest

'PLATLIB', 'SCRIPTS' | % { Join-Path $xTemp $_ } | Get-ChildItem | % { ReplaceMove $_ $sitePackages }

Push-Location $sitePackages
&$localPython pywin32_postinstall.py -install
if ($LastExitCode) { throw "pywin32_postinstall failed" }
Remove-Item .\pywin32_postinstall.py
Pop-Location

CheckRemoveDir $xTemp

Write-Output 'Installed Successful'
exit 0
