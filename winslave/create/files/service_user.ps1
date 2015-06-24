try {
  $right = Carbon\Test-Privilege -Identity $($args[0]) -Privilege SeServiceLogonRight
  if (-not $right) {
    Carbon\Grant-Privilege -Identity $($args[0]) -Privilege SeServiceLogonRight
    echo "Changed"
  }
} catch [System.Exception] {
  echo "Error"
  exit 1
}
