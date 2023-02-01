---
external help file: BGProcess-help.xml
Module Name: BGProcess
online version:
schema: 2.0.0
---

# Read-BGProcess

## SYNOPSIS
Reads the redirected StandardOutput and StandardError streams for a process
without blocking.

## SYNTAX

```
Read-BGProcess [-Process] <BGProcess> [-MapErrorsToStdOut] [-Wait] [[-Timeout] <TimeSpan>] [<CommonParameters>]
```

## DESCRIPTION
When reading from StandardOutput or StandardError, it is easy to accidentally block or deadlock
the terminal. For example, if you read from these streams before there is data
available to be read, the Read call will be blocked until data is available on
that stream or the process is terminated.

This cmdlet will wait for up to Timeout seconds, or 1 second by default, before
returning with whatever data is available.

## EXAMPLES

### Example 1
```powershell
$nslookup = Start-BGProcess nslookup
$nslookup | Read-BGProcess -Wait -Timeout ([timespan]::fromseconds(3))
$nslookup | Write-BGProcess "www.powershellgallery.com" -PassThru | Read-BGProcess -Wait -MapErrorsToStdOut -Timeout ([timespan]::fromseconds(3))
```

Queries nslookup for "www.powershellgallery.com". Since the nslookup command
writes some lines to StandardError like "Non-authoritative answer:", the errors
are returned as strings along with the rest of StandardOutput.

## PARAMETERS

### -MapErrorsToStdOut
Causes any data received from the StandardError stream to be returned as a
string along with the StandardOutput data, instead of being raised as an
ErrorRecord.

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
Specifies the BGProcess instance from which to read StandardOutput and StandardError.

```yaml
Type: BGProcess
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Timeout
Specifies the amount of time to wait before giving up on receiving any (more)
data. The default is 1 second, and this parameter is only effective when used
with the -Wait switch.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Specifies that the read operation should be retried up until Timeout seconds
before returning whatever data has been received.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### BGProcess

This cmdlet accepts a BGProcess object from the pipeline.

## OUTPUTS

### System.String

This cmdlet returns zero or more strings, and zero or more ErrorRecords.

## NOTES

## RELATED LINKS
