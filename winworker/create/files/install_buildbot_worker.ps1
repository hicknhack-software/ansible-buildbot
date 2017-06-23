pip install buildbot-worker==0.9.8 --upgrade --no-binary buildbot-worker
$x = $LASTEXITCODE
if (0 -eq $x) {
  # reload paths
  $paths = 'Machine', 'User' |
    % {
      ( [environment]::GetEnvironmentVariable('PATH',$_) ) -split ';'
    } |
    Select -Unique
  $Env:PATH = $paths -join ';'
}
exit $x
