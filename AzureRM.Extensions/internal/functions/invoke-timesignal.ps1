<#
.SYNOPSIS
Handle time measurements for execution

.DESCRIPTION
Function to enable the module to measure the execution time for any function

.PARAMETER Start
Switch to instruct the function that it should set a start mark for measurement

.PARAMETER End
Switch to instruct the function that it should stop the measurement and write the total time to the log / verbose stream

.EXAMPLE
Invoke-TimeSignal -Start

This will create the first entry in the time tabel.
This will enable the function to calculate the execution.

.EXAMPLE
Invoke-TimeSignal -End

This will instruct the function to lookup the start time for the calling function and do the calculation.

.NOTES

Author: Mötz Jensen (@splaxi)

#>
function Invoke-TimeSignal {
    [CmdletBinding(DefaultParameterSetName = 'Start')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Start', Position = 1 )]
        [switch] $Start,
        
        [Parameter(Mandatory = $True, ParameterSetName = 'End', Position = 2 )]
        [switch] $End
    )
    $Time = (Get-Date)

    $Command = (Get-PSCallStack)[1].Command

    if($Start.IsPresent) {
        if($Script:TimeSignals.ContainsKey($Command)) {
            Write-PSFMessage -Level Verbose -Message "The command '$Command' is already taking part in time measurement."
        }
        else{
            $Script:TimeSignals.Add($Command, $Time)
        }
    }
    else{
        if($Script:TimeSignals.ContainsKey($Command)) {
            $TimeSpan = New-TimeSpan -End $Time -Start (($Script:TimeSignals)[$Command])

            Write-PSFMessage -Level Verbose -Message "Total time spent inside the function was $TimeSpan" -Target $TimeSpan -FunctionName $Command -Tag "TimeSignal"
            $Script:TimeSignals.Remove($Command)
        }
        else {
            Write-PSFMessage -Level Verbose -Message "The command '$Command' was never started to take part in time measurement."
        }
    }
}
