<#
.SYNOPSIS
Get subscription

.DESCRIPTION
Get subscription

.PARAMETER SubscriptionName
Name of the subscription you want to work against

Support for wildcards like "DEV*"

.EXAMPLE
Get-AzureRmSubscriptionExt -Name "*DEV*","*TEST*"

This will get all the subscriptions that matches the search *DEV* and *TEST*

.NOTES
Author: Mötz Jensen (@splaxi)
#>
Function Get-AzureRmSubscriptionExt {
    [CmdletBinding()]
    param(
        [Alias('Name')]
        [string[]] $SubscriptionName = "*"
    )

    BEGIN {
    }

    PROCESS {
        Write-PSFMessage -Level Verbose -Message "Prepping regex array search"
        for ($i = 0; $i -lt $SubscriptionName.Count; $i++) {
            $SubscriptionName[$i] = ".$($SubscriptionName[$i])."
        }
        
        $subs = Get-AzureRmSubscription

        $regRes = @($subs.name) -match ( $SubscriptionName -join "|")

        Write-PSFMessage -Level Verbose -Message "Filtering all subscriptions that doesn't match the name" -Target $SubscriptionName
        foreach ($item in $regRes) {
            $subs | Where-Object Name -eq $item | Select-Object
        }
    }

    END {}
    
}
