$identity = $($args[0])

try {
  $right = Carbon\Test-Privilege -Identity ${identity} -Privilege SeServiceLogonRight
  if (-not $right) {
    Carbon\Grant-Privilege -Identity ${identity} -Privilege SeServiceLogonRight
    echo "Changed"
  }
} catch [System.Exception] {
  throw "Carbon\Test-Privilege failed: identity=${identity} with ${_}"
}
