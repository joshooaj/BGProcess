---
external help file: BGProcess-help.xml
Module Name: BGProcess
online version: https://www.joshooaj.com/BGProcess/Functions/Start-BGProcess/
schema: 2.0.0
---

# Start-BGProcess

## SYNOPSIS
Starts a new windowless process with redirected input/output streams.

## SYNTAX

```
Start-BGProcess [-FileName] <String> [[-Arguments] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a new windowless process with redirected input/output streams. This is
useful for driving an interactive command-line application from code.

The Read-BGProcess and Write-BGProcess cmdlets offer a simplified method of
responding to interactive command-line prompts such as the netsh or nslookup
prompt for instance.

Note that while almost all functionality in netsh and nslookup can be accessed
without entering their interactive prompts, not all command-line tools are as
automation-friendly. They are used as examples only out of familiarity and
because they are broadly available for testing.

## EXAMPLES

### Example 1
```powershell
$nslookup = Start-BGProcess nslookup
$nslookup | Read-BGProcess -Wait -MapErrorsToStdOut
$nslookup | Write-BGProcess "www.powershellgallery.com" -PassThru | Read-BGProcess -Wait -Timeout (New-TimeSpan -Seconds 3) -MapErrorsToStdOut
$nslookup | Write-BGProcess "exit" | Wait-BGProcess
$nslookup | Format-List

<#
Process   : System.Diagnostics.Process (nslookup)
Id        : 24028
Name      : nslookup
ExitCode  : 0
HasExited : True
#>
```

Starts an nslookup.exe process without arguments which places you into an
interactive nslookup prompt. The initial StandardOutput text is retrieved, and
then we write "www.powershellgallery.com" to the StandardInput stream. An
Environment.NewLine is appended to the text by default.

The response is read from StandardOutput with a timeout value of 3 seconds since
the response is not expected to be immediate. Finally, we write "exit" to the
StandardInput stream and wait for the process to exit before showing the
$nslookup object contents.

## PARAMETERS

### -Arguments
Specifies one or more optional command-line arguments.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
Specifies the file name of the application to run.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Path

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### BGProcess

## NOTES

## RELATED LINKS

[Online Help](https://www.joshooaj.com/BGProcess/Functions/Start-BGProcess/)
