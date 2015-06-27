$python = Get-Process python -ErrorAction SilentlyContinue
if ($python -eq $null) {
  Start-Process 'buildslave.bat' start -NoNewWindow -WorkingDirectory "$($args[0])" -RedirectStandardOutput "$($args[0])\SlaveOutput.txt" -RedirectStandardError "$($args[0])\SlaveError.txt"
  echo "Started"
}
