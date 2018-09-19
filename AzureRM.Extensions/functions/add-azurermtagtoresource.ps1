<#
.SYNOPSIS
Add a tag to an Azure Resource

.DESCRIPTION
Add a tag to an Azure Resource

.PARAMETER ResourceGroupName
Name of the resource group that you want to work against

.PARAMETER TagName
Name of the tag that you want to apply to the resource

Default value is: "OrganizationName"

.PARAMETER TagValue
Value of the tag that you want to apply to the resource

.PARAMETER Name
Name of the resource that you want to work against

Support for wildcards like "DEV*"

.PARAMETER ApplyParentTags
Switch to instruct the cmdlet to pull the current tag collection
from the resource group and use that when applying on the resource

.PARAMETER WithoutTagOnly
Switch to instruct the cmdlet to only apply the tag to resources
with any tag details specified

.EXAMPLE
Add-AzureRmTagToResource -ResourceGroupName "DEV" -TagValue "CustomerA"

This will add tag "OrganizationName" with the value "CustomerA" to all
resource found in the ResourceGroup named "DEV".

.EXAMPLE 
Get-AzureRmSubscriptionExt -SubscriptionName "*DEV*" | Get-AzureRmResourceGroupExt -ResourceGroupName "*DEV*" |
 Add-AzureRmTagToResource -TagValue "CustomerA"

This will select the subscription named DEV and find the resource group name DEV,
and add the tag "OrganizationName" with the value "CustomerA" to all resources 
in the resource group.

.EXAMPLE 
Get-AzureRmSubscriptionExt -SubscriptionName "*DEV*" | Get-AzureRmResourceGroupExt -ResourceGroupName "*DEV*" |
 Add-AzureRmTagToResource -ApplyParentTags

This will select the subscription that matches the search *DEV*,
find the resource group that matches *DEV* in that subscription
and the tag collection from that ResourceGroup to all resources.

.NOTES
Author: Mötz Jensen (@splaxi)
#>
Function Add-AzureRmTagToResource {
    [CmdletBinding(DefaultParameterSetName = 'TagValue')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('ResourceGroup')]
        [string] $ResourceGroupName,

        [string] $TagName = "OrganizationName",

        [Parameter(Mandatory = $true, ParameterSetName = 'TagValue')]
        [string] $TagValue,

        [Alias('ResourceName')]
        [string] $Name = "*",

        [Parameter(Mandatory = $true, ParameterSetName = 'ParentTag')]
        [switch] $ApplyParentTags,

        [switch] $WithoutTagOnly

    )

    BEGIN {
    }

    PROCESS {
        $resGroup = Get-AzureRmResourceGroup -Name $ResourceGroupName
        
        $Tag = @{}

        Write-PSFMessage -Level Verbose -Message "Testing if we should apply parent tag (true) or not (false)." -Target ($ApplyParentTags.IsPresent)
        if ($ApplyParentTags.IsPresent) {
            $Tag = $resGroup.Tags                        
        }
        else {
            $null = $Tag.Add($TagName, $TagValue)
        }

        Write-PSFMessage -Level Verbose -Message "Testing if we should work on resources without tags (true) or all resources (false)." -Target ($WithoutTagOnly.IsPresent)
        if ($WithoutTagOnly.IsPresent) {
            $res = Get-AzureRmResource -ResourceGroupName $ResourceGroupName | Where-Object {$_.tags -eq $null -or $_.tags.Count -lt 1 -or $_.Tags.ContainsKey($TagName) -eq $false}
        }
        else {
            $res = Get-AzureRmResource -ResourceGroupName $ResourceGroupName 
        }

        foreach ($item in $res) {
            if ($item.Name -notlike $Name) {continue}

            Write-PSFMessage -Level Verbose -Message "Adding tag on $($item.Name) ($($item.ResourceId))" -Target $Tag
            Set-AzureRmResource -ResourceId $item.ResourceId -Tag $Tag -Force
        }
    }

    END {}
}
