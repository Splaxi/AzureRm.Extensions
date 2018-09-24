<#
.SYNOPSIS
Get Azure RM Resource

.DESCRIPTION
Get Azure RM Resource

.PARAMETER ResourceGroupName
Name of the resource group that you want to work against

.PARAMETER Name
Name of the resource that you want to work against

.EXAMPLE
Get-AzureRmResourceExt -ResourceGroupName "DEV"

This will get all resources from the resource group named DEV.

.EXAMPLE
Get-AzureRmSubscriptionExt -SubscriptionName "*dev*" | Get-AzureRmResourceGroupExt -ResourceGroupName "*DEV*"
 | Get-AzureRmResourceExt

This will select the subscription that matches the search *DEV*, find the resource group
that matches *DEV* in that subscription and get all resources from that.

.NOTES
Author: Mötz Jensen (@splaxi)

#>
Function Get-AzureRmResourceExt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('ResourceGroup')]
        [string] $ResourceGroupName,

        [Alias('ResourceName')]
        [string] $Name = "*"
    )

    BEGIN {
    }

    PROCESS {
        $res = Get-AzureRmResource -ResourceGroupName $ResourceGroupName

        Write-PSFMessage -Level Verbose -Message "Filtering all resources that doesn't match the name" -Target $Name
        foreach ($item in $res) {
            if ($item.Name -notlike $Name) {continue}
            $item
        }
    }

    END {}
}