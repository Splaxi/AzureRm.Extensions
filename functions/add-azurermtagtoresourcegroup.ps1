<#
.SYNOPSIS
Add a tag to an Azure Resource Group

.DESCRIPTION
Add a tag to an Azure Resource Group

.PARAMETER ResourceGroupName
Name of the resource group that you want to work against

.PARAMETER TagName
Name of the tag that you want to apply to the resource

Default value is: "OrganizationName"

.PARAMETER TagValue
Value of the tag that you want to apply to the resource

.EXAMPLE
Add-AzureRmTagToResourceGroup -ResourceGroupName "DEV" -TagValue "CustomerA"

This will add tag "OrganizationName" with the value "CustomerA" to the
resource group named "DEV".

.EXAMPLE 
Get-AzureRmSubscriptionExt -SubscriptionName "*DEV*" | Get-AzureRmResourceGroupExt -ResourceGroupName "*DEV*" |
 Add-AzureRmTagToResourceGroup -TagValue "CustomerA"

This will select the subscription that matches the *DEV* search,
find the resource group that matches *DEV* in that subscription
and add the tag "OrganizationName" with the value "CustomerA" to it.

.NOTES
Author: Mötz Jensen (@splaxi)
#>
Function Add-AzureRmTagToResourceGroup {
    [CmdletBinding(DefaultParameterSetName = 'TagValue')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('ResourceGroup')]
        [string] $ResourceGroupName,

        [string] $TagName = "OrganizationName",

        [Parameter(Mandatory = $true, ParameterSetName = 'TagValue')]
        [string] $TagValue
    )

    BEGIN {
    }

    PROCESS {
        $resGroup = Get-AzureRmResourceGroup -Name $ResourceGroupName

        $Tag = @{}
        $null = $Tag.Add($TagName, $TagValue)

        Write-PSFMessage -Level Verbose -Message "Adding tag on $ResourceGroupName ($($resGroup.ResourceId))" -Target $Tag
        Set-AzureRmResourceGroup -Tag $Tag -Id $resGroup.ResourceId
    }

    END {}
}