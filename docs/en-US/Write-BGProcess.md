---
external help file: BGProcess-help.xml
Module Name: BGProcess
online version:
schema: 2.0.0
---

# Write-BGProcess

## SYNOPSIS
Writes the specified text to the StandardInput stream of the BGProcess.

## SYNTAX

```
Write-BGProcess -Process <BGProcess> [-Text] <String> [-LineTerminator <String>] [-NoLineTerminator]
 [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Write-BGProcess writes the value of "-Text" to the StandardInput stream of the
process encapsulated by the provided BGProcess object. The value of `[Environment]::NewLine`
is automatically appended to the provided text, but the line terminator can be
overridden or excluded with the "-NoLineTerminator" switch.

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

### -LineTerminator
Specifies the line ending to add to the value of the "Text" parameter. The
default value is the environment-specific value of [Environment]::NewLine.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [Environment]::NewLine
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoLineTerminator
Specifies that a line terminator should not be added automatically.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Specifies that the BGProcess object should be returned to the pipeline after
writing to the StandardInput stream.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Process
Specifies the BGProcess instance to which the value of "Text" should be written
to StandardInput.

```yaml
Type: BGProcess
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Text
Specifies the text to be written to the StandardInput stream of the process
encapsulated by the specified BGProcess instance.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### BGProcess

This cmdlet accepts a BGProcess object from the pipeline.

## OUTPUTS

### BGProcess

## NOTES

## RELATED LINKS
