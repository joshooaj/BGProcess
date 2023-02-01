---
external help file: BGProcess-help.xml
Module Name: BGProcess
online version: https://www.joshooaj.com/BGProcess/Functions/Stop-BGProcess/
schema: 2.0.0
---

# Stop-BGProcess

## SYNOPSIS
Stops one or more running processes.

## SYNTAX

```
Stop-BGProcess [-Process] <BGProcess[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Stop-BGProcess cmdlet stops one or more running processes.

## EXAMPLES

### Example 1
```powershell
$nslookup = Start-BGProcess nslookup
$nslookup | Stop-BGProcess -PassThru | Wait-BGProcess
$nslookup
```

Starts an interactive nslookup prompt, and then abruptly kills the process. Note
that the ExitCode and HasExited properties may not be updated until a second or
two has passed, but they should be updated automatically. In this case, by using
Wait-BGProcess, we know that the process has exited and the ExitCode value should
be available.

## PARAMETERS

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

### -PassThru
Specifies that the BGProcess object should be returned to the pipeline.

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
Specifies the BGProcess object to stop.

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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### BGProcess

This cmdlet accepts a BGProcess object from the pipeline.

## OUTPUTS

### BGProcess

## NOTES

## RELATED LINKS

[Online Help](https://www.joshooaj.com/BGProcess/Functions/Stop-BGProcess/)
