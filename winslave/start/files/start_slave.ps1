$python = Get-Process python -ErrorAction SilentlyContinue
if ($python -eq $null) {
  Start-Process C:\tools\python2\Scripts\buildslave.bat start -NoNewWindow -WorkingDirectory "$($args[0])" -RedirectStandardOutput "c:\tools\SlaveOutput.txt" -RedirectStandardError "c:\tools\SlaveError.txt"
  echo "Started"
}
