function Write-BGProcess {
    [CmdletBinding()]
    [OutputType([BGProcess])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [BGProcess]
        $Process,

        [Parameter(Mandatory, Position = 0)]
        [string]
        $Text,

        [Parameter()]
        [string]
        $LineTerminator = ([System.Environment]::NewLine),

        [Parameter()]
        [switch]
        $NoLineTerminator,

        [Parameter()]
        [switch]
        $PassThru
    )

    process {
        $Process.Write($Text)
        if (-not $NoLineTerminator) {
            $Process.Write($LineTerminator)
        }
        if ($Passthru) {
            $Process
        }
    }
}
