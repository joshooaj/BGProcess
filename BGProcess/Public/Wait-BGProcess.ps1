function Wait-BGProcess {
    [CmdletBinding()]
    [OutputType([BGProcess])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [BGProcess[]]
        $Process,

        [Parameter()]
        [switch]
        $PassThru
    )

    process {
        foreach ($p in $Process) {
            while (-not $p.HasExited) {
                Start-Sleep -Milliseconds 100
            }
            if ($PassThru) {
                $p
            }
        }
    }
}
