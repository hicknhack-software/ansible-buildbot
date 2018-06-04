
# Redirect stderr to stdout, so ansible won't consider a warning about an old pip version as failure
pip install buildbot-worker==1.1.0 --upgrade --no-binary buildbot-worker 2>&1

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
