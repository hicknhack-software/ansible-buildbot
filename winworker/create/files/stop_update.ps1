
function KillProcess($name, $minCpu = 0, $commandLine = $null) {
  Get-Process -Name $name -ErrorAction SilentlyContinue | Where-Object {
    $proc = $_
    if ($minCpu -gt 0 -and $proc.CPU -lt $minCpu) {
      return
    }
    if ($commandLine -ne $null) {
      $wmi = Get-WmiObject win32_process -Filter "ProcessId = $($proc.Id)"
      if ($wmi -ne $null -and $wmi.commandLine -notmatch $commandLine) {
        return
      }
    }
    $proc.Kill()
    $proc.WaitForExit()
    Write-Output "Killed " + $name
  }
}

KillProcess -Name "TiWorker" -CPU 10
KillProcess -Name "RunDll32" -CPU 10 -CommandLine "aepdu.dll,AePduRunUpdate"
Exit 0
