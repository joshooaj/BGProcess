function Start-BGProcess {
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([BGProcess])]
    param(
        [Parameter(Mandatory, Position = 0)]
        [Alias('Path')]
        [string]
        $FileName,

        [Parameter(ValueFromRemainingArguments, Position = 1)]
        [string[]]
        $Arguments
    )

    process {
        try {
            $startInfo = [System.Diagnostics.ProcessStartInfo]@{
                FileName               = $FileName
                Arguments              = $Arguments -join ' '
                CreateNoWindow         = $true
                RedirectStandardInput  = $true
                RedirectStandardOutput = $true
                RedirectStandardError  = $true
                UseShellExecute        = $false
            }
            if ($PSCmdlet.ShouldProcess($FileName, "Start process with arguments: $($startInfo.Arguments)")) {
                $p = [System.Diagnostics.Process]::Start($startInfo)
                $p.EnableRaisingEvents = $true
                [BGProcess]::new($p)
            }
        } catch {
            throw
        }
    }
}
