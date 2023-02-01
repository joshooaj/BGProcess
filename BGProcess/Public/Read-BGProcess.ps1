function Read-BGProcess {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [BGProcess]
        $Process,

        [Parameter()]
        [switch]
        $MapErrorsToStdOut,

        [Parameter()]
        [switch]
        $Wait,

        [Parameter()]
        [timespan]
        $Timeout = (New-TimeSpan -Seconds 1)
    )

    process {
        $stopwatch = [diagnostics.stopwatch]::StartNew()
        do {
            $data = $Process.Read()

            foreach ($record in $data.ErrorRecords) {
                $stopwatch.Restart()
                Write-Error -ErrorRecord $record
            }

            if (-not [string]::IsNullOrEmpty($data.StandardError)) {
                $stopwatch.Restart()
                if ($MapErrorsToStdOut) {
                    $data.StandardError
                } else {
                    Write-Error -Message $data.StandardError
                }
            }

            if (-not [string]::IsNullOrEmpty($data.StandardOutput)) {
                $stopwatch.Restart()
                $data.StandardOutput
            }

            if ($Wait -and $stopwatch.Elapsed -lt $Timeout) {
                Start-Sleep -Milliseconds 100
            }

        } while ($Wait -and $stopwatch.Elapsed -lt $Timeout)
    }
}
