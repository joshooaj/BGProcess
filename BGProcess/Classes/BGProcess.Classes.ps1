using namespace System.Management.Automation
using namespace System.Management.Automation.Runspaces
using namespace System.Threading.Tasks

class AsyncShellOutput {
    [PSDataCollection[psobject]]    $Result
    [PSDataCollection[ErrorRecord]] $ErrorStream
}

class AsyncShell {
    [powershell]   $Shell
    [IAsyncResult] $AsyncResult

    AsyncShell() {}

    AsyncShell([powershell]$powershell) {
        $this.Shell = $powershell
    }

    AsyncShell([runspace]$runspace) {
        $this.Shell = [powershell]::Create($runspace)
    }

    AsyncShell([RunspacePool]$runspacepool) {
        $this.Shell = [powershell]::Create()
        $this.Shell.RunspacePool = $runspacepool
    }

    [AsyncShellOutput] CollectResults() {
        if ($this.AsyncResult.IsCompleted) {
            try {
                return ([AsyncShellOutput]@{
                    Result      = $this.Shell.EndInvoke($this.AsyncResult)
                    ErrorStream = $this.Shell.Streams.Error
                })
            } finally {
                $this.Shell.Streams.ClearStreams()
                $this.AsyncResult = $null
            }
        }
        return $null
    }
}

class BGProcessData {
    [string]        $StandardOutput
    [string]        $StandardError
    [ErrorRecord[]] $ErrorRecords
    [bool]          $HasData
}

class BGProcessDataBuilder {
    hidden [text.stringbuilder]                    $stdOut
    hidden [text.stringbuilder]                    $stdErr
    hidden [collections.generic.list[errorrecord]] $errors
    hidden [bool]                                  $hasData
    BGProcessDataBuilder() {
        $this.stdOut = [text.stringbuilder]::new()
        $this.stdErr = [text.stringbuilder]::new()
        $this.errors = [collections.generic.list[errorrecord]]::new()
    }

    [void] AddStandardOutput([string]$data) {
        $this.stdOut.Append($data)
        $this.hasData = $true
    }

    [void] AddStandardError([string]$data) {
        $this.stdErr.Append($data)
        $this.hasData = $true
    }

    [void] AddErrorRecord([errorrecord]$errorrecord) {
        $this.errors.Add($errorrecord)
        $this.hasData = $true
    }

    [BGProcessData] ToBGProcessData() {
        return ([BGProcessData]@{
            StandardOutput = $this.stdOut.ToString()
            StandardError  = $this.stdErr.ToString()
            ErrorRecords   = $this.errors.ToArray()
            HasData        = $this.hasData
        })
    }
}


class BGProcess {
    [System.Diagnostics.Process] $Process
    [int]                        $Id
    [string]                     $Name
    [nullable[int]]              $ExitCode
    [bool]                       $HasExited

    hidden [AsyncShell]$stdOut
    hidden [AsyncShell]$StdErr

    hidden static [hashtable] $Instances = @{}

    BGProcess ([diagnostics.process]$process) {
        $this.Process = $process
        $this.Id = $process.Id
        $this.Name = $process.Name
        [BGProcess]::Instances[$process.Id] = $this

        $pool = [runspacefactory]::CreateRunspacePool(2, 2)
        $pool.Open()
        $readStream = (Get-Command -Name ReadStream).ScriptBlock
        $stdOutShell = [powershell]::Create().AddScript($readStream).AddArgument($process.StandardOutput.BaseStream)
        $stdErrShell = [powershell]::Create().AddScript($readStream).AddArgument($process.StandardError.BaseStream)
        $stdOutShell.RunspacePool = $pool
        $stdErrShell.RunspacePool = $pool

        $this.stdOut = [AsyncShell]::new($stdOutShell)
        $this.stdErr = [AsyncShell]::new($stdErrShell)
        $this.stdOut.AsyncResult = $this.stdOut.Shell.BeginInvoke()
        $this.StdErr.AsyncResult = $this.StdErr.Shell.BeginInvoke()
        Register-ObjectEvent -InputObject $this.Process -EventName Exited -Action {
            $process = $Sender -as [diagnostics.process]
            [BGProcess]::Instances[$process.Id].ExitCode = $process.ExitCode
            [BGProcess]::Instances[$process.Id].HasExited = $true
        }
    }

    [void] Write([string] $data) {
        $this.Process.StandardInput.Write($data)
    }

    [BGProcessData] Read() {
        $dataBuilder = [BGProcessDataBuilder]::new()
        while ($this.stdOut.AsyncResult.IsCompleted) {
            $results = $this.stdOut.CollectResults()
            foreach ($record in $results.Result) {
                $dataBuilder.AddStandardOutput($record)
            }
            foreach ($record in $results.ErrorStream) {
                $dataBuilder.AddErrorRecord($record)
            }
            $this.stdOut.AsyncResult = $this.stdOut.Shell.BeginInvoke()
        }
        while ($this.StdErr.AsyncResult.IsCompleted) {
            $results = $this.StdErr.CollectResults()
            foreach ($record in $results.Result) {
                $dataBuilder.AddStandardError($record)
            }
            foreach ($record in $results.ErrorStream) {
                $dataBuilder.AddErrorRecord($record)
            }
            $this.StdErr.AsyncResult = $this.StdErr.Shell.BeginInvoke()
        }
        return $dataBuilder.ToBGProcessData()
    }
}
