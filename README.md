# BGProcess

Interact with a running process using standard input/output.

## Overview

It can be complicated to read from the StandardOutput or StandardError streams
on a `[System.Diagnostics.Process]` object - especially without the risk of
blocking the terminal indefinitely.

This small module is intended to simplify reading the output of a running
process, and reacting to it by writing to the StandardInput stream. Imagine
for example that you are required to use a command-line utility which cannot
be executed with simple command-line arguments. Instead, the utility prompts
you to fill in one or more pieces of information.

With this module it is easy to read and interpret the state of the command-line
application, and supply data to the application during run-time.

## Examples

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
