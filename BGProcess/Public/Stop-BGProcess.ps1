function Stop-BGProcess {
    [CmdletBinding(SupportsShouldProcess)]
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
            if ($PSCmdlet.ShouldProcess(("{0} ({1})" -f $p.Process.Name, $p.Id), "Stop-BGProcess")) {
                $p.process | Stop-Process
                if ($PassThru) {
                    $p
                }
            }
        }
    }
}
