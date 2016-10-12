pip install buildbot-worker==0.9.0.post1 --upgrade --no-binary buildbot-worker
$x = $LASTEXITCODE
if (0 -eq $x) {
  # reload paths
  $paths = 'Machine', 'User' |
    % {
      (Get-EnvironmentVariable -Name 'PATH' -Scope $_) -split ';'
    } |
    Select -Unique
  $Env:PATH = $paths -join ';'
}
exit $x
