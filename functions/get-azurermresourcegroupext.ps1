<#
.SYNOPSIS
Get Azure RM Resource 

.DESCRIPTION
Get Azure RM Resource

.PARAMETER SubscriptionName
Name of the Azure subscription that you want to work against

.PARAMETER ResourceGroupName
Name of the resource group that you want to work against

.PARAMETER WithoutTagOnly
Switch to instruct the cmdlet to only list resource groups without
any tag details

.EXAMPLE
Get-AzureRmResourceGroupExt -SubscriptionName "DEV" -ResourceGroupName "*DEV*"

This will get the resource group that contains the search *DEV* inside the
subscription named DEV.

.EXAMPLE
Get-AzureRmSubscriptionExt -SubscriptionName "*dev*" | Get-AzureRmResourceGroupExt -ResourceGroupName "*DEV*"

This will get the subscription that matches the search *DEV* and 
get the ResourceGroup that matches the search *DEV*.

.EXAMPLE
Get-AzureRmSubscriptionExt -SubscriptionName "*dev*" | Get-AzureRmResourceGroupExt -WithoutTagOnly

This will get the subscription that matches the search *DEV* and 
get all ResourceGroups that doesn't have a tag collection specified.

.NOTES
Author: Mötz Jensen (@splaxi)
#>
Function Get-AzureRmResourceGroupExt {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Name')]
        [string] $SubscriptionName,
        [string] $ResourceGroupName = "*",
        [switch] $WithoutTagOnly
    )
    
    BEGIN {
    }

    PROCESS {
        $sub = Get-AzureRmSubscription -SubscriptionName $SubscriptionName

        $null = Select-AzureRmSubscription -SubscriptionObject $sub

        Write-PSFMessage -Level Verbose -Message "Testing if we should work on resources without tags (true) or all resources (false)." -Target ($WithoutTagOnly.IsPresent)
        if ($WithoutTagOnly.IsPresent) {
            $resGroups = Get-AzureRmResourceGroup | Where-Object {$_.tags -eq $null -or $_.tags.Count -lt 1}
        }
        else {
            $resGroups = Get-AzureRmResourceGroup
        }

        Write-PSFMessage -Level Verbose -Message "Filtering all resource groups that doesn't match the name" -Target $ResourceGroup
        foreach ($item in $resGroups) {
            if ($item.Name -notlike $ResourceGroup) {continue}
            $item
        }
    }

    END {}

}
