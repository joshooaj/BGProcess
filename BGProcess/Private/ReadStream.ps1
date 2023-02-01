function ReadStream {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNull()]
        [System.IO.Stream]
        $Stream,

        [Parameter(Position = 1)]
        [System.Text.Encoding]
        $Encoding = [System.Text.Encoding]::UTF8
    )

    process {
        $sb = [text.stringbuilder]::new()
        $buffer = [byte[]]::new(1KB)
        $read = 0
        do {
            $read = $Stream.Read($buffer, 0, $buffer.Length)
            if ($read -gt 0) {
                $null = $sb.Append($Encoding.GetString($buffer, 0, $read))
            }
        } while ($read -eq $buffer.Length)
        $sb.ToString()
    }
}
