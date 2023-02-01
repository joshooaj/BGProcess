---
external help file: BGProcess-help.xml
Module Name: BGProcess
online version:
schema: 2.0.0
---

# Wait-BGProcess

## SYNOPSIS
Waits for the processes to be stopped before accepting more input.

## SYNTAX

```
Wait-BGProcess [-Process] <BGProcess[]> [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
The Wait-BGProcess cmdlet waits for one or more running processes to exit.

## EXAMPLES

### Example 1
```powershell
$ping = Start-BGProcess ping 127.0.0.1 -n 10
$ping | Wait-BGProcess
$results = $ping | Read-BGProcess -Wait
```

Starts a ping to 127.0.0.1, waits until the ping.exe process exits, then reads
the results and places the text in $results.

## PARAMETERS

### -PassThru
Specifies that the BGProcess instance(s) should be returned to the pipeline after
the underlying process has stopped.

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
Specifies one or more BGProcess instances to wait for the underlying process to exit.

```yaml
Type: BGProcess[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
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
