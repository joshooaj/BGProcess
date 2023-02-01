if ($PSVersionTable.PSVersion -ge '7.0') {
    & "$PSScriptRoot\build.ps1" build
}

Import-Module "$PSScriptRoot\Output\BGProcess\0.1.0\BGProcess.psd1" -Force


$p = Start-BGProcess nslookup
$p | Read-BGProcess -MapErrorsToStdOut -Wait -Timeout (New-TimeSpan -Seconds 3)
$p | Write-BGProcess -Text "www.google.com" -Passthru | Read-BGProcess -MapErrorsToStdOut -Wait -Timeout (New-TimeSpan -Seconds 3)
$p | Write-BGProcess -Text "exit" | Wait-BGProcess


